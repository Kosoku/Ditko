//
//  UIImagePickerController+KDIExtensions.h
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

#import <UIKit/UIKit.h>
#import <Photos/Photos.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^KDIUIImagePickerControllerCompletion)(NSDictionary<NSString *,id> * _Nullable info);

@interface UIImagePickerController (KDIExtensions)

- (void)KDI_presentImagePickerControllerAnimated:(BOOL)animated completion:(KDIUIImagePickerControllerCompletion)completion;

@end

@interface NSDictionary (KDIUIImagePickerControllerExtensions)

@property (readonly,nonatomic,nullable) UIImage *KDI_image;
@property (readonly,nonatomic,nullable) NSURL *KDI_imageURL;
@property (readonly,nonatomic,nullable) UIImage *KDI_editedImage;
@property (readonly,nonatomic,nullable) UIImage *KDI_originalImage;

@property (readonly,nonatomic,nullable) NSString *KDI_mediaType;

@property (readonly,nonatomic) CGRect KDI_cropRect;

@property (readonly,nonatomic,nullable) NSURL *KDI_mediaURL;

@property (readonly,nonatomic,nullable) NSDictionary *KDI_mediaMetadata;

@property (readonly,nonatomic,nullable) PHLivePhoto *KDI_livePhoto;
@property (readonly,nonatomic,nullable) PHAsset *KDI_asset;

@end

NS_ASSUME_NONNULL_END

