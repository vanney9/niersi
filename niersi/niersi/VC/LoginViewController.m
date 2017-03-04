//
//  LoginViewController.m
//  niersi
//
//  Created by vanney on 2017/2/23.
//  Copyright © 2017年 vanney9. All rights reserved.
//

#import "LoginViewController.h"
#import "InputTableViewCell.h"
#import "EditHomeViewController.h"

#define kInputCell @"InputCell"

// TODO - KVO disable confirm button
// TODO - keyboard active textField

@interface LoginViewController () <UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UIButton *confirmButton;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.automaticallyAdjustsScrollViewInsets = NO;
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
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    InputTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kInputCell forIndexPath:indexPath];
    cell.topLine.alpha = 0.0f;
    if (indexPath.row == 0) {
        cell.label.text = @"用户名 :";
    } else {
        cell.label.text = @"密    码 :";
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 64.0f;
}

- (IBAction)backVC:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)login:(id)sender {
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    EditHomeViewController *editVC = [sb instantiateViewControllerWithIdentifier:@"EditHomeVC"];
    [self.navigationController pushViewController:editVC animated:YES];
}

@end
