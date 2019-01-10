//
//  UIViewController+KDIMFMailComposeViewControllerExtensions.m
//  Ditko-iOS
//
//  Created by William Towe on 9/5/18.
//  Copyright © 2019 Kosoku Interactive, LLC. All rights reserved.
//
//  Redistribution and use in source and binary forms, with or without modification, are permitted provided that the following conditions are met:
//
//  1. Redistributions of source code must retain the above copyright notice, this list of conditions and the following disclaimer.
//
//  2. Redistributions in binary form must reproduce the above copyright notice, this list of conditions and the following disclaimer in the documentation and/or other materials provided with the distribution.
//
//  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

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
