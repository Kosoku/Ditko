//
//  NSAlert+KDIExtensions.m
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

#import "NSAlert+KDIExtensions.h"
#import "NSBundle+KDIPrivateExtensions.h"
#import "NSWindow+KDIExtensions.h"

#import <Stanley/NSError+KSTExtensions.h>

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
    
    return [self KDI_alertWithStyle:NSAlertStyleWarning title:[error KST_alertTitle] message:[error KST_alertMessage] cancelButtonTitle:cancelButtonTitle otherButtonTitles:otherButtonTitles icon:nil helpAnchor:error.userInfo[NSHelpAnchorErrorKey] showsSuppressionButton:NO accessoryView:nil];
}

+ (NSAlert *)KDI_alertWithTitle:(NSString *)title message:(NSString *)message cancelButtonTitle:(NSString *)cancelButtonTitle otherButtonTitles:(NSArray<NSString *> *)otherButtonTitles; {
    return [self KDI_alertWithStyle:NSAlertStyleWarning title:title message:message cancelButtonTitle:cancelButtonTitle otherButtonTitles:otherButtonTitles icon:nil helpAnchor:nil showsSuppressionButton:NO accessoryView:nil];
}
+ (NSAlert *)KDI_alertWithTitle:(NSString *)title message:(NSString *)message cancelButtonTitle:(NSString *)cancelButtonTitle otherButtonTitles:(NSArray<NSString *> *)otherButtonTitles showsSuppressionButton:(BOOL)showsSuppressionButton {
    return [self KDI_alertWithStyle:NSAlertStyleWarning title:title message:message cancelButtonTitle:cancelButtonTitle otherButtonTitles:otherButtonTitles icon:nil helpAnchor:nil showsSuppressionButton:showsSuppressionButton accessoryView:nil];
}
+ (NSAlert *)KDI_alertWithStyle:(NSAlertStyle)style title:(NSString *)title message:(NSString *)message cancelButtonTitle:(NSString *)cancelButtonTitle otherButtonTitles:(NSArray *)otherButtonTitles showsSuppressionButton:(BOOL)showsSuppressionButton; {
    return [self KDI_alertWithStyle:style title:title message:message cancelButtonTitle:cancelButtonTitle otherButtonTitles:otherButtonTitles icon:nil helpAnchor:nil showsSuppressionButton:showsSuppressionButton accessoryView:nil];
}
+ (NSAlert *)KDI_alertWithStyle:(NSAlertStyle)style title:(NSString *)title message:(NSString *)message cancelButtonTitle:(NSString *)cancelButtonTitle otherButtonTitles:(NSArray *)otherButtonTitles icon:(NSImage *)icon helpAnchor:(NSString *)helpAnchor showsSuppressionButton:(BOOL)showsSuppressionButton accessoryView:(NSView *)accessoryView {
    if (title.length == 0) {
        title = NSError.KST_defaultAlertTitle;
    }
    
    if (message.length == 0) {
        message = NSError.KST_defaultAlertMessage;
    }
    
    if (cancelButtonTitle.length == 0) {
        if (otherButtonTitles.count == 0) {
            cancelButtonTitle = NSLocalizedStringWithDefaultValue(@"ERROR_ALERT_DEFAULT_SINGLE_CANCEL_BUTTON_TITLE", nil, [NSBundle KDI_frameworkBundle], @"Ok", @"default error alert single cancel button title");
        }
        else {
            cancelButtonTitle = NSLocalizedStringWithDefaultValue(@"ERROR_ALERT_DEFAULT_MULTIPLE_CANCEL_BUTTON_TITLE", nil, [NSBundle KDI_frameworkBundle], @"Cancel", @"default error alert multiple cancel button title");
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
