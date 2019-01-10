//
//  UIViewController+KDIQLPreviewControllerExtensions.h
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

#import <UIKit/UIKit.h>
#import <QuickLook/QLPreviewController.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIViewController (KDIQLPreviewControllerExtensions)

/**
 Creates and presents a QLPreviewController instance on behalf of the caller with the provided *previewItems*, optionally *animated* and invokes the *completion* block when the present animation completes.
 
 The *initialPreviewItem* can be used to indicate which preview item should be initially displayed by the preview controller.
 
 @param previewItems The preview items to display
 @param initialPreviewItem The initial preview item to display, if nil, defaults to the first item
 @param animated Whether to animate the present animation
 @param completion The block that is invoked when the present animation finishes
 */
- (void)KDI_presentPreviewControllerWithPreviewItems:(NSArray<id<QLPreviewItem>> *)previewItems initialPreviewItem:(nullable id<QLPreviewItem>)initialPreviewItem animated:(BOOL)animated completion:(nullable dispatch_block_t)completion;
/**
 Creates and pushes a QLPreviewController instance on behalf of the caller with the provided *previewItems*, optionally *animated* and invokes the *completion* block when the push animation completes.
 
 The *initialPreviewItem* can be used to indicate which preview item should be initially displayed by the preview controller.
 
 @param previewItems The preview items to display
 @param initialPreviewItem The initial preview item to display, if nil, defaults to the first item
 @param animated Whether to animate the push animation
 @param completion The block that is invoked when the push animation finishes
 */
- (void)KDI_pushPreviewControllerWithPreviewItems:(NSArray<id<QLPreviewItem>> *)previewItems initialPreviewItem:(nullable id<QLPreviewItem>)initialPreviewItem animated:(BOOL)animated completion:(nullable dispatch_block_t)completion;

@end

NS_ASSUME_NONNULL_END
