//
//  UIAlertController+KDIExtensions.h
//  Ditko
//
//  Created by William Towe on 3/10/17.
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

NS_ASSUME_NONNULL_BEGIN

/**
 Typedef for the block that is invoked immediately before returning the alert controller. The client can further customize the alert controller.
 
 @param alertController The alert controller to configure
 */
typedef void(^KDIUIAlertControllerConfigureBlock)(__kindof UIAlertController *alertController);
/**
 Typedef for the block that is invoked after the user has tapped on one of the alert buttons and the alert controller has been dismissed.
 
 @param alertController The alert controller that was dismissed
 @param buttonIndex The index of the button that was tapped
 */
typedef void(^KDIUIAlertControllerCompletionBlock)(__kindof UIAlertController *alertController, NSInteger buttonIndex);

/**
 The constant button index used to indicate the user tapped on the cancel button.
 */
UIKIT_EXTERN NSInteger const KDIUIAlertControllerCancelButtonIndex;

/**
 Typedef for option keys to be used with KDI_alertControllerWithOptions:completion: and KDI_presentAlertControllerWithOptions:completion:.
 */
typedef NSString* KDIUIAlertControllerOptionsKey NS_STRING_ENUM;

/**
 Use this key to pass an UIAlertControllerStyle. For example, @{KDIUIAlertControllerOptionsKeyStyle: @(UIAlertControllerStyleActionSheet)}. If a value is not provided, UIAlertControllerStyleAlert is the default.
 */
UIKIT_EXTERN KDIUIAlertControllerOptionsKey const KDIUIAlertControllerOptionsKeyStyle;
/**
 Use this key to pass the alert title. For example, @{KDIUIAlertControllerOptionsKeyTitle: @"Title"}. If a value is not provided a localized default is provided.
 */
UIKIT_EXTERN KDIUIAlertControllerOptionsKey const KDIUIAlertControllerOptionsKeyTitle;
/**
 Use this key with a value of @YES to suppress the substitution of the default localized title if the provided title is zero length.
 */
UIKIT_EXTERN KDIUIAlertControllerOptionsKey const KDIUIAlertControllerOptionsKeyIgnoreEmptyTitle;
/**
 Use this key to pass the alert message. For example, @{KDIUIAlertControllerOptionsKeyMessage: @"The alert message"}. If a value is not provided a localized default is provided.
 */
UIKIT_EXTERN KDIUIAlertControllerOptionsKey const KDIUIAlertControllerOptionsKeyMessage;
/**
 Use this key with a value of @YES to suppress the substitution of the default localized message if the provided message is zero length.
 */
UIKIT_EXTERN KDIUIAlertControllerOptionsKey const KDIUIAlertControllerOptionsKeyIgnoreEmptyMessage;
/**
 Use this key to pass the cancel button title of the alert. For example, @{KDIUIAlertControllerOptionsKeyCancelButtonTitle: @"Dismiss"}. If a value is not provided a localized default is provided.
 */
UIKIT_EXTERN KDIUIAlertControllerOptionsKey const KDIUIAlertControllerOptionsKeyCancelButtonTitle;
/**
 Use this key to pass an NSArray of NSString instances for the other button titles of the alert. For example, @{KDIUIAlertControllerOptionsKeyOtherButtonTitles: @[@"First",@"Second"]}.
 */
UIKIT_EXTERN KDIUIAlertControllerOptionsKey const KDIUIAlertControllerOptionsKeyOtherButtonTitles;
/**
 Use this key to pass the preferred button title. For example, @{KDIUIAlertControllerOptionsKeyPreferredButtonTitle: @"Destroy!"}. This will be matched against the cancel and other button titles to set the alert preferredAction property.
 */
UIKIT_EXTERN KDIUIAlertControllerOptionsKey const KDIUIAlertControllerOptionsKeyPreferredButtonTitle;
/**
 Use this key to pass an NSArray of NSDictionary instances using KDIUIAlertControllerOptionsActionKey keys. For example, @{KDIUIAlertControllerOptionsKeyActions: @[@{KDIUIAlertControllerOptionsActionKeyStyle: @(UIAlertActionStyle),KDIUIAlertControllerOptionsActionKeyTitle: @"Cancel",KDIUIAlertControllerOptionsActionKeyPreferred: @YES}]}. If non-nil, this array will be used to create the UIAlertActions of the UIAlertController instead of using the KDIUIAlertControllerOptionsKeyCancelButtonTitle and KDIUIAlertControllerOptionsKeyOtherButtonTitles keys.
 */
UIKIT_EXTERN KDIUIAlertControllerOptionsKey const KDIUIAlertControllerOptionsKeyActions;
/**
 Typedef for a block that is invoked when configuring a UITextField being adding to the alert controller.
 
 @param textField The UITextField being added
 */
