//
//  KDIEmptyView.h
//  Ditko
//
//  Created by William Towe on 4/28/17.
//  Copyright © 2017 Kosoku Interactive, LLC. All rights reserved.
//
//  Redistribution and use in source and binary forms, with or without modification, are permitted provided that the following conditions are met:
//
//  1. Redistributions of source code must retain the above copyright notice, this list of conditions and the following disclaimer.
//
//  2. Redistributions in binary form must reproduce the above copyright notice, this list of conditions and the following disclaimer in the documentation and/or other materials provided with the distribution.
//
//  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

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
    KDIEmptyViewAlignmentVerticalSystemSpacing,
    /**
     Custom spacing from the top edge, you should set the desired value for alignmentVerticalCustomSpacing if this value is used.
     */
    KDIEmptyViewAlignmentVerticalCustomSpacing
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
 
 The *image* and *action* will be tinted accordingly based on the receiver's tintColor property. The *body* and *action* are the same font size. The *headline* font is slightly larger and bold. The fonts used are based on dynamic type.
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
 
 The default is nil.
 */
@property (strong,nonatomic,nullable) UIColor *imageColor UI_APPEARANCE_SELECTOR;
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
