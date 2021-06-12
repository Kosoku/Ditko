//
//  UIViewController+KDIMFMailComposeViewControllerExtensions.m
//  Ditko-iOS
//
//  Created by William Towe on 9/5/18.
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

#import "UIViewController+KDIMFMailComposeViewControllerExtensions.h"

#import <objc/runtime.h>

@interface KDIMFMailComposeViewControllerDelegate : NSObject <MFMailComposeViewControllerDelegate,UINavigationControllerDelegate>
@property (weak,nonatomic) MFMailComposeViewController *mailComposeViewController;
@property (copy,nonatomic) KDIMFMailComposeViewControllerCompletionBlock completion;

- (instancetype)initWithMailComposeViewController:(MFMailComposeViewController *)mailComposeViewController completion:(KDIMFMailComposeViewControllerCompletionBlock)completion;
@end

@interface UIViewController (KDIMFMailComposeViewControllerPrivateExtensions)
@property (strong,nonatomic) KDIMFMailComposeViewControllerDelegate *KDI_MFMailComposeViewControllerDelegate;
@end

@implementation UIViewController (KDIMFMailComposeViewControllerExtensions)

- (BOOL)KDI_presentMailComposeViewController:(MFMailComposeViewController *)mailComposeViewController animated:(BOOL)animated completion:(KDIMFMailComposeViewControllerCompletionBlock)completion {
    if (![MFMailComposeViewController canSendMail]) {
        return NO;
    }
    
    mailComposeViewController.KDI_MFMailComposeViewControllerDelegate = [[KDIMFMailComposeViewControllerDelegate alloc] initWithMailComposeViewController:mailComposeViewController completion:completion];
    
    [self presentViewController:mailComposeViewController animated:animated completion:nil];
    
    return YES;
}

@end

@implementation UIViewController (KDIMFMailComposeViewControllerPrivateExtensions)

static void const *kKDI_MFMailComposeViewControllerDelegateKey = &kKDI_MFMailComposeViewControllerDelegateKey;

@dynamic KDI_MFMailComposeViewControllerDelegate;
- (KDIMFMailComposeViewControllerDelegate *)KDI_MFMailComposeViewControllerDelegate {
    return objc_getAssociatedObject(self, kKDI_MFMailComposeViewControllerDelegateKey);
}
- (void)setKDI_MFMailComposeViewControllerDelegate:(KDIMFMailComposeViewControllerDelegate *)KDI_MFMailComposeViewControllerDelegate {
    objc_setAssociatedObject(self, kKDI_MFMailComposeViewControllerDelegateKey, KDI_MFMailComposeViewControllerDelegate, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end

@implementation KDIMFMailComposeViewControllerDelegate

- (void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error {
    [controller.presentingViewController dismissViewControllerAnimated:YES completion:nil];
    
    self.completion(result, error);
    self.completion = nil;
}

- (instancetype)initWithMailComposeViewController:(MFMailComposeViewController *)mailComposeViewController completion:(KDIMFMailComposeViewControllerCompletionBlock)completion {
    if (!(self = [super init]))
        return nil;
    
    _mailComposeViewController = mailComposeViewController;
    _mailComposeViewController.delegate = self;
    _completion = [completion copy];
    
    return self;
}

@end