typedef void(^KDIUIAlertControllerTextFieldConfigurationBlock)(UITextField *textField);
/**
 Use this key to pass an NSArray of KDIUIAlertControllerTextFieldConfigurationBlock instances that will be used to add and configure the corresponding number of text fields to the alert controller.
 */
UIKIT_EXTERN KDIUIAlertControllerOptionsKey const KDIUIAlertControllerOptionsKeyTextFieldConfigurationBlocks;

/**
 Typedef for option keys to be used with the NSArray of NSDictionary instances associated with the KDIUIAlertControllerOptionsKeyActions options key.
 */
typedef NSString* KDIUIAlertControllerOptionsActionKey NS_STRING_ENUM;

/**
 Use this key to pass a UIAlertActionStyle. For example, @{KDIUIAlertControllerOptionsActionKeyStyle: @(UIAlertActionStyleDestructive)}. If a value is not provided, UIAlertActionStyleDefault is the default.
 */
UIKIT_EXTERN KDIUIAlertControllerOptionsActionKey const KDIUIAlertControllerOptionsActionKeyStyle;
/**
 Use this key to pass the title of the UIAlertAction. For example, @{KDIUIAlertControllerOptionsActionKeyTitle: @"Action Title"}.
 */
UIKIT_EXTERN KDIUIAlertControllerOptionsActionKey const KDIUIAlertControllerOptionsActionKeyTitle;
/**
 Use this key to signify that the UIAlertAction should be the preferredAction of the UIAlertController. For example, @{KDIUIAlertControllerOptionsActionKeyPreferred: @YES}. If a value is not provided, @NO is assumed.
 */
UIKIT_EXTERN KDIUIAlertControllerOptionsActionKey const KDIUIAlertControllerOptionsActionKeyPreferred;
/**
 Use this key to specify the accessibility label for the UIAlertAction, if nil the title is used.
 */
UIKIT_EXTERN KDIUIAlertControllerOptionsActionKey const KDIUIAlertControllerOptionsActionKeyAccessibilityLabel;

@interface UIAlertController (KDIExtensions)

/**
 Calls `[self KDI_presentAlertControllerWithError:completion:]`, passing error and nil respectively.
 
 @param error The error from which to create and present the alert controller
 */
+ (void)KDI_presentAlertControllerWithError:(nullable NSError *)error;
/**
 Calls `[self KDI_presentAlertControllerWithTitle:error.KST_alertTitle message:error.KST_alertMessage cancelButtonTitle:nil otherButtonTitles:nil completion:completion]`.
 
 @param error The error from which to create and present the alert controller
 @param completion The completion block to invoke after the alert controller is dismissed
 */
+ (void)KDI_presentAlertControllerWithError:(nullable NSError *)error completion:(nullable KDIUIAlertControllerCompletionBlock)completion;
/**
 Creates and presents an alert controller using the provided parameters. If you want to present the alert yourself, use `KDI_alertControllerWithTitle:message:cancelButtonTitle:otherButtonTitles:completion:` instead.
 
 @param title The title of the alert, if nil a localized default is used
 @param message The message of the alert, if nil a localized default is used
 @param cancelButtonTitle The cancel button title of the alert, if nil a localized default is used
 @param otherButtonTitles The array of other button titles to add to the receiver
 @param completion The completion block to invoke after the alert controller is dismissed
 */
+ (void)KDI_presentAlertControllerWithTitle:(nullable NSString *)title message:(nullable NSString *)message cancelButtonTitle:(nullable NSString *)cancelButtonTitle otherButtonTitles:(nullable NSArray<NSString *> *)otherButtonTitles completion:(nullable KDIUIAlertControllerCompletionBlock)completion;
/**
 Creates and presents an alert controller using the provided parameters. If you want to present the alert yourself, use `KDI_alertControllerWithTitle:message:cancelButtonTitle:otherButtonTitles:completion:` instead.
 
 @param title The title of the alert, if nil a localized default is used
 @param message The message of the alert, if nil a localized default is used
 @param cancelButtonTitle The cancel button title of the alert, if nil a localized default is used
 @param otherButtonTitles The array of other button titles to add to the receiver
 @param configure The configure that can be used to further customize the alert controller
 @param completion The completion block to invoke after the alert controller is dismissed
 */
+ (void)KDI_presentAlertControllerWithTitle:(nullable NSString *)title message:(nullable NSString *)message cancelButtonTitle:(nullable NSString *)cancelButtonTitle otherButtonTitles:(nullable NSArray<NSString *> *)otherButtonTitles configure:(nullable KDIUIAlertControllerConfigureBlock)configure completion:(nullable KDIUIAlertControllerCompletionBlock)completion;
/**
 Creates an alert using `[self KDI_alertControllerWithOptions:options completion:completion]` and presents it using `KDI_presentAlertControllerAnimated:completion:` passing YES and nil respectively. If you want to handle presenting the alert yourself, use `KDI_alertControllerWithOptions:completion:`.
 
 @param options The options used to create the UIAlertController
 @param completion The completion block invoked when the UIAlertController is dismissed
 */
