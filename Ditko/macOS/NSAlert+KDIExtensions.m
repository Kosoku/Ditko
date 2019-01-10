//
//  NSAlert+KDIExtensions.m
//  Ditko
//
//  Created by William Towe on 3/10/17.
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

#import "NSAlert+KDIExtensions.h"
#import "NSBundle+KDIPrivateExtensions.h"
#import "NSWindow+KDIExtensions.h"
#import "KDILocalizedStrings.h"

#import <Stanley/NSError+KSTExtensions.h>

KDINSAlertOptionsKey const KDINSAlertOptionsKeyStyle = @"KDINSAlertOptionsKeyStyle";
KDINSAlertOptionsKey const KDINSAlertOptionsKeyTitle = @"KDINSAlertOptionsKeyTitle";
KDINSAlertOptionsKey const KDINSAlertOptionsKeyMessage = @"KDINSAlertOptionsKeyMessage";
KDINSAlertOptionsKey const KDINSAlertOptionsKeyCancelButtonTitle = @"KDINSAlertOptionsKeyCancelButtonTitle";
KDINSAlertOptionsKey const KDINSAlertOptionsKeyOtherButtonTitles = @"KDINSAlertOptionsKeyOtherButtonTitles";
KDINSAlertOptionsKey const KDINSAlertOptionsKeyShowsSuppressionButton = @"KDINSAlertOptionsKeyShowsSuppressionButton";
KDINSAlertOptionsKey const KDINSAlertOptionsKeyIcon = @"KDINSAlertOptionsKeyIcon";
KDINSAlertOptionsKey const KDINSAlertOptionsKeyHelpAnchor = @"KDINSAlertOptionsKeyHelpAnchor";
KDINSAlertOptionsKey const KDINSAlertOptionsKeyAccessoryView = @"KDINSAlertOptionsKeyAccessoryView";

@implementation NSAlert (KDIExtensions)

- (void)KDI_presentAlertModallyWithCompletion:(nullable KDINSAlertCompletionBlock)completion; {
    NSModalResponse returnCode = [self runModal];
    
    if (completion != nil) {
        completion(returnCode,self.suppressionButton.state == NSOnState,self.accessoryView);
    }
}
- (void)KDI_presentAlertAsSheetWithCompletion:(nullable KDINSAlertCompletionBlock)completion; {
    [self beginSheetModalForWindow:[NSWindow KDI_windowForPresenting] completionHandler:^(NSModalResponse returnCode) {
        if (completion != nil) {
            completion(returnCode,self.suppressionButton.state == NSOnState,self.accessoryView);
        }
    }];
}

+ (NSAlert *)KDI_alertWithError:(NSError *)error {
    NSArray *buttonTitles = error.userInfo[NSLocalizedRecoveryOptionsErrorKey];
    NSString *cancelButtonTitle = nil;
    NSArray *otherButtonTitles = nil;
    
    if (buttonTitles.count == 1) {
        cancelButtonTitle = buttonTitles.firstObject;
    }
    else if (buttonTitles.count > 1) {
        cancelButtonTitle = buttonTitles.firstObject;
        otherButtonTitles = [buttonTitles subarrayWithRange:NSMakeRange(1, buttonTitles.count - 1)];
    }
    
    return [self KDI_alertWithOptions:@{KDINSAlertOptionsKeyStyle: @(NSAlertStyleWarning),
                                        KDINSAlertOptionsKeyTitle: error.KST_alertTitle,
                                        KDINSAlertOptionsKeyMessage: error.KST_alertMessage,
                                        KDINSAlertOptionsKeyCancelButtonTitle: cancelButtonTitle ?: @"",
                                        KDINSAlertOptionsKeyOtherButtonTitles: otherButtonTitles ?: @[]}];
}

