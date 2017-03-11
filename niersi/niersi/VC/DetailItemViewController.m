//
//  DetailItemViewController.m
//  niersi
//
//  Created by vanney on 2017/3/4.
//  Copyright © 2017年 vanney9. All rights reserved.
//

#import "DetailItemViewController.h"

#define kNull @"(null)"

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

    NSLog(@"vanney code log : enter item detail");

    // disable right bar button items
    if (self.type != 1) {
        NSEnumerator *buttons = [self.navigationItem.rightBarButtonItems objectEnumerator];
        UIBarButtonItem *curButton;
        while (curButton = [buttons nextObject]) {
            curButton.title = @"";
            curButton.enabled = NO;
        }
    }

    NSString *imagePath = [NSString stringWithFormat:@"%@/%@", [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject], _item.image];
    UIImage *contentImage = [UIImage imageWithData:[NSData dataWithContentsOfFile:imagePath]];
    self.contentView = [[UIImageView alloc] initWithImage:contentImage];
    [self.scrollView addSubview:self.contentView];
    self.scrollView.contentSize = self.contentView.image.size;
    self.scrollView.minimumZoomScale = MIN(self.scrollView.bounds.size.width / contentImage.size.width, self.scrollView.bounds.size.height / contentImage.size.height);
    self.scrollView.maximumZoomScale = 2.0f;
    self.scrollView.zoomScale = self.scrollView.minimumZoomScale;

    _topLabel.text = [_item.name isEqualToString:kNull] ? @"" : _item.name;
    _midLabel.text = [_item.size isEqualToString:kNull] ? @"" : _item.size;
    _bottomLabel.text = [_item.extra isEqualToString:kNull] ? @"" : _item.extra;
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
