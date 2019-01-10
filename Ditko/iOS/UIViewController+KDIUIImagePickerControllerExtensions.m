//
//  UIViewController+KDIExtensions.m
//  Ditko-iOS
//
//  Created by William Towe on 9/24/17.
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
