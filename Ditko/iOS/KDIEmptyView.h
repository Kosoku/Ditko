//
//  KDIEmptyView.h
//  Ditko
//
//  Created by William Towe on 4/28/17.
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

#import <Ditko/KDIView.h>

NS_ASSUME_NONNULL_BEGIN

/**
 Enum for possible vertical alignment values.
 */
typedef NS_ENUM(NSInteger, KDIEmptyViewAlignmentVertical) {
    /**
     The receiver's subviews are centered vertically within its bounds.
     */
    KDIEmptyViewAlignmentVerticalCenter = 0,
    /**
     Spacing from the top edge, using the @"-" character in VFL.
     */
    KDIEmptyViewAlignmentVerticalSystemSpacingFromTop,
    /**
     Custom spacing from the top edge, you should set the desired value for alignmentVerticalCustomSpacing if this value is used.
     */
    KDIEmptyViewAlignmentVerticalCustomSpacingFromTop,
    /**
     Spacing from the bottom edge, using the @"-" character in VFL.
     */
    KDIEmptyViewAlignmentVerticalSystemSpacingFromBottom,
    /**
     Custom spacing from the bottom edge, you should set the desired value for alignmentVerticalCustomSpacing if this value is used.
     */
    KDIEmptyViewAlignmentVerticalCustomSpacingFromBottom
};

@class KDIEmptyView;

/**
 Block that is invoked when the action button in the receiver is tapped.
 
 @param emptyView The view that contains the action button
 */
typedef void(^KDIEmptyViewActionBlock)(__kindof KDIEmptyView *emptyView);

/**
 KDIEmptyView is a UIView subclass for use as the placeholder view when there is no data available. For example, if the containing view displays items that the user has favorited, an instance of this calss could be used to display a call to action prompting the user to favorite an item. Another example would be if the user's permission is required before content can be displayed (e.g. Photos permission).
 
 The relevant subviews are stacked vertically and centered horizontally:
 
 [image (UIImageView)]
    |
 [headline (UILabel)]
    |
 [loading (UIActivityIndicatorView)]-[body (UILabel)]
    |
 [action (UIButton)]
 
 The *image* and *action* will be tinted accordingly based on the receiver's tintColor property. The *headline*, *body*, and *action* all use their respectively named font styles.
 */
@interface KDIEmptyView : KDIView

/**
 Get and set the vertical alignment of the receiver.
 
 The default is KDIEmptyViewAlignmentVerticalCenter.
 
 @see KDIEmptyViewAlignmentVertical
 */
@property (assign,nonatomic) KDIEmptyViewAlignmentVertical alignmentVertical;
/**
 Get and set the custom vertical alignment spacing to use, expressed as the distance from the top edge of the receiver.
 */
@property (assign,nonatomic) CGFloat alignmentVerticalCustomSpacing;

/**
 Set and get the image of the receiver.
 */
@property (strong,nonatomic,nullable) UIImage *image;
/**
 Set and get the image tint color, if nil defaults to self.tintColor.
 
 The default is UIColor.blackColor.
 */
@property (strong,nonatomic,nullable) UIColor *imageColor UI_APPEARANCE_SELECTOR;
/**
 Set and get the accessibility label used for the image. The UIImageView containing the image is only exposed to the accessibility client if this value is non-nil.
 
 The default is nil.
 */
@property (copy,nonatomic,nullable) NSString *imageAccessibilityLabel;
/**
 Set and get the headline of the receiver.
 */
@property (copy,nonatomic,nullable) NSString *headline;
/**
 Set and get the headline text color of the receiver.
 
 The default is UIColor.blackColor.
 */
@property (strong,nonatomic,null_resettable) UIColor *headlineColor UI_APPEARANCE_SELECTOR;
/**
 Set and get the headline text style.
 
 The default is UIFontTextStyleHeadline.
 */
@property (copy,nonatomic,null_resettable) UIFontTextStyle headlineTextStyle UI_APPEARANCE_SELECTOR;
/**
 Set and get the body of the receiver.
 */
@property (copy,nonatomic,nullable) NSString *body;
/**
 Set and get the body text color of the receiver.
 
 The default is UIColor.grayColor.
 */
@property (strong,nonatomic,null_resettable) UIColor *bodyColor UI_APPEARANCE_SELECTOR;
/**
 Set and get the body text style.
 
 The default is UIFontTextStyleBody.
 */
@property (copy,nonatomic,null_resettable) UIFontTextStyle bodyTextStyle UI_APPEARANCE_SELECTOR;
/**
 Set and get the action of the receiver. This is used as the title of a button.
 */
@property (copy,nonatomic,nullable) NSString *action;
/**
 Set and get the action text style.
 
 The default is UIFontTextStyleCallout.
 */
@property (copy,nonatomic,null_resettable) UIFontTextStyle actionTextStyle UI_APPEARANCE_SELECTOR;
/**
 Set and get the block that is invoked when the action button is tapped.
 */
@property (copy,nonatomic,nullable) KDIEmptyViewActionBlock actionBlock;
/**
 Set and get whether the loading activity indicator is shown.
 
 The default is NO.
 */
@property (assign,nonatomic,getter=isLoading) BOOL loading;
/**
 Set and get the loading indicator tint color, if nil defaults to self.tintColor.
 
 The default is nil.
 */
@property (strong,nonatomic,nullable) UIColor *loadingColor UI_APPEARANCE_SELECTOR;

@end

NS_ASSUME_NONNULL_END
