//
//  UIViewController+KDIExtensions.m
//  Ditko-iOS
//
//  Created by William Towe on 9/24/17.
//  Copyright © 2018 Kosoku Interactive, LLC. All rights reserved.
//
//  Redistribution and use in source and binary forms, with or without modification, are permitted provided that the following conditions are met:
//
//  1. Redistributions of source code must retain the above copyright notice, this list of conditions and the following disclaimer.
//
//  2. Redistributions in binary form must reproduce the above copyright notice, this list of conditions and the following disclaimer in the documentation and/or other materials provided with the distribution.
//
//  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

#import "UIViewController+KDIUIImagePickerControllerExtensions.h"
#import "UIViewController+KDIExtensions.h"

#import <Stanley/Stanley.h>

#import <objc/runtime.h>

@interface KDIUIImagePickerControllerDelegate : NSObject <UIImagePickerControllerDelegate,UINavigationControllerDelegate,UIPopoverPresentationControllerDelegate>
@property (weak,nonatomic) UIViewController *viewController;
@property (weak,nonatomic) UIImagePickerController *imagePickerController;
@property (weak,nonatomic) UIBarButtonItem *barButtonItem;
@property (weak,nonatomic) UIView *sourceView;
@property (assign,nonatomic) CGRect sourceRect;
@property (assign,nonatomic) UIPopoverArrowDirection permittedArrowDirections;
@property (assign,nonatomic) BOOL animated;
@property (copy,nonatomic) KDIUIImagePickerControllerCompletion completion;

- (instancetype)initWithViewController:(UIViewController *)viewController imagePickerController:(UIImagePickerController *)imagePickerController barButtonItem:(UIBarButtonItem *)barButtonItem sourceView:(UIView *)sourceView sourceRect:(CGRect)sourceRect permittedArrowDirections:(UIPopoverArrowDirection)permittedArrowDirections animated:(BOOL)animated completion:(KDIUIImagePickerControllerCompletion)completion;

- (void)presentImagePickerController;
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

- (instancetype)initWithViewController:(UIViewController *)viewController imagePickerController:(UIImagePickerController *)imagePickerController barButtonItem:(UIBarButtonItem *)barButtonItem sourceView:(UIView *)sourceView sourceRect:(CGRect)sourceRect permittedArrowDirections:(UIPopoverArrowDirection)permittedArrowDirections animated:(BOOL)animated completion:(KDIUIImagePickerControllerCompletion)completion; {
    if (!(self = [super init]))
        return nil;
    
    _barButtonItem = barButtonItem;
    _sourceRect = sourceRect;
    _sourceView = sourceView;
    _permittedArrowDirections = permittedArrowDirections;
    _animated = animated;
    _completion = [completion copy];
    _viewController = viewController;
    _imagePickerController = imagePickerController;
    
    [_imagePickerController setDelegate:self];
    
    return self;
}

- (void)presentImagePickerController; {
    switch (self.imagePickerController.sourceType) {
        case UIImagePickerControllerSourceTypeCamera:
            [self.viewController presentViewController:self.imagePickerController animated:self.animated completion:nil];
            break;
        case UIImagePickerControllerSourceTypePhotoLibrary:
        case UIImagePickerControllerSourceTypeSavedPhotosAlbum:
            if (self.viewController.traitCollection.userInterfaceIdiom == UIUserInterfaceIdiomPad) {
                [self.imagePickerController setModalPresentationStyle:UIModalPresentationPopover];
            }
            
            if (self.imagePickerController.modalPresentationStyle == UIModalPresentationPopover) {
                if (self.imagePickerController.popoverPresentationController.delegate != nil) {
                    KSTLog(@"popoverPresentationController delegate is non-nil, overriding");
                }
                
                [self.imagePickerController.popoverPresentationController setDelegate:self];
                
                [self.viewController KDI_presentViewControllerAsPopover:self.imagePickerController barButtonItem:self.barButtonItem sourceView:self.sourceView sourceRect:self.sourceRect permittedArrowDirections:self.permittedArrowDirections animated:self.animated completion:nil];
            }
            else {
                [self.viewController presentViewController:self.imagePickerController animated:self.animated completion:nil];
            }
            break;
        default:
            break;
    }
}
@end

@interface UIViewController (KDIUIImagePickerControllerExtensionsPrivate)
@property (strong,nonatomic) KDIUIImagePickerControllerDelegate *KDI_imagePickerDelegate;
@end

@implementation UIViewController (KDIUIImagePickerControllerExtensions)

- (void)KDI_presentImagePickerController:(UIImagePickerController *)imagePickerController barButtonItem:(UIBarButtonItem *)barButtonItem sourceView:(UIView *)sourceView sourceRect:(CGRect)sourceRect permittedArrowDirections:(UIPopoverArrowDirection)permittedArrowDirections animated:(BOOL)animated completion:(KDIUIImagePickerControllerCompletion)completion {
    [imagePickerController setKDI_imagePickerDelegate:[[KDIUIImagePickerControllerDelegate alloc] initWithViewController:self imagePickerController:imagePickerController barButtonItem:barButtonItem sourceView:sourceView sourceRect:sourceRect permittedArrowDirections:permittedArrowDirections animated:animated completion:completion]];
    
    [imagePickerController.KDI_imagePickerDelegate presentImagePickerController];
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

@implementation UIViewController (KDIUIImagePickerControllerExtensionsPrivate)
static void const *kKDI_imagePickerDelegateKey = &kKDI_imagePickerDelegateKey;
- (KDIUIImagePickerControllerDelegate *)KDI_imagePickerDelegate {
    return objc_getAssociatedObject(self, kKDI_imagePickerDelegateKey);
}
- (void)setKDI_imagePickerDelegate:(KDIUIImagePickerControllerDelegate *)KDI_imagePickerDelegate {
    objc_setAssociatedObject(self, kKDI_imagePickerDelegateKey, KDI_imagePickerDelegate, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
@end
