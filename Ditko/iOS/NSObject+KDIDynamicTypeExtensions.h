//
//  NSObject+KDIDynamicTypeExtensions.h
//  Ditko
//
//  Created by William Towe on 4/13/17.
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

NS_ASSUME_NONNULL_BEGIN

@protocol KDIDynamicTypeView;

@interface NSObject (KDIDynamicTypeExtensions)

/**
 Register a view to receive dynamic type notifications. The setKDI_dynamicTypeFont: method will be called automatically on the view with the updated font for the provided *textStyle*.
 
 @param dynamicTypeView The dynamic type view to register for changes
 @param textStyle The text style to use when creating fonts for the view
 */
+ (void)KDI_registerDynamicTypeView:(id<KDIDynamicTypeView>)dynamicTypeView forTextStyle:(UIFontTextStyle)textStyle;
/**
 Loops through each view and calls `[self KDI_registerDynamicTypeView:<view n> forTextStyle:textStyle]`.
 
 @param dynamicTypeViews The views to register for changes
 @param textStyle The text style to use when creating fonts for the views
 */
+ (void)KDI_registerDynamicTypeViews:(NSArray<id<KDIDynamicTypeView>> *)dynamicTypeViews forTextStyle:(UIFontTextStyle)textStyle;

/**
 Unregister a previously registered view for dynamic type changes. This is provided for the case where you want to change the textStyle a view is registered for.
 
 @param dynamicTypeView The view to unregister for changes
 */
+ (void)KDI_unregisterDynamicTypeView:(id<KDIDynamicTypeView>)dynamicTypeView;
/**
 Loops through each view and calls `[self KDI_unregisterDynamicTypeView:<view n>]`.
 
 @param dynamicTypeViews The views to unregister for changes
 */
+ (void)KDI_unregisterDynamicTypeViews:(NSArray<id<KDIDynamicTypeView>> *)dynamicTypeViews;

@end

/**
 Protocol describing an object (usually a view) for dynamic type changes.
 */
@protocol KDIDynamicTypeView <NSObject>
@required
/**
 This method will be called automatically on the object when the dynamic type content category changes.
 */
@property (strong,nonatomic) UIFont *KDI_dynamicTypeFont;
@end

@interface UILabel (KDIDynamicTypeExtensions) <KDIDynamicTypeView>
@end

@interface UIButton (KDIDynamicTypeExtensions) <KDIDynamicTypeView>
@end

@interface UITextField (KDIDynamicTypeExtensions) <KDIDynamicTypeView>
@end

@interface UITextView (KDIDynamicTypeExtensions) <KDIDynamicTypeView>
@end

NS_ASSUME_NONNULL_END
