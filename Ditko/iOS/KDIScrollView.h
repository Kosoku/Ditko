//
//  KDIScrollView.h
//  Ditko-iOS
//
//  Created by William Towe on 11/9/17.
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

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, KDIScrollViewFadeAxis) {
    KDIScrollViewFadeAxisNone = -1,
    KDIScrollViewFadeAxisHorizontal = UILayoutConstraintAxisHorizontal,
    KDIScrollViewFadeAxisVertical = UILayoutConstraintAxisVertical
};

/**
 KDIScrollView is a UIScrollView subclass that adds simple keyboard adjustment behavior. It will adjust its contentInset appropriately if adjustsContentInsetForKeyboard is YES.
 */
@interface KDIScrollView : UIScrollView

/**
 Set and get whether the receiver adjusts its content inset in response to the keyboard showing/hiding.
 
 The default is NO.
 */
@property (assign,nonatomic) BOOL adjustsContentInsetForKeyboard;

@property (assign,nonatomic) KDIScrollViewFadeAxis fadeAxis;
@property (assign,nonatomic) float leadingEdgeFadePercentage;
@property (assign,nonatomic) float trailingEdgeFadePercentage;

@end
