//
//  UIViewController+KDIExtensions.h
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

#import <UIKit/UIKit.h>
#import <Photos/Photos.h>

NS_ASSUME_NONNULL_BEGIN

/**
 Block that is invoked when the image picker confirms or cancels selection by the user. The block is always invoked on the main thread.
 
 @param info The info dictionary populated with keys from UIImagePickerController.h
 */
typedef void(^KDIUIImagePickerControllerCompletion)(NSDictionary<NSString *,id> * _Nullable info);

@interface UIViewController (KDIUIImagePickerControllerExtensions)

/**
 Presents the *imagePickerController* optionally *animated* and invokes *completion* when the user selects/takes a photo/video or cancels.
 
 @param imagePickerController The image picker controller to present
 @param barButtonItem The bar button item to present from
 @param sourceView The source view to present from
 @param sourceRect The source rect relative to *sourceView* to present from
 @param permittedArrowDirections The permitted popover arrow directions
 @param animated Whether to animate the presentation
 @param completion The block to invoke when a selection is made or cancelled
 */
- (void)KDI_presentImagePickerController:(UIImagePickerController *)imagePickerController barButtonItem:(nullable UIBarButtonItem *)barButtonItem sourceView:(nullable UIView *)sourceView sourceRect:(CGRect)sourceRect permittedArrowDirections:(UIPopoverArrowDirection)permittedArrowDirections animated:(BOOL)animated completion:(KDIUIImagePickerControllerCompletion)completion;

@end

/**
 Convenience methods on NSDictionary to return various UIImagePickerController specific objects. These are meant to be used on the info dictionary that is returned as part of the KDIUIImagePickerControllerCompletion block.
 */
@interface NSDictionary (KDIUIImagePickerControllerExtensions)

/**
 Returns `KDI_editedImage` is non-nil, otherwise returns `KDI_originalImage`.
 */
@property (readonly,nonatomic,nullable) UIImage *KDI_image;
/**
 Returns the file URL for the `KDI_originalImage` if non-nil.
 */
@property (readonly,nonatomic,nullable) NSURL *KDI_imageURL;
/**
 Returns the edited image.
 */
@property (readonly,nonatomic,nullable) UIImage *KDI_editedImage;
/**
 Returns the original image.
 */
@property (readonly,nonatomic,nullable) UIImage *KDI_originalImage;

/**
 Returns the UTI for the media type (e.g. kUTTypeImage).
 */
@property (readonly,nonatomic,nullable) NSString *KDI_mediaType;

/**
 Returns the crop rect if an image was chosen.
 */
@property (readonly,nonatomic) CGRect KDI_cropRect;

/**
 Returns the file URL for the chosen video.
 */
@property (readonly,nonatomic,nullable) NSURL *KDI_mediaURL;

/**
 Returns the metadata dictionary for the chosen photo/video.
 */
@property (readonly,nonatomic,nullable) NSDictionary *KDI_mediaMetadata;

/**
 Returns the PHLivePhoto instance that was chosen.
 */
@property (readonly,nonatomic,nullable) PHLivePhoto *KDI_livePhoto;
/**
 Returns the PHAsset that was chosen.
 */
@property (readonly,nonatomic,nullable) PHAsset *KDI_asset;

@end

NS_ASSUME_NONNULL_END

