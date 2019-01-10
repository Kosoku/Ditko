//
//  UIViewController+KDIQLPreviewControllerExtensions.m
//  Ditko-iOS
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

#import "UIViewController+KDIQLPreviewControllerExtensions.h"
#import "UINavigationController+KDIExtensions.h"

#import <objc/runtime.h>

@interface KDIQLPreviewControllerDelegate : NSObject <QLPreviewControllerDataSource,QLPreviewControllerDelegate>
@property (copy,nonatomic) NSArray<id<QLPreviewItem>> *previewItems;
@property (weak,nonatomic) id<QLPreviewItem> initialPreviewItem;
@property (weak,nonatomic) UIViewController *viewController;
@property (assign,nonatomic) BOOL animated;
@property (copy,nonatomic) dispatch_block_t completion;
@property (strong,nonatomic) QLPreviewController *previewController;

- (instancetype)initWithPreviewItems:(NSArray<id<QLPreviewItem>> *)previewItems initialPreviewItem:(id<QLPreviewItem>)initialPreviewItem viewController:(UIViewController *)viewController animated:(BOOL)animated completion:(dispatch_block_t)completion;

- (void)presentPreviewController;
- (void)pushPreviewController;

@end

@interface UIViewController (KDIQLPreviewControllerPrivateExtensions)

@property (strong,nonatomic) KDIQLPreviewControllerDelegate *KDI_QLPreviewControllerDelegate;

@end

@implementation UIViewController (KDIQLPreviewControllerExtensions)

- (void)KDI_presentPreviewControllerWithPreviewItems:(NSArray<id<QLPreviewItem>> *)previewItems initialPreviewItem:(id<QLPreviewItem>)initialPreviewItem animated:(BOOL)animated completion:(dispatch_block_t)completion {
    self.KDI_QLPreviewControllerDelegate = [[KDIQLPreviewControllerDelegate alloc] initWithPreviewItems:previewItems initialPreviewItem:initialPreviewItem viewController:self animated:animated completion:completion];
    
    [self.KDI_QLPreviewControllerDelegate presentPreviewController];
}
- (void)KDI_pushPreviewControllerWithPreviewItems:(NSArray<id<QLPreviewItem>> *)previewItems initialPreviewItem:(id<QLPreviewItem>)initialPreviewItem animated:(BOOL)animated completion:(dispatch_block_t)completion {
    self.KDI_QLPreviewControllerDelegate = [[KDIQLPreviewControllerDelegate alloc] initWithPreviewItems:previewItems initialPreviewItem:initialPreviewItem viewController:self animated:animated completion:completion];
    
    [self.KDI_QLPreviewControllerDelegate pushPreviewController];
}

@end

@implementation UIViewController (KDIQLPreviewControllerPrivateExtensions)

static void const *kKDI_QLPreviewControllerDelegateKey = &kKDI_QLPreviewControllerDelegateKey;

@dynamic KDI_QLPreviewControllerDelegate;
- (KDIQLPreviewControllerDelegate *)KDI_QLPreviewControllerDelegate {
    return objc_getAssociatedObject(self, kKDI_QLPreviewControllerDelegateKey);
}
- (void)setKDI_QLPreviewControllerDelegate:(KDIQLPreviewControllerDelegate *)KDI_QLPreviewControllerDelegate {
    objc_setAssociatedObject(self, kKDI_QLPreviewControllerDelegateKey, KDI_QLPreviewControllerDelegate, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end

@implementation KDIQLPreviewControllerDelegate

- (NSInteger)numberOfPreviewItemsInPreviewController:(QLPreviewController *)controller {
    return self.previewItems.count;
}
- (id<QLPreviewItem>)previewController:(QLPreviewController *)controller previewItemAtIndex:(NSInteger)index {
    return self.previewItems[index];
}

- (void)previewControllerDidDismiss:(QLPreviewController *)controller {
    self.viewController.KDI_QLPreviewControllerDelegate = nil;
}

- (instancetype)initWithPreviewItems:(NSArray<id<QLPreviewItem>> *)previewItems initialPreviewItem:(id<QLPreviewItem>)initialPreviewItem viewController:(UIViewController *)viewController animated:(BOOL)animated completion:(dispatch_block_t)completion {
    if (!(self = [super init]))
        return nil;
    
    _previewItems = [previewItems copy];
    _initialPreviewItem = initialPreviewItem;
    _viewController = viewController;
    _animated = animated;
    _completion = [completion copy];
    
    _previewController = [[QLPreviewController alloc] initWithNibName:nil bundle:nil];
    _previewController.hidesBottomBarWhenPushed = YES;
    _previewController.dataSource = self;
    _previewController.delegate = self;
    
    if (_initialPreviewItem != nil) {
        _previewController.currentPreviewItemIndex = [_previewItems indexOfObject:_initialPreviewItem];
    }
    
    return self;
}

- (void)presentPreviewController; {
    [self.viewController presentViewController:self.previewController animated:self.animated completion:self.completion];
}
- (void)pushPreviewController; {
    [self.viewController.navigationController KDI_pushViewController:self.previewController animated:self.animated completion:self.completion];
}

@end
