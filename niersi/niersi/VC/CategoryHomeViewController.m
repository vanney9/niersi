//
//  CategoryHomeViewController.m
//  niersi
//
//  Created by vanney on 2017/3/1.
//  Copyright © 2017年 vanney9. All rights reserved.
//

#import "CategoryHomeViewController.h"
#import "ItemCollectionViewCell.h"
#import "DetailItemViewController.h"


#define kCellIdentifier @"ItemCollectionCell"
#define kTopMargin 50.0f
#define kLeftMargin 20.0f
#define kCellWidth 240.0f
#define kCellHeight 360.0f


@interface CategoryHomeViewController () <UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>
@property (weak, nonatomic) IBOutlet UICollectionView *collection;
@end

@implementation CategoryHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _collection.delegate = self;
    _collection.dataSource = self;
    self.automaticallyAdjustsScrollViewInsets = NO;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - UICollectionView About

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 12;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    ItemCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kCellIdentifier forIndexPath:indexPath];
    cell.gakkiSelected = NO;
    return cell;
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(kTopMargin, kLeftMargin, kTopMargin, kLeftMargin);
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(kCellWidth, kCellHeight);
}

/*
 * @usage : 进入详细单品的页面，没有右上角的编辑功能
 */
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    [collectionView deselectItemAtIndexPath:indexPath animated:YES];
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    DetailItemViewController *detailItemVC = [sb instantiateViewControllerWithIdentifier:@"DetailItemVC"];
    detailItemVC.type = DetailItemVCTypeNotEdit;
    [self.navigationController pushViewController:detailItemVC animated:YES];
}


#pragma mark - other

/**
 * @usage : 返回按钮
 * @param sender
 */
- (IBAction)backVC:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

@end
