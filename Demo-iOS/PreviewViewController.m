//
//  PreviewViewController.m
//  Demo-iOS
//
//  Created by William Towe on 9/6/18.
//  Copyright © 2019 Kosoku Interactive, LLC. All rights reserved.
//
//  Licensed under the Apache License, Version 2.0 (the "License");
//  you may not use this file except in compliance with the License.
//  You may obtain a copy of the License at
//
//  http://www.apache.org/licenses/LICENSE-2.0
//
//  Unless required by applicable law or agreed to in writing, software
//  distributed under the License is distributed on an "AS IS" BASIS,
//  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
//  See the License for the specific language governing permissions and
//  limitations under the License.

#import "PreviewViewController.h"
#import "UIViewController+Extensions.h"

#import <Ditko/Ditko.h>
#import <Stanley/Stanley.h>

@interface PreviewViewController ()
@property (weak,nonatomic) IBOutlet UIButton *presentButton;
@property (weak,nonatomic) IBOutlet UIButton *pushButton;
@property (weak,nonatomic) IBOutlet UISwitch *switchControl;

@property (readonly,nonatomic) NSArray<id<QLPreviewItem>> *previewItems;
@end

@implementation PreviewViewController

- (NSString *)title {
    return [self.class detailViewTitle];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    kstWeakify(self);
    
    [self KSO_addNavigationBarTitleView];
    
    [self.presentButton KDI_addBlock:^(__kindof UIControl * _Nonnull control, UIControlEvents controlEvents) {
        kstStrongify(self);
        NSArray *previewItems = self.previewItems;
        
        [self KDI_presentPreviewControllerWithPreviewItems:previewItems initialPreviewItem:self.switchControl.isOn ? [previewItems KST_objectAtRandomIndex] : nil animated:YES completion:nil];
    } forControlEvents:UIControlEventTouchUpInside];
    
    [self.pushButton KDI_addBlock:^(__kindof UIControl * _Nonnull control, UIControlEvents controlEvents) {
        kstStrongify(self);
        NSArray *previewItems = self.previewItems;
        
        [self KDI_pushPreviewControllerWithPreviewItems:previewItems initialPreviewItem:self.switchControl.isOn ? [previewItems KST_objectAtRandomIndex] : nil animated:YES completion:nil];
    } forControlEvents:UIControlEventTouchUpInside];
}

+ (NSString *)detailViewTitle {
    return @"UIViewController+KDIQLPreviewControllerExtensions";
}
+ (NSString *)detailViewSubtitle {
    return @"Category methods to present and push";
}

- (NSArray<id<QLPreviewItem>> *)previewItems {
    NSMutableArray *retval = [[NSMutableArray alloc] init];
    NSURL *URL = [NSBundle.mainBundle URLForResource:@"Media" withExtension:@""];
    NSDirectoryEnumerator *enumerator = [NSFileManager.defaultManager enumeratorAtURL:URL includingPropertiesForKeys:nil options:NSDirectoryEnumerationSkipsSubdirectoryDescendants|NSDirectoryEnumerationSkipsHiddenFiles errorHandler:^BOOL(NSURL * _Nonnull url, NSError * _Nonnull error) {
        return YES;
    }];
    
    for (NSURL *mediaURL in enumerator) {
        [retval addObject:mediaURL];
    }
    
    return retval;
}

@end
