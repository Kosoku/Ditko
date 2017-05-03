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

KDIUIAlertControllerOptionsKey const KDIUIAlertControllerOptionsKeyStyle = @"KDIUIAlertControllerOptionsKeyStyle";
KDIUIAlertControllerOptionsKey const KDIUIAlertControllerOptionsKeyTitle = @"KDIUIAlertControllerOptionsKeyTitle";
KDIUIAlertControllerOptionsKey const KDIUIAlertControllerOptionsKeyMessage = @"KDIUIAlertControllerOptionsKeyMessage";
KDIUIAlertControllerOptionsKey const KDIUIAlertControllerOptionsKeyCancelButtonTitle = @"KDIUIAlertControllerOptionsKeyCancelButtonTitle";
KDIUIAlertControllerOptionsKey const KDIUIAlertControllerOptionsKeyOtherButtonTitles = @"KDIUIAlertControllerOptionsKeyOtherButtonTitles";
KDIUIAlertControllerOptionsKey const KDIUIAlertControllerOptionsKeyPreferredButtonTitle = @"KDIUIAlertControllerOptionsKeyPreferredButtonTitle";
KDIUIAlertControllerOptionsKey const KDIUIAlertControllerOptionsKeyActions = @"KDIUIAlertControllerOptionsKeyActions";

KDIUIAlertControllerOptionsActionKey const KDIUIAlertControllerOptionsActionKeyStyle = @"KDIUIAlertControllerOptionsActionKeyStyle";
KDIUIAlertControllerOptionsActionKey const KDIUIAlertControllerOptionsActionKeyTitle = @"KDIUIAlertControllerOptionsActionKeyTitle";
KDIUIAlertControllerOptionsActionKey const KDIUIAlertControllerOptionsActionKeyPreferred = @"KDIUIAlertControllerOptionsActionKeyPreferred";

@implementation UIAlertController (KDIExtensions)

+ (void)KDI_presentAlertControllerWithError:(nullable NSError *)error; {
    [self KDI_presentAlertControllerWithError:error completion:nil];
}
+ (void)KDI_presentAlertControllerWithError:(nullable NSError *)error completion:(nullable KDIUIAlertControllerCompletionBlock)completion; {
    [self KDI_presentAlertControllerWithTitle:error.KST_alertTitle message:error.KST_alertMessage cancelButtonTitle:nil otherButtonTitles:nil completion:completion];
}
+ (void)KDI_presentAlertControllerWithTitle:(nullable NSString *)title message:(nullable NSString *)message cancelButtonTitle:(nullable NSString *)cancelButtonTitle otherButtonTitles:(nullable NSArray *)otherButtonTitles completion:(nullable KDIUIAlertControllerCompletionBlock)completion; {
    UIAlertController *alertController = [self KDI_alertControllerWithTitle:title message:message cancelButtonTitle:cancelButtonTitle otherButtonTitles:otherButtonTitles completion:completion];
    
    [alertController KDI_presentAlertControllerAnimated:YES completion:nil];
}
+ (void)KDI_presentAlertControllerWithOptions:(NSDictionary<KDIUIAlertControllerOptionsKey,id> *)options completion:(KDIUIAlertControllerCompletionBlock)completion {
    UIAlertController *alertController = [self KDI_alertControllerWithOptions:options completion:completion];
    
    [alertController KDI_presentAlertControllerAnimated:YES completion:nil];
}

- (void)KDI_presentAlertControllerAnimated:(BOOL)animated completion:(dispatch_block_t)completion {
    [[UIViewController KDI_viewControllerForPresenting] presentViewController:self animated:animated completion:completion];
}

+ (UIAlertController *)KDI_alertControllerWithError:(nullable NSError *)error; {
    return [self KDI_alertControllerWithError:error completion:nil];
}
+ (UIAlertController *)KDI_alertControllerWithError:(nullable NSError *)error completion:(nullable KDIUIAlertControllerCompletionBlock)completion
{
    return [self KDI_alertControllerWithTitle:error.KST_alertTitle message:error.KST_alertMessage cancelButtonTitle:nil otherButtonTitles:nil completion:completion];
}
+ (UIAlertController *)KDI_alertControllerWithTitle:(nullable NSString *)title message:(nullable NSString *)message cancelButtonTitle:(nullable NSString *)cancelButtonTitle otherButtonTitles:(nullable NSArray *)otherButtonTitles completion:(nullable KDIUIAlertControllerCompletionBlock)completion; {
    NSMutableDictionary *options = [[NSMutableDictionary alloc] init];
    
    if (title != nil) {
        [options setObject:title forKey:KDIUIAlertControllerOptionsKeyTitle];
    }
    if (message != nil) {
        [options setObject:message forKey:KDIUIAlertControllerOptionsKeyMessage];
    }
    if (cancelButtonTitle != nil) {
        [options setObject:cancelButtonTitle forKey:KDIUIAlertControllerOptionsKeyCancelButtonTitle];
    }
    if (otherButtonTitles != nil) {
        [options setObject:otherButtonTitles forKey:KDIUIAlertControllerOptionsKeyOtherButtonTitles];
    }
    
    return [self KDI_alertControllerWithOptions:options completion:completion];
}

