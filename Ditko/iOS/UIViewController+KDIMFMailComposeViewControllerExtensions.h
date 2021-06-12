//
//  UIViewController+KDIMFMailComposeViewControllerExtensions.h
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
