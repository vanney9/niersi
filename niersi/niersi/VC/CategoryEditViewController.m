//
//  CategoryEditViewController.m
//  niersi
//
//  Created by vanney on 2017/3/1.
//  Copyright © 2017年 vanney9. All rights reserved.
//

#import "CategoryEditViewController.h"
#import "ItemCollectionViewCell.h"
#import "DetailItemViewController.h"
#import "DetailItemEditViewController.h"

#import "DBItem.h"
#import "ItemModel.h"

#define kCellIdentifier @"ItemCollectionCell"
#define kTopMargin 50.0f
#define kLeftMargin 20.0f
#define kCellWidth 240.0f
#define kCellHeight 360.0f

@interface CategoryEditViewController () <UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>
@property (weak, nonatomic) IBOutlet UICollectionView *collection;
@property (nonatomic, assign) BOOL selectStatus;
@property (nonatomic, strong) DBItem *itemManager;
@property (nonatomic, strong) NSMutableArray *items;
@property (nonatomic, strong) NSString *basePath;
@end

@implementation CategoryEditViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _itemManager = [DBItem defaultManager];

    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    _basePath = [paths firstObject];

    _collection.delegate = self;
    _collection.dataSource = self;
    self.automaticallyAdjustsScrollViewInsets = NO;

    _selectStatus = NO;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated {
    [self pUpdateData];
}


#pragma mark - UICollectionView about

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _items.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    ItemCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kCellIdentifier forIndexPath:indexPath];
    ItemModel *curItem = [_items objectAtIndex:indexPath.row];
    cell.itemLabel.text = curItem.name;
    NSData *imageData = [NSData dataWithContentsOfFile:[NSString stringWithFormat:@"%@/%@", _basePath, curItem.image]];
    UIImage *cellImage = [UIImage imageWithData:imageData];
    cell.imageView.image = cellImage;
    cell.imageView.contentMode = UIViewContentModeScaleAspectFit;
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
 * @usage : 选中状态，可以进行删除；没在选择的情况下，会进入详细单品的页面，可以进一步编辑
 */
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"vanney code log : out");
    if (_selectStatus) {
        NSLog(@"vanney code log : inside");
        ItemCollectionViewCell *cell = [collectionView cellForItemAtIndexPath:indexPath];
        cell.gakkiSelected = !cell.gakkiSelected;
    } else {
        UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        DetailItemViewController *detailItemVC = [sb instantiateViewControllerWithIdentifier:@"DetailItemVC"];
        detailItemVC.type = DetailItemVCTypeNotEdit;
        detailItemVC.item = [_items objectAtIndex:indexPath.row];
        [self.navigationController pushViewController:detailItemVC animated:YES];
    }
}


#pragma mark - other

/**
 * 返回按钮
 * @param sender
 */
- (IBAction)backVC:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

/**
 * 选择按钮
 * @param sender
 */
- (IBAction)selectItems:(id)sender {
    UIBarButtonItem *deleteButton = [self.navigationItem.rightBarButtonItems lastObject];
    _selectStatus = !_selectStatus;
    if (_selectStatus) {
        deleteButton.enabled = YES;
    } else {
        deleteButton.enabled = NO;
    }

}

/**
 * 删除按钮
 * @param sender
 */
- (IBAction)deleteItems:(id)sender {
}

/*
 * @usage : 进入添加单品的页面
 */
- (IBAction)addItem:(id)sender {
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    DetailItemEditViewController *destVC = [sb instantiateViewControllerWithIdentifier:@"DetailItemEditVC"];
    destVC.categoryID = _categoryID;
    [self.navigationController pushViewController:destVC animated:YES];
}


#pragma mark - Private Method

/*
 * 更新tableView
 */
- (void)pUpdateData {
    _items = [_itemManager getAllItemsByCategoryID:_categoryID];
    [_collection reloadData];
}

@end
