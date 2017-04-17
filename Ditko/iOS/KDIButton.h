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

#import <UIKit/UIKit.h>

/**
 Enum describing the style of the button.
 */
typedef NS_ENUM(NSInteger, KDIButtonStyle) {
    /**
     Use the default UIButton style.
     */
    KDIButtonStyleDefault = 0,
    /**
     Round the corners of the button to match the height.
     */
    KDIButtonStyleRounded
};

/**
 Options mask describing the alignment options of the receiver.
 */
typedef NS_ENUM(NSUInteger, KDIButtonAlignment) {
    /**
     The default UIButton alignment is used.
     */
    KDIButtonAlignmentDefault = 0,
    /**
     Left alignment will be used. An exception will be thrown if this options is combined with either KDIButtonAlignmentTop or KDIButtonAlignmentBottom.
     */
    KDIButtonAlignmentLeft = 1 << 0,
    /**
     Right alignment will be used. An exception will be thrown if this options is combined with either KDIButtonAlignmentTop or KDIButtonAlignmentBottom.
     */
    KDIButtonAlignmentRight = 1 << 1,
    /**
     Top alignment will be used. An exception will be thrown if this options is combined with either KDIButtonAlignmentLeft or KDIButtonAlignmentRight.
     */
    KDIButtonAlignmentTop = 1 << 2,
    /**
     Bottom alignment will be used. An exception will be thrown if this options is combined with either KDIButtonAlignmentLeft or KDIButtonAlignmentRight.
     */
    KDIButtonAlignmentBottom = 1 << 3,
    /**
     Horizontal or vertical center alignment will be used depending on the other alignment options.
     */
    KDIButtonAlignmentCenter = 1 << 4
};

/**
 KDIButton is a subclass of UIButton that provides custom style and alignment options.
 */
@interface KDIButton : UIButton

/**
 Set and get the style of the button.
 
 @see KDIButtonStyle
 */
@property (assign,nonatomic) KDIButtonStyle style;
/**
 Set and get the alignment of button title.
 
 @see KDIButtonAlignment
 */
@property (assign,nonatomic) KDIButtonAlignment titleAlignment;
/**
 Set and get the alignment of button image.
 
 @see KDIButtonAlignment
 */
@property (assign,nonatomic) KDIButtonAlignment imageAlignment;

/**
 Set whether the receiver adjusts its title color when highlighted. If set to YES, the title color set for UIControlStateNormal will be inspected and the computed color will be set for the highlighted state. The title color is drawn lighter if the normal title color was dark and darker if the normal title color was light.
 */
@property (assign,nonatomic) BOOL adjustsTitleColorWhenHighlighted;

- (void)layoutSubviews NS_REQUIRES_SUPER;
- (CGSize)intrinsicContentSize NS_REQUIRES_SUPER;
- (CGSize)sizeThatFits:(CGSize)size NS_REQUIRES_SUPER;

@end
