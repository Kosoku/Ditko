//
//  DominantTestViewController.m
//  Ditko
//
//  Created by William Towe on 5/29/17.
//  Copyright © 2017 Kosoku Interactive, LLC. All rights reserved.
//
//  Redistribution and use in source and binary forms, with or without modification, are permitted provided that the following conditions are met:
//
//  1. Redistributions of source code must retain the above copyright notice, this list of conditions and the following disclaimer.
//
//  2. Redistributions in binary form must reproduce the above copyright notice, this list of conditions and the following disclaimer in the documentation and/or other materials provided with the distribution.
//
//  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

#import "DominantTestViewController.h"

#import <Ditko/Ditko.h>
#import <Stanley/Stanley.h>
#import <KSOFontAwesomeExtensions/KSOFontAwesomeExtensions.h>

@interface DominantTestViewController () <UIImagePickerControllerDelegate,UINavigationControllerDelegate>
@property (strong,nonatomic) UIImageView *imageView;
@property (strong,nonatomic) UISegmentedControl *segmentedControl;
@property (strong,nonatomic) KDIButton *button, *inverseButton;
@end

@implementation DominantTestViewController

- (NSString *)title {
    return @"Colors";
}

- (instancetype)init {
    if (!(self = [super init]))
        return nil;
    
    [self setTabBarItem:[[UITabBarItem alloc] initWithTitle:self.title image:[[UIImage KSO_fontAwesomeImageWithIcon:(KSOFontAwesomeIcon)arc4random_uniform((uint32_t)KSO_FONT_AWESOME_ICON_TOTAL_ICONS) size:CGSizeMake(25, 25)] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate] tag:0]];
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    kstWeakify(self);
    
    [self setImageView:[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"dominant_test"]]];
    [self.imageView setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.imageView setContentMode:UIViewContentModeScaleAspectFill];
    [self.imageView setClipsToBounds:YES];
    [self.view addSubview:self.imageView];
    
    UIColor *textColor = [self.imageView.image KDI_dominantColor];
    UIColor *backgroundColor = [textColor KDI_contrastingColor];
    
    [self setButton:[[KDIButton alloc] initWithFrame:CGRectZero]];
    [self.button setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.button setTitle:@"Button Title" forState:UIControlStateNormal];
    [self.button setTitleColor:textColor forState:UIControlStateNormal];
    [self.button setBackgroundColor:backgroundColor];
    [self.button setContentEdgeInsets:UIEdgeInsetsMake(8, 8, 8, 8)];
    [self.button setRounded:YES];
    [self.view addSubview:self.button];
    
    [self setInverseButton:[[KDIButton alloc] initWithFrame:CGRectZero]];
    [self.inverseButton setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.inverseButton setTitle:@"Inverse Title" forState:UIControlStateNormal];
    [self.inverseButton setTitleColor:backgroundColor forState:UIControlStateNormal];
    [self.inverseButton setBackgroundColor:textColor];
    [self.inverseButton setContentEdgeInsets:UIEdgeInsetsMake(8, 8, 8, 8)];
    [self.inverseButton setRounded:YES];
    [self.view addSubview:self.inverseButton];
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[view]|" options:0 metrics:nil views:@{@"view": self.imageView}]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[view]|" options:0 metrics:nil views:@{@"view": self.imageView}]];
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[view]" options:0 metrics:nil views:@{@"view": self.button}]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[top]-[view]" options:0 metrics:nil views:@{@"view": self.button, @"top": self.topLayoutGuide}]];
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[subview]-[view]" options:0 metrics:nil views:@{@"view": self.inverseButton, @"subview": self.button}]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[top]-[view]" options:0 metrics:nil views:@{@"view": self.inverseButton, @"top": self.topLayoutGuide}]];
    
    UIBarButtonItem *photoItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCamera target:nil action:NULL];
    
    [photoItem setKDI_block:^(UIBarButtonItem *item){
        kstStrongify(self);
        if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
            return;
        }
        
        UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
        
        [imagePickerController setSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
        
        [self KDI_presentImagePickerController:imagePickerController barButtonItem:item sourceView:nil sourceRect:CGRectZero permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES completion:^(NSDictionary<NSString *,id> * _Nullable info) {
            kstStrongify(self);
            if (info == nil) {
                return;
            }
            
            [self.imageView setImage:info.KDI_image];
            [self.imageView startAnimating];
            
            UIColor *textColor = [self.imageView.image KDI_dominantColor];
            UIColor *backgroundColor = [textColor KDI_contrastingColor];
            
            [self.button setTitleColor:textColor forState:UIControlStateNormal];
            [self.button setBackgroundColor:backgroundColor];
            
            [self.inverseButton setTitleColor:backgroundColor forState:UIControlStateNormal];
            [self.inverseButton setBackgroundColor:textColor];
        }];
    }];
    
    [self.navigationItem setRightBarButtonItems:@[photoItem]];
}

@end
