//
//  WKInterfaceController+KDIExtensions.m
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

#import "WKInterfaceController+KDIExtensions.h"
#import "KDILocalizedStrings.h"

#import <Stanley/Stanley.h>

NSInteger const KDIWKAlertControllerCancelButtonIndex = -1;

KDIWKAlertControllerOptionsKey const KDIWKAlertControllerOptionsKeyStyle = @"KDIWKAlertControllerOptionsKeyStyle";
KDIWKAlertControllerOptionsKey const KDIWKAlertControllerOptionsKeyTitle = @"KDIWKAlertControllerOptionsKeyTitle";
KDIWKAlertControllerOptionsKey const KDIWKAlertControllerOptionsKeyIgnoreEmptyTitle = @"KDIWKAlertControllerOptionsKeyIgnoreEmptyTitle";
KDIWKAlertControllerOptionsKey const KDIWKAlertControllerOptionsKeyMessage = @"KDIWKAlertControllerOptionsKeyMessage";
KDIWKAlertControllerOptionsKey const KDIWKAlertControllerOptionsKeyIgnoreEmptyMessage = @"KDIWKAlertControllerOptionsKeyIgnoreEmptyMessage";
KDIWKAlertControllerOptionsKey const KDIWKAlertControllerOptionsKeyCancelButtonTitle = @"KDIWKAlertControllerOptionsKeyCancelButtonTitle";
KDIWKAlertControllerOptionsKey const KDIWKAlertControllerOptionsKeyOtherButtonTitles = @"KDIWKAlertControllerOptionsKeyOtherButtonTitles";

@implementation WKInterfaceController (KDIExtensions)

- (void)KDI_presentAlertControllerWithError:(NSError *)error {
    [self KDI_presentAlertControllerWithError:error completion:nil];
}
- (void)KDI_presentAlertControllerWithError:(NSError *)error completion:(KDIWKAlertControllerCompletionBlock)completion {
    [self KDI_presentAlertControllerWithTitle:error.KST_alertTitle message:error.KST_alertMessage cancelButtonTitle:nil otherButtonTitles:nil completion:completion];
}

- (void)KDI_presentAlertControllerWithTitle:(NSString *)title message:(NSString *)message cancelButtonTitle:(NSString *)cancelButtonTitle otherButtonTitles:(NSArray<NSString *> *)otherButtonTitles completion:(KDIWKAlertControllerCompletionBlock)completion {
    [self KDI_presentAlertControllerWithStyle:WKAlertControllerStyleAlert title:title message:message cancelButtonTitle:cancelButtonTitle otherButtonTitles:otherButtonTitles completion:completion];
}
- (void)KDI_presentAlertControllerWithStyle:(WKAlertControllerStyle)style title:(NSString *)title message:(NSString *)message cancelButtonTitle:(NSString *)cancelButtonTitle otherButtonTitles:(NSArray<NSString *> *)otherButtonTitles completion:(KDIWKAlertControllerCompletionBlock)completion {
    NSMutableDictionary *options = [[NSMutableDictionary alloc] init];
    
    [options setObject:@(style) forKey:KDIWKAlertControllerOptionsKeyStyle];
    
    if (title.length > 0) {
        [options setObject:title forKey:KDIWKAlertControllerOptionsKeyTitle];
    }
    if (message.length > 0) {
        [options setObject:message forKey:KDIWKAlertControllerOptionsKeyMessage];
    }
    if (cancelButtonTitle.length > 0) {
        [options setObject:cancelButtonTitle forKey:KDIWKAlertControllerOptionsKeyCancelButtonTitle];
    }
    if (otherButtonTitles.count > 0) {
        [options setObject:otherButtonTitles forKey:KDIWKAlertControllerOptionsKeyOtherButtonTitles];
    }
    
    [self KDI_presentAlertControllerWithOptions:options completion:completion];
}

- (void)KDI_presentAlertControllerWithOptions:(NSDictionary<KDIWKAlertControllerOptionsKey,id> *)options completion:(KDIWKAlertControllerCompletionBlock)completion {
    NSString *title = options[KDIWKAlertControllerOptionsKeyTitle];
    
    if (title.length == 0 &&
        ![options[KDIWKAlertControllerOptionsKeyIgnoreEmptyTitle] boolValue]) {
        
        title = NSError.KST_defaultAlertTitle;
    }
    
    NSString *message = options[KDIWKAlertControllerOptionsKeyMessage];
    
    if (message.length == 0 &&
        ![options[KDIWKAlertControllerOptionsKeyIgnoreEmptyMessage] boolValue]) {
        
        message = NSError.KST_defaultAlertMessage;
    }
    
    NSString *cancelButtonTitle = options[KDIWKAlertControllerOptionsKeyCancelButtonTitle];
    NSArray<NSString *> *otherButtonTitles = options[KDIWKAlertControllerOptionsKeyOtherButtonTitles];
    
    if (cancelButtonTitle.length == 0) {
        if (otherButtonTitles.count == 0) {
            cancelButtonTitle = KDILocalizedStringErrorAlertDefaultSingleCancelButtonTitle();
        }
        else {
            cancelButtonTitle = KDILocalizedStringErrorAlertDefaultMultipleCancelButtonTitle();
        }
    }
    
    NSMutableArray *actions = [[NSMutableArray alloc] init];
    
    WKAlertAction *cancelAction = [WKAlertAction actionWithTitle:cancelButtonTitle style:WKAlertActionStyleCancel handler:^{
        if (completion != nil) {
            completion(actions.firstObject,KDIWKAlertControllerCancelButtonIndex);
        }
    }];
    
    [actions addObject:cancelAction];
    
    [otherButtonTitles enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        WKAlertAction *action = [WKAlertAction actionWithTitle:obj style:WKAlertActionStyleDefault handler:^{
            if (completion != nil) {
                completion(actions[idx + 1],idx);
            }
        }];
        
        [actions addObject:action];
    }];
    
    WKAlertControllerStyle style = [options[KDIWKAlertControllerOptionsKeyStyle] integerValue];
    
    [self presentAlertControllerWithTitle:title message:message preferredStyle:style actions:actions];
}

@end
