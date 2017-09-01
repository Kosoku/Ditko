//
//  KDIButton.h
//  Ditko
//
//  Created by William Towe on 3/10/17.
//  Copyright © 2017 Kosoku Interactive, LLC. All rights reserved.
//
//  Redistribution and use in source and binary forms, with or without modification, are permitted provided that the following conditions are met:
//
//  1. Redistributions of source code must retain the above copyright notice, this list of conditions and the following disclaimer.
//
//  2. Redistributions in binary form must reproduce the above copyright notice, this list of conditions and the following disclaimer in the documentation and/or other materials provided with the distribution.
//
//  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

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
 Set and get whether the receiver is rounded. If YES, the underlying CALayer corner radius property is set to match the height of the receiver.
 
 The default is NO.
 */
@property (assign,nonatomic,getter=isRounded) BOOL rounded;

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
