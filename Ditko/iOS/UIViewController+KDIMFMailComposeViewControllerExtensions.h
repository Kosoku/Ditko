//
//  UIViewController+KDIMFMailComposeViewControllerExtensions.h
//  Ditko-iOS
//
//  Created by William Towe on 9/5/18.
//  Copyright © 2018 Kosoku Interactive, LLC. All rights reserved.
//
//  Redistribution and use in source and binary forms, with or without modification, are permitted provided that the following conditions are met:
//
//  1. Redistributions of source code must retain the above copyright notice, this list of conditions and the following disclaimer.
//
//  2. Redistributions in binary form must reproduce the above copyright notice, this list of conditions and the following disclaimer in the documentation and/or other materials provided with the distribution.
//
//  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

#import <UIKit/UIKit.h>
#import <MessageUI/MFMailComposeViewController.h>

NS_ASSUME_NONNULL_BEGIN

/**
 Block that is invoked when the user finishes interacting with the mail compose view controller.
 
 @param result The result of the user interaction
 @param error The error if the result was MFMailComposeResultFailed
 */
typedef void(^KDIMFMailComposeViewControllerCompletionBlock)(MFMailComposeResult result, NSError * _Nullable error);

@interface UIViewController (KDIMFMailComposeViewControllerExtensions)

/**
 Present the provided *mailComposeViewController*, optionally *animated* and invoke the provided *completion* block when the user finishes interacting with the view controller.
 
 This method will check the return value of [MFMailComposeViewController canSendMail] before presenting the provided mail compose view controller. If [MFMailComposeViewController canSendMail] returns NO, so will this method and the mail compose view controller will not be presented.
 
 @param mailComposeViewController The mail compose view controller to present
 @param animated Whether to animate the presentation
 @param completion The completion block to invoke when the user interaction is finished
 @return YES if the MFMailComposeViewController was presented, otherwise NO
 */
- (BOOL)KDI_presentMailComposeViewController:(MFMailComposeViewController *)mailComposeViewController animated:(BOOL)animated completion:(KDIMFMailComposeViewControllerCompletionBlock)completion;

@end

NS_ASSUME_NONNULL_END
