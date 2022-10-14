//
//  KDIButton.h
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

#import <Ditko/KDIBorderedView.h>

/**
 Typedef for possible content vertical alignment. The same as UIControlContentVerticalAlignment with an additional value for default behavior.
 */
typedef NS_ENUM(NSInteger, KDIButtonContentVerticalAlignment) {
    /**
     Use default UIButton behavior.
     */
    KDIButtonContentVerticalAlignmentDefault = -1,
    /**
     Center the content vertically.
     */
    KDIButtonContentVerticalAlignmentCenter = UIControlContentVerticalAlignmentCenter,
    /**
     Align the content to the top edge.
     */
    KDIButtonContentVerticalAlignmentTop = UIControlContentVerticalAlignmentTop,
    /**
     Align the content to the bottom edge.
     */
    KDIButtonContentVerticalAlignmentBottom = UIControlContentVerticalAlignmentBottom,
    /**
     Stretch the content to fill the available space.
     */
    KDIButtonContentVerticalAlignmentFill = UIControlContentVerticalAlignmentFill
};
/**
 Typedef for possible content horizontal alignment. The same as UIControlContentHorizontalAlignment with an additional value for default behavior.
 */
typedef NS_ENUM(NSInteger, KDIButtonContentHorizontalAlignment) {
    /**
     Use default UIButton behavior.
     */
    KDIButtonContentHorizontalAlignmentDefault = -1,
    /**
     Center the content horizontally.
     */
    KDIButtonContentHorizontalAlignmentCenter = UIControlContentHorizontalAlignmentCenter,
    /**
     Align the content to the leading edge.
     */
    KDIButtonContentHorizontalAlignmentLeft = UIControlContentHorizontalAlignmentLeft,
    /**
     Align the content to the trailing edge.
     */
    KDIButtonContentHorizontalAlignmentRight = UIControlContentHorizontalAlignmentRight,
    /**
     Stretch the content to fill the available space.
     */
    KDIButtonContentHorizontalAlignmentFill = UIControlContentHorizontalAlignmentFill
};

/**
 Describes an object that can be used as the `loadingView` of a `KDIButton`.
 */
@protocol KDIButtonLoadingView <NSObject>
/**
 Returns whether the receiver is animating.
 */
@property (nonatomic,readonly,getter=isAnimating) BOOL animating;
/**
 Set/get the color used to tint the receiver. The default is the `tintColor` of the `KDIButton`.
 */
@property (strong,nonatomic,null_resettable) UIColor *color;

/**
 Start animating the receiver.
 */
- (void)startAnimating;
/**
 Stop animating the receiver.
 */
- (void)stopAnimating;

@end

/**
 KDIButton is a subclass of UIButton that provides custom style and alignment options. Notably, you can set the alignment for title and image independantly of one another. This allows for unique layout combinations. For example, you can tell the button to layout the image at the top, title at the bottom, and center them both horizontally.
 
 It also conforms to KDIBorderedView, allowing it to display borders.
 */
@interface KDIButton : UIButton <KDIBorderedView>

/**
 Set and get whether the border color matches the tint color of the receiver.
 
 The default is NO.
 */
@property (assign,nonatomic) BOOL borderColorMatchesTintColor;
/**
 Set and get whether the receiver is inverted. If YES, the receiver's tintColor is used as the backgroundColor and KDI_contrastingColor is used to compute the titleColor for the normal state.
 
 The default is NO.
 */
@property (assign,nonatomic,getter=isInverted) BOOL inverted;
/**
 Set and get whether the receiver is rounded. If YES, the mask of the view's layer is set to enclose the title and image and any associated padding. If the corner radius of the view's layer is already set, that corner radius is used for the mask layer, otherwise ceil(MIN(CGRectGetWidth(self.bounds), CGRectGetHeight(self.bounds)) * 0.5) is used.
 
 The default is NO.
 */
@property (assign,nonatomic,getter=isRounded) BOOL rounded;
/**
 If YES, and *rounded* is YES, the rounded mask is relative to the content of the receiver (i.e. the title and image) instead of the bounds of the receiver.
 
 The default is YES.
 */
@property (assign,nonatomic) BOOL roundedRelativeToImageAndTitle;

/**
 If YES, the loading view will be faded in and started animating, centerd in the bounds of the receiver, while the titleLabel and imageView will be faded out. If NO, the loading view will be faded out and stopped animating, while the titleLabel and imageView will be faded in.
 
 The default is NO.
 */
@property (assign,nonatomic,getter=isLoading) BOOL loading;
/**
 If YES, loading will be automatically set to YES when the receiver is disabled and set to NO when the receiver is enabled.
 
 The default is NO.
 */
@property (assign,nonatomic) BOOL automaticallyTogglesLoadingWhenDisabled;
/**
 If non-nil, will be set as the loading view's color property, otherwise the activity indicator view color will match the receiver's tint color.
 
 The default is nil.
 */
@property (strong,nonatomic,nullable) UIColor *loadingColor;
/**
 The provided view will be displayed according to the value of `loading`.
 
 The default is an instance of `UIActivityIndicatorView`.
 */
@property (strong,nonatomic,null_resettable) __kindof UIView<KDIButtonLoadingView> *loadingView;

/**
 Set whether the receiver adjusts its title color when highlighted. If set to YES, the title color set for UIControlStateNormal will be inspected and the computed color will be set for the highlighted state. The title color is drawn lighter if the normal title color was dark and darker if the normal title color was light.
 */
@property (assign,nonatomic) BOOL adjustsTitleColorWhenHighlighted;

/**
 Set and get the vertical content alignment for the title.
 
 The default is KDIButtonContentVerticalAlignmentDefault.
 */
@property (assign,nonatomic) KDIButtonContentVerticalAlignment titleContentVerticalAlignment;
/**
 Set and get the horizontal content alignment for the title.
 
 The default is KDIButtonContentHorizontalAlignmentDefault.
 */
@property (assign,nonatomic) KDIButtonContentHorizontalAlignment titleContentHorizontalAlignment;

/**
 Set and get the vertical content alignment for the image.
 
 The default is KDIButtonContentVerticalAlignmentDefault.
 */
@property (assign,nonatomic) KDIButtonContentVerticalAlignment imageContentVerticalAlignment;
/**
 Set and get the horizontal content alignment for the image.
 
 The default is KDIButtonContentHorizontalAlignmentDefault.
 */
@property (assign,nonatomic) KDIButtonContentHorizontalAlignment imageContentHorizontalAlignment;

- (void)layoutSubviews NS_REQUIRES_SUPER;
- (CGSize)intrinsicContentSize NS_REQUIRES_SUPER;
- (CGSize)sizeThatFits:(CGSize)size NS_REQUIRES_SUPER;
- (void)tintColorDidChange NS_REQUIRES_SUPER;

@end
