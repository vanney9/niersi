//
//  DetailItemEditViewController.m
//  niersi
//
//  Created by vanney on 2017/3/4.
//  Copyright © 2017年 vanney9. All rights reserved.
//

#import "DetailItemEditViewController.h"
#import "InputView.h"
#import "DBItem.h"

#import <Masonry.h>



@import AVFoundation;
@import Photos;

@interface DetailItemEditViewController () <UIAlertViewDelegate, UIImagePickerControllerDelegate, UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITableView *table;
@property (nonatomic, strong) UIImagePickerController *imagePickerController;

@property (nonatomic, strong) InputView *nameView;
@property (nonatomic, strong) InputView *sizeView;
@property (nonatomic, strong) InputView *extraView;
@property (nonatomic, strong) InputView *manuView;

@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *size;
@property (nonatomic, strong) NSString *extra;
@property (nonatomic, strong) NSString *manu;
@property (nonatomic, strong) NSString *imagePath;
@property (nonatomic, strong) UIImage *finalImage;

@property (nonatomic, strong) DBItem *itemManager;

@end

@implementation DetailItemEditViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    _name = _size = _extra = _manu = _imagePath = nil;
    _finalImage = nil;
    _itemManager = [DBItem defaultManager];

    // add input view
    self.sizeView = [[InputView alloc] initWithFrame:CGRectZero];
    self.sizeView.label.text = @"尺寸";
    self.sizeView.textField.delegate = self;
    self.sizeView.textField.tag = 1002;
    [self.view addSubview:self.sizeView];
    [self.sizeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(self.view.bounds.size.width / 2);
        make.height.equalTo(@70);
        make.leading.equalTo(self.view).offset(self.view.bounds.size.width / 6);
        make.bottom.equalTo(self.view.mas_centerY).offset(-20);
    }];

    self.nameView = [[InputView alloc] initWithFrame:CGRectZero];
    self.nameView.label.text = @"型号";
    self.nameView.textField.delegate = self;
    self.nameView.textField.tag = 1001;
    [self.view addSubview:self.nameView];
    [self.nameView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(self.view.bounds.size.width / 2);
        make.height.equalTo(@70);
        make.leading.equalTo(self.view).offset(self.view.bounds.size.width / 6);
        make.bottom.equalTo(self.sizeView.mas_top).offset(-20);
    }];

    self.extraView = [[InputView alloc] initWithFrame:CGRectZero];
    self.extraView.label.text = @"备注";
    self.extraView.textField.delegate = self;
    self.extraView.textField.tag = 1003;
    [self.view addSubview:self.extraView];
    [self.extraView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(self.view.bounds.size.width / 2);
        make.height.equalTo(@70);
        make.leading.equalTo(self.view).offset(self.view.bounds.size.width / 6);
        make.top.equalTo(self.view.mas_centerY).offset(20);
    }];

    self.manuView = [[InputView alloc] initWithFrame:CGRectZero];
    self.manuView.label.text = @"产家";
    self.manuView.textField.delegate = self;
    self.manuView.textField.tag = 1004;
    [self.view addSubview:self.manuView];
    [self.manuView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(self.view.bounds.size.width / 2);
        make.height.equalTo(@70);
        make.leading.equalTo(self.view).offset(self.view.bounds.size.width / 6);
        make.top.equalTo(self.extraView.mas_bottom).offset(20);
    }];


    self.imagePickerController = [[UIImagePickerController alloc] init];
    self.imagePickerController.delegate = self;
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
    self.imagePickerController.allowsEditing = YES;
    [self presentViewController:self.imagePickerController animated:YES completion:nil];
}

- (IBAction)chooseFromPhotoLibrary:(id)sender {
    NSLog(@"vanney code log : what library");
    BOOL photoRestrict = [self checkPhotoRestrict];
    if (!photoRestrict) {
        return;
    }
    self.imagePickerController.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
    self.imagePickerController.allowsEditing = YES;
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
        UIImage *originalImage = [info objectForKey:UIImagePickerControllerOriginalImage];
        // TODO - write to Document directory and write to DB
        NSString *timestamp = [NSString stringWithFormat:@"%f", [[NSDate date] timeIntervalSince1970]];
        _imagePath = timestamp;
        NSLog(@"vanney code log : time is %@", timestamp);

        // TODO - and write to system album
        if (picker.sourceType == UIImagePickerControllerSourceTypeCamera) {
            UIImageWriteToSavedPhotosAlbum(originalImage, self, nil, NULL);
            _finalImage = editedImage;
        } else {
            _finalImage = originalImage;
        }
        NSLog(@"vanney code log : finish edit image");
    }];
}


#pragma mark - UITextField Delegate

- (void)textFieldDidEndEditing:(UITextField *)textField {
    switch (textField.tag) {
        case 1001:
            _name = textField.text;
            break;
        case 1002:
            _size = textField.text;
            break;
        case 1003:
            _extra = textField.text;
            break;
        case 1004:
            _manu = textField.text;
            break;
        default:
            break;
    }
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
    [super touchesBegan:touches withEvent:event];
}


#pragma mark - Other Click Event

- (IBAction)backVC:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)confirm:(id)sender {
    if (!_imagePath || !_finalImage) {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"照片错误，重新拍照或选择" delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:nil];
        [alertView show];
        return;
    }
    if (!_name) {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"型号不能为空" delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:nil];
        [alertView show];
        return;
    }

    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *imagePath = [NSString stringWithFormat:@"%@/%@", [paths firstObject], _imagePath];
    [UIImagePNGRepresentation(_finalImage) writeToFile:imagePath atomically:YES];

    [_itemManager insertItemWithCategoryID:_categoryID name:_name size:_size extraInfo:_extra image:_imagePath andManufacturer:_manu];
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)cancel:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

@end
