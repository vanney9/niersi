//
//  DetailItemViewController.m
//  niersi
//
//  Created by vanney on 2017/3/4.
//  Copyright © 2017年 vanney9. All rights reserved.
//

#import "DetailItemViewController.h"

@interface DetailItemViewController () <UIScrollViewDelegate>
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UILabel *topLabel;
@property (weak, nonatomic) IBOutlet UILabel *midLabel;
@property (weak, nonatomic) IBOutlet UILabel *bottomLabel;

@property (nonatomic, strong) UIImageView *contentView;
@end

@implementation DetailItemViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    // disable right bar button items
    if (self.type != 1) {
        NSEnumerator *buttons = [self.navigationItem.rightBarButtonItems objectEnumerator];
        UIBarButtonItem *curButton;
        while (curButton = [buttons nextObject]) {
            curButton.title = @"";
            curButton.enabled = NO;
        }
    }

    self.contentView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"gakki"]];
    [self.scrollView addSubview:self.contentView];
    self.scrollView.contentSize = self.contentView.image.size;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - UIScrollView Delegate

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView {
    return self.contentView;
}


#pragma mark - other click event

- (IBAction)backVC:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)edit:(id)sender {

}

- (IBAction)confirm:(id)sender {

}
@end
