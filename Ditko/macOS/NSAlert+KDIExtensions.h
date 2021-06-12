//
//  NSAlert+KDIExtensions.h
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

#import <AppKit/AppKit.h>

NS_ASSUME_NONNULL_BEGIN

/**
 Block that is invoked when the user makes a choice on a presented alert. The *returnCode* corresponds to the button that was clicked. The *suppressionButtonWasChecked* parameter will be YES if the alert was configured to show the suppression button initially and the user selected it. The *accessoryView* parameter allows the client to inspect any custom view that was provided.
 
 @param returnCode The code corresponding to the button that was clicked
 @param suppressionButtonWasChecked Whether the user selected the suppression button
 @param accessoryView The alert accessory view, if it was provided initially
 */
typedef void(^KDINSAlertCompletionBlock)(NSModalResponse returnCode, BOOL suppressionButtonWasChecked, __kindof NSView * _Nullable accessoryView);

/**
 Typedef for option keys to be used with KDI_alertWithOptions:.
 */
typedef NSString* KDINSAlertOptionsKey NS_STRING_ENUM;

/**
 Use this key to pass an NSAlertStyle. For example @{KDINSAlertOptionsKeyStyle: @(NSAlertStyleWarning)}.
 */
APPKIT_EXTERN KDINSAlertOptionsKey const KDINSAlertOptionsKeyStyle;
/**
 Use this key to pass the alert title. For example @{KDINSAlertOptionsKeyTitle: @"Title"}.
 */
APPKIT_EXTERN KDINSAlertOptionsKey const KDINSAlertOptionsKeyTitle;
/**
 Use this key to pass the alert message. For example @{KDINSAlertOptionsKeyMessage: @"Message"}.
 */
APPKIT_EXTERN KDINSAlertOptionsKey const KDINSAlertOptionsKeyMessage;
/**
 Use this key to pass the cancel button title. For example @{KDINSAlertOptionsKeyCancelButtonTitle: @"Cancel"}.
 */
APPKIT_EXTERN KDINSAlertOptionsKey const KDINSAlertOptionsKeyCancelButtonTitle;
/**
 Use this key to pass an NSArray of NSString instance for the other button titles. For example @{KDINSAlertOptionsKeyOtherButtonTitles: @[@"First", @"Second"]}.
 */
APPKIT_EXTERN KDINSAlertOptionsKey const KDINSAlertOptionsKeyOtherButtonTitles;
/**
 Use this key to pass a BOOL of whether to show the suppression button. For example @{KDINSAlertOptionsKeyShowsSuppressionButton: @YES}.
 */
APPKIT_EXTERN KDINSAlertOptionsKey const KDINSAlertOptionsKeyShowsSuppressionButton;
/**
 Use this key to pass an NSImage to show on the alert instead of the default. For example @{KDINSAlertOptionsKeyIcon: icon}.
 */
APPKIT_EXTERN KDINSAlertOptionsKey const KDINSAlertOptionsKeyIcon;
/**
 Use the key to pass the help anchor that the help button will link to. For example @{KDINSAlertOptionsKeyHelpAnchor: @"helpAnchor"}.
 */
APPKIT_EXTERN KDINSAlertOptionsKey const KDINSAlertOptionsKeyHelpAnchor;
/**
 Use the key to pass the accessory view that the alert will display. For example @{KDINSAlertOptionsKeyAccessoryView: accessoryView}.
 */
APPKIT_EXTERN KDINSAlertOptionsKey const KDINSAlertOptionsKeyAccessoryView;

@interface NSAlert (KDIExtensions)

/**
 Presents the receiver modally and invokes the provided *completion* block when the modal session terminates.
 
 @param completion The completion block that is invoked when the user clicks a button
 @see KDINSAlertCompletionBlock
 */
- (void)KDI_presentAlertModallyWithCompletion:(nullable KDINSAlertCompletionBlock)completion;
/**
 Presents the receiver as a sheet on the top most attached sheet of the key window or the window itself if it has no attached sheet. Invokes the *completion* block when the user clicks one of the alert buttons.
 
 @param completion The completion block that is invoked when the user clicks a button
 @see KDINSAlertCompletionBlock
 */
