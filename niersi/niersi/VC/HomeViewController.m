//
//  HomeViewController.m
//  niersi
//
//  Created by vanney on 2017/2/23.
//  Copyright © 2017年 vanney9. All rights reserved.
//

#import "HomeViewController.h"
#import "LoginViewController.h"
#import "CategoryHomeViewController.h"
#import "HomeTableViewCell.h"

#import "DBCategory.h"
#import "CategoryModel.h"

#define kHomeCell @"HomeCell"

@interface HomeViewController () <UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) DBCategory *categoryManager;
@property (nonatomic, strong) NSMutableArray *categories;
@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _categoryManager = [DBCategory defaultManager];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
}

- (void)viewWillAppear:(BOOL)animated {
    [self pUpdateData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - UITableView Delegate && DataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _categories.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    HomeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kHomeCell forIndexPath:indexPath];
    CategoryModel *curCategory = [_categories objectAtIndex:indexPath.row];
    cell.cellLabel.text = curCategory.name;
    if (indexPath.row == 0) {
        cell.topLine.alpha = 0.0f;
    }

    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 64.0f;
}

/**
 * @usage : 处理首页的点击table cell事件， 进入具体category的界面
 * @param tableView
 * @param indexPath
 */
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];

    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    CategoryHomeViewController *categoryVC = [sb instantiateViewControllerWithIdentifier:@"CategoryHomeVC"];
    CategoryModel *curCategory = [_categories objectAtIndex:indexPath.row];
    categoryVC.categoryID = curCategory.id;
    [self.navigationController pushViewController:categoryVC animated:YES];
}


#pragma mark - other

/**
 * @usage : click setting into pwd controller VC
 * @param sender
 */
- (IBAction)settingButtonClicked:(id)sender {
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    LoginViewController *loginViewController = [sb instantiateViewControllerWithIdentifier:@"LoginVC"];
    [self.navigationController pushViewController:loginViewController animated:YES];
}


#pragma mark - Private Method

- (void)pUpdateData {
    _categories = [_categoryManager getAllCategories];
    [_tableView reloadData];
}

@end
