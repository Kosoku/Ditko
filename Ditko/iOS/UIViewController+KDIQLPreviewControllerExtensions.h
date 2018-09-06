//
//  UIViewController+KDIQLPreviewControllerExtensions.h
//  Ditko-iOS
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
