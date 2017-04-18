//
//  NSAlert+KDIExtensions.h
//  Ditko
//
//  Created by William Towe on 3/10/17.
//  Copyright © 2017 Kosoku Interactive, LLC. All rights reserved.
//
//  Redistribution and use in source and binary forms, with or without modification, are permitted provided that the following conditions are met:
//
//  1. Redistributions of source code must retain the above copyright notice, this list of conditions and the following disclaimer.
//
//  2. Redistributions in binary form must reproduce the above copyright notice, this list of conditions and the following disclaimer in the documentation and/or other materials provided with the distribution.
//
//  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

#import <AppKit/AppKit.h>

NS_ASSUME_NONNULL_BEGIN

/**
 Block that is invoked when the user makes a choice on a presented alert. The *returnCode* corresponds to the button that was clicked. The *suppressionButtonWasChecked* parameter will be YES if the alert was configured to show the suppression button initially and the user selected it. The *accessoryView* parameter allows the client to inspect any custom view that was provided.
 
 @param returnCode The code corresponding to the button that was clicked
 @param suppressionButtonWasChecked Whether the user selected the suppression button
 @param accessoryView The alert accessory view, if it was provided initially
 */
typedef void(^KDINSAlertCompletionBlock)(NSModalResponse returnCode, BOOL suppressionButtonWasChecked, __kindof NSView * _Nullable accessoryView);

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
 
 @param style The alert style
 @param title The alert title, this appears in bold font on the first line
 @param message The alert message, this appears in normal font on the second line
 @param cancelButtonTitle The right most button title (in left to right languages)
 @param otherButtonTitles Additional button titles that are added right to left (in left to right languages)
 @param icon A custom icon to use with the alert instead of the application icon (the default)
 @param helpAnchor The help anchor that should be displayed, if non-nil the alert will display a help button
 @param showsSuppressionButton Whether the suppression button (do not show me this again) is displayed
 @param accessoryView The accessory view that should added between the message and buttons on the alert
 @return The NSAlert instance
 */
+ (NSAlert *)KDI_alertWithStyle:(NSAlertStyle)style title:(nullable NSString *)title message:(nullable NSString *)message cancelButtonTitle:(nullable NSString *)cancelButtonTitle otherButtonTitles:(nullable NSArray<NSString *> *)otherButtonTitles icon:(nullable NSImage *)icon helpAnchor:(nullable NSString *)helpAnchor showsSuppressionButton:(BOOL)showsSuppressionButton accessoryView:(nullable NSView *)accessoryView;

@end

NS_ASSUME_NONNULL_END
