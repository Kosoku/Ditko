//
//  UIImagePickerController+KDIExtensions.m
//  Ditko-iOS
//
//  Created by William Towe on 9/24/17.
//  Copyright © 2017 Kosoku Interactive, LLC. All rights reserved.
//
//  Redistribution and use in source and binary forms, with or without modification, are permitted provided that the following conditions are met:
//
//  1. Redistributions of source code must retain the above copyright notice, this list of conditions and the following disclaimer.
//
//  2. Redistributions in binary form must reproduce the above copyright notice, this list of conditions and the following disclaimer in the documentation and/or other materials provided with the distribution.
//
//  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

#import "UIImagePickerController+KDIExtensions.h"
#import "UIViewController+KDIExtensions.h"

#import <Stanley/Stanley.h>

#import <objc/runtime.h>

@interface KDIUIImagePickerControllerDelegate : NSObject <UIImagePickerControllerDelegate,UINavigationControllerDelegate,UIPopoverPresentationControllerDelegate>
@property (weak,nonatomic) UIImagePickerController *imagePickerController;
@property (copy,nonatomic) KDIUIImagePickerControllerCompletion completion;
- (instancetype)initWithImagePickerController:(UIImagePickerController *)imagePickerController completion:(KDIUIImagePickerControllerCompletion)completion;
@end

@implementation KDIUIImagePickerControllerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    [picker.presentingViewController dismissViewControllerAnimated:YES completion:nil];
    
    self.completion(info);
    self.completion = nil;
}
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [picker.presentingViewController dismissViewControllerAnimated:YES completion:nil];
    
    self.completion(nil);
    self.completion = nil;
}

- (void)popoverPresentationControllerDidDismissPopover:(UIPopoverPresentationController *)popoverPresentationController {
    self.completion(nil);
    self.completion = nil;
}

- (instancetype)initWithImagePickerController:(UIImagePickerController *)imagePickerController completion:(KDIUIImagePickerControllerCompletion)completion {
    if (!(self = [super init]))
        return nil;
    
    _completion = [completion copy];
    
    _imagePickerController = imagePickerController;
    [_imagePickerController setDelegate:self];
    
    if (imagePickerController.modalPresentationStyle == UIModalPresentationPopover) {
        if (imagePickerController.popoverPresentationController.delegate == nil) {
            [imagePickerController.popoverPresentationController setDelegate:self];
        }
        else {
            KSTLog(@"UIImagePickerController modalPresentationStyle set to UIModalPresentationPopover with non-nil delegate, completion block will not be called for cancel!");
        }
    }
    
    return self;
}
@end

@interface UIImagePickerController (KDIExtensionsPrivate)
@property (strong,nonatomic) KDIUIImagePickerControllerDelegate *KDI_imagePickerDelegate;
@end

@implementation UIImagePickerController (KDIExtensions)

- (void)KDI_presentImagePickerControllerAnimated:(BOOL)animated completion:(KDIUIImagePickerControllerCompletion)completion; {
    [self setKDI_imagePickerDelegate:[[KDIUIImagePickerControllerDelegate alloc] initWithImagePickerController:self completion:completion]];
    
    [[UIViewController KDI_viewControllerForPresenting] presentViewController:self animated:animated completion:nil];
}

@end

@implementation NSDictionary (KDIUIImagePickerControllerExtensions)
- (UIImage *)KDI_image {
    return self.KDI_editedImage ?: self.KDI_originalImage;
}
- (NSURL *)KDI_imageURL {
    if (@available(iOS 11.0, *)) {
        return self[UIImagePickerControllerImageURL];
    }
    else {
        return nil;
    }
}
- (UIImage *)KDI_editedImage {
    return self[UIImagePickerControllerEditedImage];
}
- (UIImage *)KDI_originalImage {
    return self[UIImagePickerControllerOriginalImage];
}

- (NSString *)KDI_mediaType {
    return self[UIImagePickerControllerMediaType];
}

- (CGRect)KDI_cropRect {
    return [self[UIImagePickerControllerCropRect] CGRectValue];
}

- (NSURL *)KDI_mediaURL {
    return self[UIImagePickerControllerMediaURL];
}

- (NSDictionary *)KDI_mediaMetadata {
    return self[UIImagePickerControllerMediaMetadata];
}

- (PHLivePhoto *)KDI_livePhoto {
    return self[UIImagePickerControllerLivePhoto];
}
- (PHAsset *)KDI_asset {
    if (@available(iOS 11.0, *)) {
        return self[UIImagePickerControllerPHAsset];
    }
    else {
        return nil;
    }
}
@end

@implementation UIImagePickerController (KDIExtensionsPrivate)
static void const *kKDI_imagePickerDelegateKey = &kKDI_imagePickerDelegateKey;
- (KDIUIImagePickerControllerDelegate *)KDI_imagePickerDelegate {
    return objc_getAssociatedObject(self, kKDI_imagePickerDelegateKey);
}
- (void)setKDI_imagePickerDelegate:(KDIUIImagePickerControllerDelegate *)KDI_imagePickerDelegate {
    objc_setAssociatedObject(self, kKDI_imagePickerDelegateKey, KDI_imagePickerDelegate, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
@end
