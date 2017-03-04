//
//  AddCategoryViewController.m
//  niersi
//
//  Created by vanney on 2017/2/25.
//  Copyright © 2017年 vanney9. All rights reserved.
//

#import "AddCategoryViewController.h"
#import <Masonry.h>


@interface AddCategoryViewController () <UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *table;

@end

@implementation AddCategoryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //NSLog(@"vanney code log : view did load");
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
    return 3;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 64.0f;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"test" forIndexPath:indexPath];
    cell.backgroundColor = [UIColor grayColor];
    return cell;
}




#pragma mark - other

- (IBAction)backVC:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

//- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration {
//    NSLog(@"vanney code log : will rotate");
//    [self.table setNeedsUpdateConstraints];
//}

- (void)viewWillLayoutSubviews {
    //NSLog(@"vanney code log : width is %f", [UIScreen mainScreen].bounds.size.width);
    [_table mas_updateConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.view).offset([[UIScreen mainScreen] bounds].size.width / 6);
    }];
}

@end