+ (NSAlert *)KDI_alertWithTitle:(NSString *)title message:(NSString *)message cancelButtonTitle:(NSString *)cancelButtonTitle otherButtonTitles:(NSArray<NSString *> *)otherButtonTitles; {
    return [self KDI_alertWithOptions:@{KDINSAlertOptionsKeyStyle: @(NSAlertStyleWarning),
                                        KDINSAlertOptionsKeyTitle: title ?: @"",
                                        KDINSAlertOptionsKeyMessage: message ?: @"",
                                        KDINSAlertOptionsKeyCancelButtonTitle: cancelButtonTitle ?: @"",
                                        KDINSAlertOptionsKeyOtherButtonTitles: otherButtonTitles ?: @[]}];
}
+ (NSAlert *)KDI_alertWithTitle:(NSString *)title message:(NSString *)message cancelButtonTitle:(NSString *)cancelButtonTitle otherButtonTitles:(NSArray<NSString *> *)otherButtonTitles showsSuppressionButton:(BOOL)showsSuppressionButton {
    return [self KDI_alertWithOptions:@{KDINSAlertOptionsKeyStyle: @(NSAlertStyleWarning),
                                        KDINSAlertOptionsKeyTitle: title ?: @"",
                                        KDINSAlertOptionsKeyMessage: message ?: @"",
                                        KDINSAlertOptionsKeyCancelButtonTitle: cancelButtonTitle ?: @"",
                                        KDINSAlertOptionsKeyOtherButtonTitles: otherButtonTitles ?: @[],
                                        KDINSAlertOptionsKeyShowsSuppressionButton: @(showsSuppressionButton)}];
}
+ (NSAlert *)KDI_alertWithStyle:(NSAlertStyle)style title:(NSString *)title message:(NSString *)message cancelButtonTitle:(NSString *)cancelButtonTitle otherButtonTitles:(NSArray *)otherButtonTitles showsSuppressionButton:(BOOL)showsSuppressionButton; {
    return [self KDI_alertWithOptions:@{KDINSAlertOptionsKeyStyle: @(style),
                                        KDINSAlertOptionsKeyTitle: title ?: @"",
                                        KDINSAlertOptionsKeyMessage: message ?: @"",
                                        KDINSAlertOptionsKeyCancelButtonTitle: cancelButtonTitle ?: @"",
                                        KDINSAlertOptionsKeyOtherButtonTitles: otherButtonTitles ?: @[],
                                        KDINSAlertOptionsKeyShowsSuppressionButton: @(showsSuppressionButton)}];
}
+ (NSAlert *)KDI_alertWithOptions:(NSDictionary<KDINSAlertOptionsKey,id> *)options {
    NSString *title = options[KDINSAlertOptionsKeyTitle];
    NSString *message = options[KDINSAlertOptionsKeyMessage];
    NSString *cancelButtonTitle = options[KDINSAlertOptionsKeyCancelButtonTitle];
    NSArray<NSString *> *otherButtonTitles = options[KDINSAlertOptionsKeyOtherButtonTitles];
    BOOL showsSuppressionButton = [options[KDINSAlertOptionsKeyShowsSuppressionButton] boolValue];
    NSImage *icon = options[KDINSAlertOptionsKeyIcon];
    NSString *helpAnchor = options[KDINSAlertOptionsKeyHelpAnchor];
    NSView *accessoryView = options[KDINSAlertOptionsKeyAccessoryView];
    
    if (title.length == 0) {
        title = NSError.KST_defaultAlertTitle;
    }
    
    if (message.length == 0) {
        message = NSError.KST_defaultAlertMessage;
    }
    
    if (cancelButtonTitle.length == 0) {
        if (otherButtonTitles.count == 0) {
            cancelButtonTitle = KDILocalizedStringErrorAlertDefaultSingleCancelButtonTitle();
        }
        else {
            cancelButtonTitle = KDILocalizedStringErrorAlertDefaultMultipleCancelButtonTitle();
        }
    }
    
    NSAlert *retval = [[NSAlert alloc] init];
    
    [retval setMessageText:title];
    [retval setInformativeText:message];
    [retval setShowsSuppressionButton:showsSuppressionButton];
    
    [retval addButtonWithTitle:cancelButtonTitle];
    
    for (NSString *buttonTitle in otherButtonTitles) {
        [retval addButtonWithTitle:buttonTitle];
    }
    
    if (icon != nil) {
        [retval setIcon:icon];
    }
    
    if (helpAnchor.length > 0) {
        [retval setShowsHelp:YES];
        [retval setHelpAnchor:helpAnchor];
    }
    
    if (accessoryView != nil) {
        [retval setAccessoryView:accessoryView];
    }
    
    return retval;
}

@end
