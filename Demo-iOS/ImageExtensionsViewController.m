//
//  ImageExtensionsViewController.m
//  Demo-iOS
//
//  Created by William Towe on 4/11/18.
//  Copyright © 2019 Kosoku Interactive, LLC. All rights reserved.
//
//  Redistribution and use in source and binary forms, with or without modification, are permitted provided that the following conditions are met:
//
//  1. Redistributions of source code must retain the above copyright notice, this list of conditions and the following disclaimer.
//
//  2. Redistributions in binary form must reproduce the above copyright notice, this list of conditions and the following disclaimer in the documentation and/or other materials provided with the distribution.
//
//  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

#import "ImageExtensionsViewController.h"
#import "Constants.h"
#import "UIViewController+Extensions.h"

#import <Ditko/Ditko.h>
#import <Stanley/Stanley.h>
#import <KSOFontAwesomeExtensions/KSOFontAwesomeExtensions.h>

#import <MobileCoreServices/MobileCoreServices.h>

@interface ColorSwatchView : UIView
@end

@implementation ColorSwatchView
- (CGSize)intrinsicContentSize {
    return kBarButtonItemImageSize;
}
@end

@interface ImageExtensionsViewController ()
@property (weak,nonatomic) IBOutlet KDIButton *button;
@property (weak,nonatomic) IBOutlet KDIButton *inverseButton;
@property (weak,nonatomic) IBOutlet UIImageView *imageView;
@property (strong,nonatomic) UIView *barButtonItemView;
@end

@implementation ImageExtensionsViewController

- (NSString *)title {
    return [self.class detailViewTitle];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    kstWeakify(self);
    
    [self KSO_addNavigationBarTitleView];
    
    void(^presentImagePickerControllerBlock)(id,UIImagePickerControllerSourceType) = ^(id sender, UIImagePickerControllerSourceType sourceType) {
        kstStrongify(self);
        UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
        
        imagePickerController.sourceType = sourceType;
        imagePickerController.mediaTypes = @[(__bridge id)kUTTypeImage];
        
        [self KDI_presentImagePickerController:imagePickerController barButtonItem:sender sourceView:sender sourceRect:CGRectZero permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES completion:^(NSDictionary<NSString *,id> * _Nullable info) {
            UIImage *image = info.KDI_image;
            
            dispatch_async(dispatch_get_global_queue(QOS_CLASS_USER_INITIATED, 0), ^{
                UIColor *color = [image KDI_dominantColor];
                
                KSTDispatchMainAsync(^{
                    self.barButtonItemView.backgroundColor = color;
                    
                    self.imageView.image = image;
                    
                    self.view.tintColor = color;
                    self.button.backgroundColor = [color KDI_contrastingColor];
                });
            });
        }];
    };
    
    void(^chooseSourceTypeBlock)(id) = ^(id sender) {
        NSDictionary *options = @{KDIUIAlertControllerOptionsKeyStyle: @(UIAlertControllerStyleActionSheet),
                                  KDIUIAlertControllerOptionsKeyTitle: @"Action",
                                  KDIUIAlertControllerOptionsKeyMessage: @"Choose which action",
                                  KDIUIAlertControllerOptionsKeyCancelButtonTitle: @"Cancel"
                                  };
        
        [UIAlertController KDI_presentAlertControllerWithOptions:options configure:^(__kindof UIAlertController * _Nonnull alertController) {
            if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
                [alertController addAction:[UIAlertAction actionWithTitle:@"Take Photo" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                    presentImagePickerControllerBlock(sender,UIImagePickerControllerSourceTypeCamera);
                }]];
            }
            [alertController addAction:[UIAlertAction actionWithTitle:@"Choose Photo" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                presentImagePickerControllerBlock(sender,UIImagePickerControllerSourceTypePhotoLibrary);
            }]];
        } completion:nil];
    };
    
    self.button.titleEdgeInsets = UIEdgeInsetsMake(0, kSubviewMargin, 0, 0);
    self.button.contentEdgeInsets = UIEdgeInsetsMake(kSubviewMargin, kSubviewMargin, kSubviewMargin, kSubviewMargin);
    [self.button setImage:[UIImage KSO_fontAwesomeSolidImageWithString:@"\uf030" size:kBarButtonItemImageSize].KDI_templateImage forState:UIControlStateNormal];
    self.button.KDI_cornerRadius = kCornerRadius;
    [self.button KDI_addBlock:^(__kindof UIControl * _Nonnull control, UIControlEvents controlEvents) {
        chooseSourceTypeBlock(control);
    } forControlEvents:UIControlEventTouchUpInside];
    
    self.inverseButton.titleEdgeInsets = UIEdgeInsetsMake(0, kSubviewMargin, 0, 0);
    self.inverseButton.contentEdgeInsets = UIEdgeInsetsMake(kSubviewMargin, kSubviewMargin, kSubviewMargin, kSubviewMargin);
    [self.inverseButton setImage:[UIImage KSO_fontAwesomeSolidImageWithString:@"\uf03e" size:kBarButtonItemImageSize].KDI_templateImage forState:UIControlStateNormal];
    self.inverseButton.KDI_cornerRadius = kCornerRadius;
    self.inverseButton.inverted = YES;
    [self.inverseButton KDI_addBlock:^(__kindof UIControl * _Nonnull control, UIControlEvents controlEvents) {
        chooseSourceTypeBlock(control);
    } forControlEvents:UIControlEventTouchUpInside];
    
    self.barButtonItemView = [[ColorSwatchView alloc] initWithFrame:CGRectZero];
    self.barButtonItemView.translatesAutoresizingMaskIntoConstraints = NO;
    
    self.navigationItem.rightBarButtonItems = @[[[UIBarButtonItem alloc] initWithCustomView:self.barButtonItemView]];
}

+ (NSString *)detailViewTitle {
    return @"UIImage+KDIExtensions";
}
+ (NSString *)detailViewSubtitle {
    return @"UIImage dominant color additions";
}

@end
