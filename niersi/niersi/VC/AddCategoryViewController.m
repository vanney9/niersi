//
//  AddCategoryViewController.m
//  niersi
//
//  Created by vanney on 2017/2/25.
//  Copyright © 2017年 vanney9. All rights reserved.
//

#import "AddCategoryViewController.h"
#import <Masonry.h>
#import "InputTableViewCell.h"

#import "DBCategory.h"

#define kCellIdentifier @"categoryItemCell"


@interface AddCategoryViewController () <UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITableView *table;
@property (nonatomic, strong) DBCategory *categoryManager;
@property (nonatomic, strong) NSString *categoryName;
@end

@implementation AddCategoryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //NSLog(@"vanney code log : view did load");

    _categoryManager = [DBCategory defaultManager];

    self.automaticallyAdjustsScrollViewInsets = NO;
    _table.delegate = self;
    _table.dataSource = self;
    [_table registerClass:[UITableViewCell class] forCellReuseIdentifier:@"test"];
    //_table.separatorStyle = UITableViewCellSeparatorStyleNone;
    _table.scrollEnabled = NO;

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
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 64.0f;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    InputTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kCellIdentifier forIndexPath:indexPath];
    cell.textField.delegate = self;
    return cell;
}


#pragma mark - other

- (IBAction)backVC:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewWillLayoutSubviews {
    //NSLog(@"vanney code log : width is %f", [UIScreen mainScreen].bounds.size.width);
    [_table mas_updateConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.view).offset([[UIScreen mainScreen] bounds].size.width / 6);
    }];
}


#pragma mark - UITextField About

/*
 * @usage : 点击背景 退出键盘
 */
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
    [super touchesBegan:touches withEvent:event];
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    _categoryName = textField.text;
    NSLog(@"vanney code log : end edit cate is %@", _categoryName);
}


#pragma mark - click event

- (IBAction)confirm:(id)sender {
    if (_categoryName == nil) {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"类型不能为空" delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:nil];
        [alertView show];
        return;
    }
    
    [self.categoryManager insertCategoryWithName:_categoryName];
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)cancel:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

@end