+ (void)KDI_presentAlertControllerWithOptions:(NSDictionary<KDIUIAlertControllerOptionsKey, id> *)options completion:(nullable KDIUIAlertControllerCompletionBlock)completion;
/**
 Creates an alert using `[self KDI_alertControllerWithOptions:options configure:configure completion:completion]` and presents it using `KDI_presentAlertControllerAnimated:completion:` passing YES and nil respectively. If you want to handle presenting the alert yourself, use `KDI_alertControllerWithOptions:configure:completion:`.
 
 @param options The options used to create the UIAlertController
 @param configure The configure block that can be used to further customize the alert controller
 @param completion The completion block invoked when the UIAlertController is dismissed
 */
+ (void)KDI_presentAlertControllerWithOptions:(NSDictionary<KDIUIAlertControllerOptionsKey, id> *)options configure:(nullable KDIUIAlertControllerConfigureBlock)configure completion:(nullable KDIUIAlertControllerCompletionBlock)completion;

/**
 Presents the receiver modally optionally *animated* and invokes *completion* when the presentation completes.
 
 @param animated Whether to animate the presentation
 @param completion The completion block to invoke when the presentation completes
 */
- (void)KDI_presentAlertControllerAnimated:(BOOL)animated completion:(nullable dispatch_block_t)completion;

/**
 Calls `[self KDI_alertControllerWithError:completion:]`, passing error and nil respectively.
 
 @param error The error from which to create the alert controller
 @return The alert controller
 */
+ (UIAlertController *)KDI_alertControllerWithError:(nullable NSError *)error;
/**
 Calls `[self KDI_alertControllerWithTitle:message:cancelButtonTitle:otherButtonTitles:completion:]`, passing [error KST_alertTitle], [error KDI_alertMessage], nil, nil, and completion respectively.
 
 @param error The error from which to create the alert controller
 @param completion The completion block to invoke after the alert controller is dismissed
 @return The alert controller
 */
+ (UIAlertController *)KDI_alertControllerWithError:(nullable NSError *)error completion:(nullable KDIUIAlertControllerCompletionBlock)completion;
/**
 Creates and returns a alert controller using the provided parameters.
 
 @param title The title of the alert, if nil a localized default is used
 @param message The message of the alert, if nil a localized default is used
 @param cancelButtonTitle The cancel button title of the alert, if nil a localized default is used
 @param otherButtonTitles The array of other button titles to add to the receiver
 @param completion The completion block to invoke after the alert controller is dismissed
 @return The alert controller
 */
+ (UIAlertController *)KDI_alertControllerWithTitle:(nullable NSString *)title message:(nullable NSString *)message cancelButtonTitle:(nullable NSString *)cancelButtonTitle otherButtonTitles:(nullable NSArray<NSString *> *)otherButtonTitles completion:(nullable KDIUIAlertControllerCompletionBlock)completion;
/**
 Creates and returns a alert controller using the provided parameters.
 
 @param title The title of the alert, if nil a localized default is used
 @param message The message of the alert, if nil a localized default is used
 @param cancelButtonTitle The cancel button title of the alert, if nil a localized default is used
 @param otherButtonTitles The array of other button titles to add to the receiver
 @param configure The configure block that can be used to further configure the alert controller
 @param completion The completion block to invoke after the alert controller is dismissed
 @return The alert controller
 */
+ (UIAlertController *)KDI_alertControllerWithTitle:(nullable NSString *)title message:(nullable NSString *)message cancelButtonTitle:(nullable NSString *)cancelButtonTitle otherButtonTitles:(nullable NSArray<NSString *> *)otherButtonTitles configure:(nullable KDIUIAlertControllerConfigureBlock)configure completion:(nullable KDIUIAlertControllerCompletionBlock)completion;
/**
 Creates and returns a UIAlertController with the provided *options* and invokes the *completion* block when the UIAlertController is dismissed.
 
 @param options The options used to create the UIAlertController
 @param completion The completion block to invoke when the UIAlertController is dismissed
 */
+ (UIAlertController *)KDI_alertControllerWithOptions:(NSDictionary<KDIUIAlertControllerOptionsKey, id> *)options  completion:(nullable KDIUIAlertControllerCompletionBlock)completion;
/**
 Creates and returns a UIAlertController with the provided *options* and invokes the *completion* block when the UIAlertController is dismissed. The provided *configure* block can be used to further customize the alert controller.
 
 @param options The options used to create the UIAlertController
 @param configure The configure block that can be used to further customize the alert controller
 @param completion The completio block to invoke when the UIAlertController is dismissed
 */
+ (UIAlertController *)KDI_alertControllerWithOptions:(NSDictionary<KDIUIAlertControllerOptionsKey, id> *)options configure:(nullable KDIUIAlertControllerConfigureBlock)configure completion:(nullable KDIUIAlertControllerCompletionBlock)completion;

@end

NS_ASSUME_NONNULL_END
