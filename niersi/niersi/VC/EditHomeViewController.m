//
//  EditHomeViewController.m
//  niersi
//
//  Created by vanney on 2017/2/25.
//  Copyright © 2017年 vanney9. All rights reserved.
//

#import "EditHomeViewController.h"
#import "HomeTableViewCell.h"
#import "AddCategoryViewController.h"
#import "CategoryEditViewController.h"

#import "CategoryModel.h"
#import "DBCategory.h"

#define kHomeCell @"HomeCell"

@interface EditHomeViewController () <UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *table;
@property (nonatomic, strong) DBCategory *categoryManager;
@property (nonatomic, strong) NSMutableArray *categories;
@end

@implementation EditHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _categoryManager = [DBCategory defaultManager];


    _table.delegate = self;
    _table.dataSource = self;
    _table.separatorStyle = UITableViewCellSeparatorStyleNone;
    _table.allowsMultipleSelectionDuringEditing = NO;
    self.automaticallyAdjustsScrollViewInsets = NO;
}

- (void)viewWillAppear:(BOOL)animated {
    [self pUpdateData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - UITableView Delegate & DataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _categories.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    HomeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kHomeCell forIndexPath:indexPath];
    CategoryModel *curCategory = [_categories objectAtIndex:indexPath.row];
    if (indexPath.row == 0) {
        cell.topLine.alpha = 0.0f;
    }

    cell.cellLabel.text = curCategory.name;
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        NSLog(@"vanney code log : nice delete");
        CategoryModel *curCategory = [_categories objectAtIndex:indexPath.row];
        [_categoryManager deleteCategoryWithID:curCategory.id];
        [self pUpdateData];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 64.0f;
}

/**
 * 进入编辑Category的界面
 * @param tableView
 * @param indexPath
 */
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];

    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    CategoryEditViewController *categoryVC = [sb instantiateViewControllerWithIdentifier:@"CategoryEditVC"];
    CategoryModel *curCategory = [_categories objectAtIndex:indexPath.row];
    categoryVC.categoryID = curCategory.id;
    [self.navigationController pushViewController:categoryVC animated:YES];
}


#pragma mark - other

- (IBAction)backVC:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)addCategory:(id)sender {
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    AddCategoryViewController *addVC = [sb instantiateViewControllerWithIdentifier:@"AddCategoryVC"];
    [self.navigationController pushViewController:addVC animated:YES];
}


#pragma mark - Private Method

- (void)pUpdateData {
    _categories = [_categoryManager getAllCategories];
    [_table reloadData];
}
@end
