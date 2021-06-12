//
//  KDIScrollView.h
//  Ditko-iOS
//
//  Created by William Towe on 11/9/17.
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

/**
 KDIScrollViewFadeAxis is an enum that represents the axis for which to apply a gradient fade.
 */
typedef NS_ENUM(NSInteger, KDIScrollViewFadeAxis) {
    /**
     No gradient fade will be applied.
     */
    KDIScrollViewFadeAxisNone = -1,
    /**
     A gradient fade will be applied to the horizontal axis, meaning the left and right edges.
     */
    KDIScrollViewFadeAxisHorizontal = UILayoutConstraintAxisHorizontal,
    /**
     A gradient fade will be applied to the vertical axis, meaning the top and bottom edges.
     */
    KDIScrollViewFadeAxisVertical = UILayoutConstraintAxisVertical
};

/**
 KDIScrollView is a UIScrollView subclass that adds a few convenient capabilities. It can automatically adjust its contentInsets in response to the keyboard. It can also apply a gradient fade to the leading and trailing edges of its primary scrolling axis.
 */
@interface KDIScrollView : UIScrollView

/**
 Set and get whether the receiver adjusts its content inset in response to the keyboard showing/hiding.
 
 The default is NO.
 */
@property (assign,nonatomic) BOOL adjustsContentInsetForKeyboard;

/**
 Get and set the axis on which to apply a gradient fade.
 
 The default is KDIScrollViewFadeAxisNone.
 */
@property (assign,nonatomic) KDIScrollViewFadeAxis fadeAxis;
/**
 Get and set the leading edge fade percentage, which is the amount of content on the leading edge that the fade will cover.
 
 For example, if the value is 0.1, the fade will start at the leading edge and end 10 percent away from the leading edge towards the center of the receiver. The default is 0.0.
 */
@property (assign,nonatomic) float leadingEdgeFadePercentage;
/**
 Get and set the trailing edge fade percentage, which is the amount of content on the trailing edge that the fade will cover.
 
 For example, if the value if 0.1, the fade will start at the trailing edge and end 10 percent away from the trailing edge towards the center of the receiver. The default is 0.0.
 */
@property (assign,nonatomic) float trailingEdgeFadePercentage;

@end
