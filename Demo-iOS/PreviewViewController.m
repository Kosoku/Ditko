//
//  PreviewViewController.m
//  Demo-iOS
//
//  Created by William Towe on 9/6/18.
//  Copyright © 2018 Kosoku Interactive, LLC. All rights reserved.
//
//  Redistribution and use in source and binary forms, with or without modification, are permitted provided that the following conditions are met:
//
//  1. Redistributions of source code must retain the above copyright notice, this list of conditions and the following disclaimer.
//
//  2. Redistributions in binary form must reproduce the above copyright notice, this list of conditions and the following disclaimer in the documentation and/or other materials provided with the distribution.
//
//  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

#import "PreviewViewController.h"
#import "UIViewController+Extensions.h"

#import <Ditko/Ditko.h>
#import <Stanley/Stanley.h>

@interface PreviewViewController ()
@property (weak,nonatomic) IBOutlet UIButton *presentButton;
@property (weak,nonatomic) IBOutlet UIButton *pushButton;

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
        [self KDI_presentPreviewControllerWithPreviewItems:self.previewItems initialPreviewItem:nil animated:YES completion:nil];
    } forControlEvents:UIControlEventTouchUpInside];
    
    [self.pushButton KDI_addBlock:^(__kindof UIControl * _Nonnull control, UIControlEvents controlEvents) {
        kstStrongify(self);
        [self KDI_pushPreviewControllerWithPreviewItems:self.previewItems initialPreviewItem:nil animated:YES completion:nil];
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
