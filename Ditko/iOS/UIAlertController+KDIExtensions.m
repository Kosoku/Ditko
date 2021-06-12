//
//  UIAlertController+KDIExtensions.m
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

#import "UIAlertController+KDIExtensions.h"
#import "UIViewController+KDIExtensions.h"
#import "KDILocalizedStrings.h"

#import <Stanley/Stanley.h>

NSInteger const KDIUIAlertControllerCancelButtonIndex = -1;

KDIUIAlertControllerOptionsKey const KDIUIAlertControllerOptionsKeyStyle = @"KDIUIAlertControllerOptionsKeyStyle";
KDIUIAlertControllerOptionsKey const KDIUIAlertControllerOptionsKeyTitle = @"KDIUIAlertControllerOptionsKeyTitle";
KDIUIAlertControllerOptionsKey const KDIUIAlertControllerOptionsKeyIgnoreEmptyTitle = @"KDIUIAlertControllerOptionsKeyIgnoreEmptyTitle";
KDIUIAlertControllerOptionsKey const KDIUIAlertControllerOptionsKeyMessage = @"KDIUIAlertControllerOptionsKeyMessage";
KDIUIAlertControllerOptionsKey const KDIUIAlertControllerOptionsKeyIgnoreEmptyMessage = @"KDIUIAlertControllerOptionsKeyIgnoreEmptyMessage";
KDIUIAlertControllerOptionsKey const KDIUIAlertControllerOptionsKeyCancelButtonTitle = @"KDIUIAlertControllerOptionsKeyCancelButtonTitle";
KDIUIAlertControllerOptionsKey const KDIUIAlertControllerOptionsKeyOtherButtonTitles = @"KDIUIAlertControllerOptionsKeyOtherButtonTitles";
KDIUIAlertControllerOptionsKey const KDIUIAlertControllerOptionsKeyPreferredButtonTitle = @"KDIUIAlertControllerOptionsKeyPreferredButtonTitle";
KDIUIAlertControllerOptionsKey const KDIUIAlertControllerOptionsKeyActions = @"KDIUIAlertControllerOptionsKeyActions";
KDIUIAlertControllerOptionsKey const KDIUIAlertControllerOptionsKeyTextFieldConfigurationBlocks = @"KDIUIAlertControllerOptionsKeyTextFieldConfigurationBlocks";

KDIUIAlertControllerOptionsActionKey const KDIUIAlertControllerOptionsActionKeyStyle = @"KDIUIAlertControllerOptionsActionKeyStyle";
KDIUIAlertControllerOptionsActionKey const KDIUIAlertControllerOptionsActionKeyTitle = @"KDIUIAlertControllerOptionsActionKeyTitle";
KDIUIAlertControllerOptionsActionKey const KDIUIAlertControllerOptionsActionKeyPreferred = @"KDIUIAlertControllerOptionsActionKeyPreferred";
KDIUIAlertControllerOptionsActionKey const KDIUIAlertControllerOptionsActionKeyAccessibilityLabel = @"KDIUIAlertControllerOptionsActionKeyAccessibilityLabel";

@implementation UIAlertController (KDIExtensions)

