//
//  WKInterfaceController+KDIExtensions.h
//  Ditko
//
//  Created by William Towe on 9/17/17.
//  Copyright © 2019 Kosoku Interactive, LLC. All rights reserved.
//
//  Redistribution and use in source and binary forms, with or without modification, are permitted provided that the following conditions are met:
//
//  1. Redistributions of source code must retain the above copyright notice, this list of conditions and the following disclaimer.
//
//  2. Redistributions in binary form must reproduce the above copyright notice, this list of conditions and the following disclaimer in the documentation and/or other materials provided with the distribution.
//
//  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

#import <WatchKit/WatchKit.h>

NS_ASSUME_NONNULL_BEGIN

/**
 Block that is invoked when the alert controller is dismissed by the user tapping on a button.
 
 @param alertAction The WKAlertAction that was selected
 @param buttonIndex The button index that was tapped
 */
typedef void(^KDIWKAlertControllerCompletionBlock)(WKAlertAction *alertAction, NSInteger buttonIndex);

/**
 The constant button index used to indicate the user tapped on the cancel button.
 */
WKI_EXTERN NSInteger const KDIWKAlertControllerCancelButtonIndex;

/**
 Typedef for option keys to be used with KDI_presentAlertControllerWithOptions:completion:.
 */
typedef NSString* KDIWKAlertControllerOptionsKey NS_STRING_ENUM;

/**
 Use this key to pass an WKAlertControllerStyle. For example, @{KDIUIAlertControllerOptionsKeyStyle: @(WKAlertControllerStyleActionSheet)}. If a value is not provided, WKAlertControllerStyleAlert is the default.
 */
WKI_EXTERN KDIWKAlertControllerOptionsKey const KDIWKAlertControllerOptionsKeyStyle;
/**
 Use this key to pass the alert title. For example, @{KDIWKAlertControllerOptionsKeyTitle: @"Title"}. If a value is not provided a localized default is provided.
 */
WKI_EXTERN KDIWKAlertControllerOptionsKey const KDIWKAlertControllerOptionsKeyTitle;
/**
 Use this key with a value of @YES to suppress the substitution of the default localized title if the provided title is zero length.
 */
WKI_EXTERN KDIWKAlertControllerOptionsKey const KDIWKAlertControllerOptionsKeyIgnoreEmptyTitle;
/**
 Use this key to pass the alert message. For example, @{KDIWKAlertControllerOptionsKeyMessage: @"The alert message"}. If a value is not provided a localized default is provided.
 */
WKI_EXTERN KDIWKAlertControllerOptionsKey const KDIWKAlertControllerOptionsKeyMessage;
/**
 Use this key with a value of @YES to suppress the substitution of the default localized message if the provided message is zero length.
 */
WKI_EXTERN KDIWKAlertControllerOptionsKey const KDIWKAlertControllerOptionsKeyIgnoreEmptyMessage;
/**
 Use this key to pass the cancel button title of the alert. For example, @{KDIWKAlertControllerOptionsKeyCancelButtonTitle: @"Dismiss"}. If a value is not provided a localized default is provided.
 */
WKI_EXTERN KDIWKAlertControllerOptionsKey const KDIWKAlertControllerOptionsKeyCancelButtonTitle;
/**
 Use this key to pass an NSArray of NSString instances for the other button titles of the alert. For example, @{KDIWKAlertControllerOptionsKeyOtherButtonTitles: @[@"First",@"Second"]}.
 */
WKI_EXTERN KDIWKAlertControllerOptionsKey const KDIWKAlertControllerOptionsKeyOtherButtonTitles;

@interface WKInterfaceController (KDIExtensions)

/**
 Calls `[self KDI_presentAlertControllerWithError:completion:]`, passing error and nil respectively.
 
 @param error The error from which to create and present the alert controller
 */
- (void)KDI_presentAlertControllerWithError:(nullable NSError *)error;
/**
 Calls `[self KDI_presentAlertControllerWithTitle:message:cancelButtonTitle:otherButtonTitles:completion:]`, passing [error KST_alertTitle], [error KDI_alertMessage], nil, nil, and completion respectively.
 
 @param error The error from which to create and present the alert controller
 @param completion The completion block to invoke after the alert controller is dismissed
 */
- (void)KDI_presentAlertControllerWithError:(nullable NSError *)error completion:(nullable KDIWKAlertControllerCompletionBlock)completion;

/**
 Presents an alert controller with the provided parameters.
 
 @param title The title of the alert, if nil a localized default is used
 @param message The message of the alert, if nil a localized default is used
 @param cancelButtonTitle The cancel button title of the alert, if nil a localized default is used
 @param otherButtonTitles The array of other button titles to add to the receiver
 @param completion The completion block to invoke after the alert controller is dismissed
 */
- (void)KDI_presentAlertControllerWithTitle:(nullable NSString *)title message:(nullable NSString *)message cancelButtonTitle:(nullable NSString *)cancelButtonTitle otherButtonTitles:(nullable NSArray<NSString *> *)otherButtonTitles completion:(nullable KDIWKAlertControllerCompletionBlock)completion;
/**
 Presents an alert controller with the provided parameters.
 
 @param style The style of the alert controller
 @param title The title of the alert, if nil a localized default is used
 @param message The message of the alert, if nil a localized default is used
 @param cancelButtonTitle The cancel button title of the alert, if nil a localized default is used
 @param otherButtonTitles The array of other button titles to add to the receiver
 @param completion The completion block to invoke after the alert controller is dismissed
 */
- (void)KDI_presentAlertControllerWithStyle:(WKAlertControllerStyle)style title:(nullable NSString *)title message:(nullable NSString *)message cancelButtonTitle:(nullable NSString *)cancelButtonTitle otherButtonTitles:(nullable NSArray<NSString *> *)otherButtonTitles completion:(nullable KDIWKAlertControllerCompletionBlock)completion;

/**
 Presents an alert controller with the provided *options* and invokes the *completion* block when the alert controller is dismissed.
 
 This is the funnel method for all other alert controller methods in this category.
 
 @param options The options used to create the UIAlertController
 @param completion The completion block to invoke when the UIAlertController is dismissed
 */
- (void)KDI_presentAlertControllerWithOptions:(NSDictionary<KDIWKAlertControllerOptionsKey, id> *)options completion:(nullable KDIWKAlertControllerCompletionBlock)completion;

@end

NS_ASSUME_NONNULL_END
