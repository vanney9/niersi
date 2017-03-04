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

#define kHomeCell @"HomeCell"

@interface HomeViewController () <UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
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
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    HomeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kHomeCell forIndexPath:indexPath];
    cell.cellLabel.text = @"马桶";
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
@end
