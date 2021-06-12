//
//  KDIProgressNavigationBar.h
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

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

/**
 KDIProgressNavigationBar is a UINavigationBar subclass that manages a UIProgressView to display relevant progress at the bottom edge of the receiver.
 */
@interface KDIProgressNavigationBar : UINavigationBar

/**
 Set and get whether the managed UIProgressView is hidden.
 
 Calls `-[self setProgressHidden:animated:]`, passing _progressHidden_ and NO respectively.
 */
@property (assign,nonatomic,getter=isProgressHidden) BOOL progressHidden;
/**
 Set and get whether the managed UIProgressView is hidden, with optional animation.
 
 @param progressHidden Whether to hide the managed UIProgressView
 @param animated Whether to animate the change
 */
- (void)setProgressHidden:(BOOL)progressHidden animated:(BOOL)animated;

/**
 Set and get the progress of the managed UIProgressView.
 
 Calls `-[self setProgress:animated:]`, passing _progress_ and NO respectively.
 */
@property (assign,nonatomic) float progress;
/**
 Set and get the progress of the managed UIProgressView, with optional animation.
 
 @param progress The progress percentage, between 0.0 and 1.0
 @param animated Whether to animate the change
 */
- (void)setProgress:(float)progress animated:(BOOL)animated;

- (void)didAddSubview:(UIView *)subview NS_REQUIRES_SUPER;

@end

@interface UINavigationController (KDIProgressNavigationBarExtensions)

/**
 Returns the managed KDIProgressNavigationBar or nil.
 
 @return The navigation bar or nil
 */
@property (readonly,nonatomic,nullable) KDIProgressNavigationBar *KDI_progressNavigationBar;

@end

NS_ASSUME_NONNULL_END