+ (void)KDI_presentAlertControllerWithError:(nullable NSError *)error; {
    [self KDI_presentAlertControllerWithError:error completion:nil];
}
+ (void)KDI_presentAlertControllerWithError:(nullable NSError *)error completion:(nullable KDIUIAlertControllerCompletionBlock)completion; {
    [self KDI_presentAlertControllerWithTitle:error.KST_alertTitle message:error.KST_alertMessage cancelButtonTitle:nil otherButtonTitles:nil completion:completion];
}
+ (void)KDI_presentAlertControllerWithTitle:(nullable NSString *)title message:(nullable NSString *)message cancelButtonTitle:(nullable NSString *)cancelButtonTitle otherButtonTitles:(nullable NSArray *)otherButtonTitles completion:(nullable KDIUIAlertControllerCompletionBlock)completion; {
    [self KDI_presentAlertControllerWithTitle:title message:message cancelButtonTitle:cancelButtonTitle otherButtonTitles:otherButtonTitles configure:nil completion:completion];
}
+ (void)KDI_presentAlertControllerWithTitle:(nullable NSString *)title message:(nullable NSString *)message cancelButtonTitle:(nullable NSString *)cancelButtonTitle otherButtonTitles:(nullable NSArray *)otherButtonTitles configure:(nullable KDIUIAlertControllerConfigureBlock)configure completion:(nullable KDIUIAlertControllerCompletionBlock)completion; {
    UIAlertController *alertController = [self KDI_alertControllerWithTitle:title message:message cancelButtonTitle:cancelButtonTitle otherButtonTitles:otherButtonTitles configure:configure completion:completion];
    
    [alertController KDI_presentAlertControllerAnimated:YES completion:nil];
}
+ (void)KDI_presentAlertControllerWithOptions:(NSDictionary<KDIUIAlertControllerOptionsKey,id> *)options completion:(KDIUIAlertControllerCompletionBlock)completion {
    [self KDI_presentAlertControllerWithOptions:options configure:nil completion:completion];
}
+ (void)KDI_presentAlertControllerWithOptions:(NSDictionary<KDIUIAlertControllerOptionsKey,id> *)options configure:(nullable KDIUIAlertControllerConfigureBlock)configure completion:(KDIUIAlertControllerCompletionBlock)completion {
    UIAlertController *alertController = [self KDI_alertControllerWithOptions:options configure:configure completion:completion];
    
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
    return [self KDI_alertControllerWithTitle:title message:message cancelButtonTitle:cancelButtonTitle otherButtonTitles:otherButtonTitles configure:nil completion:completion];
}
+ (UIAlertController *)KDI_alertControllerWithTitle:(nullable NSString *)title message:(nullable NSString *)message cancelButtonTitle:(nullable NSString *)cancelButtonTitle otherButtonTitles:(nullable NSArray *)otherButtonTitles configure:(nullable KDIUIAlertControllerConfigureBlock)configure completion:(nullable KDIUIAlertControllerCompletionBlock)completion; {
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
    
    return [self KDI_alertControllerWithOptions:options configure:configure completion:completion];
}
+ (UIAlertController *)KDI_alertControllerWithOptions:(NSDictionary<KDIUIAlertControllerOptionsKey, id> *)options completion:(nullable KDIUIAlertControllerCompletionBlock)completion; {
    return [self KDI_alertControllerWithOptions:options configure:nil completion:completion];
}
+ (UIAlertController *)KDI_alertControllerWithOptions:(NSDictionary<KDIUIAlertControllerOptionsKey, id> *)options configure:(nullable KDIUIAlertControllerConfigureBlock)configure completion:(nullable KDIUIAlertControllerCompletionBlock)completion; {
    NSString *title = options[KDIUIAlertControllerOptionsKeyTitle];
    
    if (title.length == 0 &&
        ![options[KDIUIAlertControllerOptionsKeyIgnoreEmptyTitle] boolValue]) {
        
        title = NSError.KST_defaultAlertTitle;
    }
    
    NSString *message = options[KDIUIAlertControllerOptionsKeyMessage];
    
    if (message.length == 0 &&
        ![options[KDIUIAlertControllerOptionsKeyIgnoreEmptyMessage] boolValue]) {
        
        message = NSError.KST_defaultAlertMessage;
    }
    
    NSString *cancelButtonTitle = options[KDIUIAlertControllerOptionsKeyCancelButtonTitle];
    NSArray<NSString *> *otherButtonTitles = options[KDIUIAlertControllerOptionsKeyOtherButtonTitles];
    
    if (cancelButtonTitle.length == 0) {
        if (otherButtonTitles.count == 0) {
            cancelButtonTitle = KDILocalizedStringErrorAlertDefaultSingleCancelButtonTitle();
        }
        else {
            cancelButtonTitle = KDILocalizedStringErrorAlertDefaultMultipleCancelButtonTitle();
        }
    }
    
    UIAlertControllerStyle style = options[KDIUIAlertControllerOptionsKeyStyle] == nil ? UIAlertControllerStyleAlert : [options[KDIUIAlertControllerOptionsKeyStyle] integerValue];
    UIAlertController *retval = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:style];
    
    kstWeakify(retval);
    
    if (options[KDIUIAlertControllerOptionsKeyActions] == nil) {
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:cancelButtonTitle style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            kstStrongify(retval);
            
            if (completion != nil) {
                completion(retval,KDIUIAlertControllerCancelButtonIndex);
            }
        }];
        
        [retval addAction:cancelAction];
        
        [otherButtonTitles enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            UIAlertAction *action = [UIAlertAction actionWithTitle:obj style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                kstStrongify(retval);
                
                if (completion != nil) {
                    completion(retval,idx);
                }
            }];
            
            [retval addAction:action];
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
            NSString *cancelActionTitle = cancelActionDict[KDIUIAlertControllerOptionsActionKeyTitle];
            UIAlertAction *action = [UIAlertAction actionWithTitle:cancelActionTitle style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                kstStrongify(retval);
                
                if (completion != nil) {
                    completion(retval,KDIUIAlertControllerCancelButtonIndex);
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
            NSString *actionTitle = obj[KDIUIAlertControllerOptionsActionKeyTitle];
            UIAlertAction *action = [UIAlertAction actionWithTitle:actionTitle style:[obj[KDIUIAlertControllerOptionsActionKeyStyle] integerValue] handler:^(UIAlertAction * _Nonnull action) {
                kstStrongify(retval);
                
                if (completion != nil) {
                    completion(retval,idx);
                }
            }];
            
            if (obj[KDIUIAlertControllerOptionsActionKeyAccessibilityLabel] != nil) {
                action.accessibilityLabel = obj[KDIUIAlertControllerOptionsActionKeyAccessibilityLabel];
            }
            
            [retval addAction:action];
            
            if ([obj[KDIUIAlertControllerOptionsActionKeyPreferred] boolValue]) {
                [retval setPreferredAction:action];
            }
        }];
    }
    
    if (options[KDIUIAlertControllerOptionsKeyTextFieldConfigurationBlocks] != nil) {
        for (KDIUIAlertControllerTextFieldConfigurationBlock block in options[KDIUIAlertControllerOptionsKeyTextFieldConfigurationBlocks]) {
            [retval addTextFieldWithConfigurationHandler:block];
        }
    }
    
    if (configure != nil) {
        configure(retval);
    }
    
    if (options[KDIUIAlertControllerOptionsKeyActions] == nil) {
        for (UIAlertAction *action in retval.actions) {
            if (action.accessibilityLabel == nil) {
                action.accessibilityLabel = action.title;
            }
        }
    }
    
    return retval;
}

@end
