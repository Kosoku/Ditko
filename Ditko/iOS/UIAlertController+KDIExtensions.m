//
//  UIAlertController+KDIExtensions.m
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

#import "UIAlertController+KDIExtensions.h"
#import "NSBundle+KDIPrivateExtensions.h"
#import "UIViewController+KDIExtensions.h"

#import <Stanley/NSError+KSTExtensions.h>

NSInteger const KDIUIAlertControllerCancelButtonIndex = -1;

@implementation UIAlertController (KDIExtensions)

+ (void)KDI_presentAlertControllerWithError:(nullable NSError *)error; {
    [self KDI_presentAlertControllerWithError:error completion:nil];
}
+ (void)KDI_presentAlertControllerWithError:(nullable NSError *)error completion:(nullable KDIUIAlertControllerCompletionBlock)completion; {
    [self KDI_presentAlertControllerWithTitle:error.KST_alertTitle message:error.KST_alertMessage cancelButtonTitle:nil otherButtonTitles:nil completion:completion];
}
+ (void)KDI_presentAlertControllerWithTitle:(nullable NSString *)title message:(nullable NSString *)message cancelButtonTitle:(nullable NSString *)cancelButtonTitle otherButtonTitles:(nullable NSArray *)otherButtonTitles completion:(nullable KDIUIAlertControllerCompletionBlock)completion; {
    UIAlertController *alertController = [self KDI_alertControllerWithTitle:title message:message cancelButtonTitle:cancelButtonTitle otherButtonTitles:otherButtonTitles completion:completion];
    
    [[UIViewController KDI_viewControllerForPresenting] presentViewController:alertController animated:YES completion:nil];
}

+ (UIAlertController *)KDI_alertControllerWithError:(nullable NSError *)error; {
    return [self KDI_alertControllerWithError:error completion:nil];
}
+ (UIAlertController *)KDI_alertControllerWithError:(nullable NSError *)error completion:(nullable KDIUIAlertControllerCompletionBlock)completion
{
    return [self KDI_alertControllerWithTitle:error.KST_alertTitle message:error.KST_alertMessage cancelButtonTitle:nil otherButtonTitles:nil completion:completion];
}
+ (UIAlertController *)KDI_alertControllerWithTitle:(nullable NSString *)title message:(nullable NSString *)message cancelButtonTitle:(nullable NSString *)cancelButtonTitle otherButtonTitles:(nullable NSArray *)otherButtonTitles completion:(nullable KDIUIAlertControllerCompletionBlock)completion; {
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
    
    UIAlertController *retval = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    
    [retval addAction:[UIAlertAction actionWithTitle:cancelButtonTitle style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        if (completion) {
            completion(KDIUIAlertControllerCancelButtonIndex);
        }
    }]];
    
    [otherButtonTitles enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [retval addAction:[UIAlertAction actionWithTitle:obj style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            if (completion) {
                completion(idx);
            }
        }]];
    }];
    
    return retval;
}

@end