+ (UIAlertController *)KDI_alertControllerWithOptions:(NSDictionary<KDIUIAlertControllerOptionsKey, id> *)options completion:(nullable KDIUIAlertControllerCompletionBlock)completion; {
    NSString *title = options[KDIUIAlertControllerOptionsKeyTitle];
    
    if (title.length == 0) {
        title = NSError.KST_defaultAlertTitle;
    }
    
    NSString *message = options[KDIUIAlertControllerOptionsKeyMessage];
    
    if (message.length == 0) {
        message = NSError.KST_defaultAlertMessage;
    }
    
    NSString *cancelButtonTitle = options[KDIUIAlertControllerOptionsKeyCancelButtonTitle];
    NSArray<NSString *> *otherButtonTitles = options[KDIUIAlertControllerOptionsKeyOtherButtonTitles];
    
    if (cancelButtonTitle.length == 0) {
        if (otherButtonTitles.count == 0) {
            cancelButtonTitle = NSLocalizedStringWithDefaultValue(@"ERROR_ALERT_DEFAULT_SINGLE_CANCEL_BUTTON_TITLE", nil, [NSBundle KDI_frameworkBundle], @"Ok", @"default error alert single cancel button title");
        }
        else {
            cancelButtonTitle = NSLocalizedStringWithDefaultValue(@"ERROR_ALERT_DEFAULT_MULTIPLE_CANCEL_BUTTON_TITLE", nil, [NSBundle KDI_frameworkBundle], @"Cancel", @"default error alert multiple cancel button title");
        }
    }
    
    UIAlertControllerStyle style = options[KDIUIAlertControllerOptionsKeyStyle] == nil ? UIAlertControllerStyleAlert : [options[KDIUIAlertControllerOptionsKeyStyle] integerValue];
    UIAlertController *retval = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:style];
    
    if (options[KDIUIAlertControllerOptionsKeyActions] == nil) {
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
        
        if (options[KDIUIAlertControllerOptionsKeyPreferredButtonTitle] != nil) {
            for (UIAlertAction *action in retval.actions) {
                if ([action.title isEqualToString:options[KDIUIAlertControllerOptionsKeyPreferredButtonTitle]]) {
                    [retval setPreferredAction:action];
                    break;
                }
            }
        }
    }
    else {
        NSArray<NSDictionary<KDIUIAlertControllerOptionsActionKey, id> *> *actionDicts = options[KDIUIAlertControllerOptionsKeyActions];
        NSUInteger cancelActionDictIndex = [actionDicts indexOfObjectPassingTest:^BOOL(NSDictionary<KDIUIAlertControllerOptionsActionKey,id> * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            return [obj[KDIUIAlertControllerOptionsActionKeyStyle] integerValue] == UIAlertActionStyleCancel;
        }];
        
        if (cancelActionDictIndex != NSNotFound) {
            NSDictionary<KDIUIAlertControllerOptionsActionKey, id> *cancelActionDict = actionDicts[cancelActionDictIndex];
            UIAlertAction *action = [UIAlertAction actionWithTitle:cancelActionDict[KDIUIAlertControllerOptionsActionKeyTitle] style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                if (completion != nil) {
                    completion(KDIUIAlertControllerCancelButtonIndex);
                }
            }];
            
            [retval addAction:action];
            
            if ([cancelActionDict[KDIUIAlertControllerOptionsActionKeyPreferred] boolValue]) {
                [retval setPreferredAction:action];
            }
            
            NSMutableArray *temp = [actionDicts mutableCopy];
            
            [temp removeObjectAtIndex:cancelActionDictIndex];
            
            actionDicts = [temp copy];
        }
        
        [actionDicts enumerateObjectsUsingBlock:^(NSDictionary<KDIUIAlertControllerOptionsActionKey,id> * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            UIAlertAction *action = [UIAlertAction actionWithTitle:obj[KDIUIAlertControllerOptionsActionKeyTitle] style:[obj[KDIUIAlertControllerOptionsActionKeyStyle] integerValue] handler:^(UIAlertAction * _Nonnull action) {
                if (completion != nil) {
                    completion(idx);
                }
            }];
            
            [retval addAction:action];
            
            if ([obj[KDIUIAlertControllerOptionsActionKeyPreferred] boolValue]) {
                [retval setPreferredAction:action];
            }
        }];
    }
    
    return retval;
}

@end
