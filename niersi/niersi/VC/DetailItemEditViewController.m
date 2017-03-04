//
//  DetailItemEditViewController.m
//  niersi
//
//  Created by vanney on 2017/3/4.
//  Copyright © 2017年 vanney9. All rights reserved.
//

#import "DetailItemEditViewController.h"
@import AVFoundation;
@import Photos;

@interface DetailItemEditViewController () <UIAlertViewDelegate, UIImagePickerControllerDelegate>
@property (weak, nonatomic) IBOutlet UITableView *table;

@property (nonatomic, strong) UIImagePickerController *imagePickerController;

@end

@implementation DetailItemEditViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    self.imagePickerController = [[UIImagePickerController alloc] init];
    self.imagePickerController.delegate = self;
    self.imagePickerController.allowsEditing = YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Click Event

- (IBAction)takePhoto:(id)sender {
    BOOL cameraRestrict = [self checkCameraRestrict];
    if (!cameraRestrict) {
        return;
    }
    self.imagePickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
    [self presentViewController:self.imagePickerController animated:YES completion:nil];
}

- (IBAction)chooseFromPhotoLibrary:(id)sender {
    NSLog(@"vanney code log : what library");
    BOOL photoRestrict = [self checkPhotoRestrict];
    if (!photoRestrict) {
        return;
    }
    self.imagePickerController.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
    [self presentViewController:self.imagePickerController animated:YES completion:nil];
}


#pragma mark - Restrict for Camera and Photo library

/*
 * @usage : 检查使用相片的权限
 */
- (BOOL)checkPhotoRestrict {
    if ([PHPhotoLibrary respondsToSelector:@selector(authorizationStatus)]) {
        NSLog(@"vanney code log : yaya");
        PHAuthorizationStatus status = [PHPhotoLibrary authorizationStatus];
        if (status == PHAuthorizationStatusDenied || status == PHAuthorizationStatusRestricted) {
            NSLog(@"vanney code log : inside");
            [self showTipsForRestrict:@"请在iPhone的“设置->隐私->照片”中打开本应用的访问权限" andType:1];
            return NO;
        }
    }

    return YES;
}

/*
 * @usage : 检查使用照相机的权限
 */
- (BOOL)checkCameraRestrict {
    // 判断设备是否可以拍照
    if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        [self showTipsForRestrict:@"该设备不支持拍照" andType:0];
        return NO;
    }

    if ([AVCaptureDevice respondsToSelector:@selector(authorizationStatusForMediaType:)]) {
        AVAuthorizationStatus status = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
        if (status == AVAuthorizationStatusDenied || status == AVAuthorizationStatusRestricted) {
            [self showTipsForRestrict:@"请在iPhone的“设置->隐私->相机”中打开本应用的访问权限" andType:1];
            return NO;
        }
    }

    return YES;
}

/*
 * @usage : 提示用户去权限设置中设置权限
 */
- (void)showTipsForRestrict:(NSString *)tips andType:(int)type {
    if (type == 0) {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:tips delegate:self cancelButtonTitle:@"取消" otherButtonTitles:nil];
        [alertView show];
        return;
    }
    if (floor(NSFoundationVersionNumber) > NSFoundationVersionNumber_iOS_7_1) {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:tips delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"设置", nil];
        [alertView show];
    }
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 1) {
        UIApplication *app = [UIApplication sharedApplication];
        NSURL *settingsURL = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
        if ([app canOpenURL:settingsURL]) {
            [app openURL:settingsURL];
        }
    }
}


#pragma mark - UIImagePickerController Delegate

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [picker dismissViewControllerAnimated:YES completion:nil];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *, id> *)info {
    [picker dismissViewControllerAnimated:YES completion:^{
        UIImage *editedImage = [info objectForKey:UIImagePickerControllerEditedImage];
        // TODO - write to Document directory and write to DB
        // TODO - and write to system album
        NSLog(@"vanney code log : finish edit image");
    }];
}


#pragma mark - Other Click Event

- (IBAction)backVC:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

@end
