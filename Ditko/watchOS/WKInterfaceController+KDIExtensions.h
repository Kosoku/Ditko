//
//  WKInterfaceController+KDIExtensions.h
//  Ditko
//
//  Created by William Towe on 9/17/17.
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