- (void)KDI_presentAlertAsSheetWithCompletion:(nullable KDINSAlertCompletionBlock)completion;

/**
 Create and return a NSAlert instance from the provided error. This will check the specific user info keys defined in NSError+KSTExtensions.h for title and message as well as check for button titles using the NSLocalizedRecoveryOptionsErrorKey key.
 
 @param error The error from which to create a NSAlert instance
 @return The NSAlert instance
 */
+ (NSAlert *)KDI_alertWithError:(nullable NSError *)error;

/**
 Returns `[self KDI_alertWithStyle:NSAlertStyleWarning title:title message:message cancelButtonTitle:cancelButtonTitle otherButtonTitles:otherButtonTitles icon:nil helpAnchor:nil showsSuppressionButton:NO accessoryView:nil]`.
 
 @param title The alert title, this appears in bold font on the first line
 @param message The alert message, this appears in normal font on the second line
 @param cancelButtonTitle The right most button title (in left to right languages)
 @param otherButtonTitles Additional button titles that are added right to left (in left to right languages)
 @return The NSAlert instance
 */
+ (NSAlert *)KDI_alertWithTitle:(nullable NSString *)title message:(nullable NSString *)message cancelButtonTitle:(nullable NSString *)cancelButtonTitle otherButtonTitles:(nullable NSArray<NSString *> *)otherButtonTitles;
/**
 Returns `[self KDI_alertWithStyle:NSAlertStyleWarning title:title message:message cancelButtonTitle:cancelButtonTitle otherButtonTitles:otherButtonTitles icon:nil helpAnchor:nil showsSuppressionButton:showsSuppressionButton accessoryView:nil]`.
 
 @param title The alert title, this appears in bold font on the first line
 @param message The alert message, this appears in normal font on the second line
 @param cancelButtonTitle The right most button title (in left to right languages)
 @param otherButtonTitles Additional button titles that are added right to left (in left to right languages)
 @param showsSuppressionButton Whether the suppression button (do not show me this again) is displayed
 @return The NSAlert instance
 */
+ (NSAlert *)KDI_alertWithTitle:(nullable NSString *)title message:(nullable NSString *)message cancelButtonTitle:(nullable NSString *)cancelButtonTitle otherButtonTitles:(nullable NSArray<NSString *> *)otherButtonTitles showsSuppressionButton:(BOOL)showsSuppressionButton;
/**
 Returns `[self KDI_alertWithStyle:style title:title message:message cancelButtonTitle:cancelButtonTitle otherButtonTitles:otherButtonTitles icon:nil helpAnchor:nil showsSuppressionButton:showsSuppressionButton accessoryView:nil]`.
 
 @param style The alert style
 @param title The alert title, this appears in bold font on the first line
 @param message The alert message, this appears in normal font on the second line
 @param cancelButtonTitle The right most button title (in left to right languages)
 @param otherButtonTitles Additional button titles that are added right to left (in left to right languages)
 @param showsSuppressionButton Whether the suppression button (do not show me this again) is displayed
 @return The NSAlert instance
 */
+ (NSAlert *)KDI_alertWithStyle:(NSAlertStyle)style title:(nullable NSString *)title message:(nullable NSString *)message cancelButtonTitle:(nullable NSString *)cancelButtonTitle otherButtonTitles:(nullable NSArray<NSString *> *)otherButtonTitles showsSuppressionButton:(BOOL)showsSuppressionButton;
/**
 Creates and returns an NSAlert instance with the provided parameters. Reasonable defaults are provided where appropriate.
 
 @param options The options dictionary to use when configuring the alert
 @return The NSAlert instance
 */
+ (NSAlert *)KDI_alertWithOptions:(NSDictionary<KDINSAlertOptionsKey, id> *)options;

@end

NS_ASSUME_NONNULL_END
