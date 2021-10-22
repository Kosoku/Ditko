//
//  UIViewController+KDIExtensions.h
//  Ditko-iOS
//
//  Created by William Towe on 9/24/17.
//  Copyright © 2021 Kosoku Interactive, LLC. All rights reserved.
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
#import <Photos/Photos.h>

NS_ASSUME_NONNULL_BEGIN

/**
 Block that is invoked when the image picker confirms or cancels selection by the user. The block is always invoked on the main thread.
 
 @param info The info dictionary populated with keys from UIImagePickerController.h
 */
typedef void(^KDIUIImagePickerControllerCompletion)(NSDictionary<UIImagePickerControllerInfoKey, id> * _Nullable info);

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
- (void)KDI_presentImagePickerController:(UIImagePickerController *)imagePickerController barButtonItem:(nullable UIBarButtonItem *)barButtonItem sourceView:(nullable UIView *)sourceView sourceRect:(CGRect)sourceRect permittedArrowDirections:(UIPopoverArrowDirection)permittedArrowDirections animated:(BOOL)animated completion:(KDIUIImagePickerControllerCompletion)completion NS_REFINED_FOR_SWIFT;

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

