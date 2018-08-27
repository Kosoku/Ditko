//
//  KDIBadgeButton.h
//  Ditko
//
//  Created by William Towe on 4/13/17.
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

/**
 Options that control which subviews are exposed to the accessibility client.
 */
typedef NS_OPTIONS(NSUInteger, KDIBadgeButtonAccessibilityOptions) {
    /**
     No subviews are exposed to the accessibility client.
     */
    KDIBadgeButtonAccessibilityOptionsNone = 0,
    /**
     The button is exposed to the accessibility client.
     */
    KDIBadgeButtonAccessibilityOptionsElementButton = 1 << 0,
    /**
     The badge view is exposed to the accessibility client.
     */
    KDIBadgeButtonAccessibilityOptionsElementBadgeView = 1 << 1,
    /**
     Button and badge view are exposed to the accessibility client.
     */
    KDIBadgeButtonAccessibilityOptionsAll = KDIBadgeButtonAccessibilityOptionsElementButton|KDIBadgeButtonAccessibilityOptionsElementBadgeView
};

/**
 Enum describing the possible values for the badge position. They affect how the badge view is laid out.
 */
typedef NS_ENUM(NSInteger, KDIBadgeButtonBadgePosition) {
    /**
     The badge view will be laid out relative to the bounds of the receiver.
     */
    KDIBadgeButtonBadgePositionRelativeToBounds,
    /**
     The badge view will be laid out relative to the frame of the image of the contained button.
     */
    KDIBadgeButtonBadgePositionRelativeToImage,
    /**
     The badge view will be laid out relative to the frame of the title of the contained button.
     */
    KDIBadgeButtonBadgePositionRelativeToTitle
};

@class KDIBadgeView,KDIButton;

/**
 KDIBadgeButton is a UIView subclass that manages an instance of KDIButton and KDIBadgeView as subviews, allowing badging similar to system buttons (e.g. UITabBarItem).
 */
@interface KDIBadgeButton : UIView

/**
 Set and get the accessibility options for the receiver.
 
 The default is KDIBadgeButtonAccessibilityOptionsAll.
 
 @see KDIBadgeButtonAccessibilityOptions
 */
@property (assign,nonatomic) KDIBadgeButtonAccessibilityOptions accessibilityOptions;

/**
 Set and get the badge position. This affects how badgePositionOffset and badgeSizeOffset are interpreted when laying out the badge view.
 
 The default is KDIBadgeButtonBadgePositionRelativeToBounds.
 
 See KDIBadgeButtonBadgePosition
 */
@property (assign,nonatomic) KDIBadgeButtonBadgePosition badgePosition;
/**
 Set and get the badge position offset. The badge view is laid out using this value to compute its origin and interpeting this value as a percentage of the size of the view referenced by badgePosition.
 
 For example, if CGPointMake(1.0, 0.0) was set and the value of badgePosition was KDIBadgeButtonBadgePositionRelativeToBounds, the origin of the badge view would be CGPointMake(button.frame.origin.x + button.frame.size.width * badgePositionOffset.x, button.frame.origin.y + button.frame.size.height * badgePositionOffset.y).
 
 The default is CGPointMake(1.0, 0.0), which means the badge view begins layout in the top right of the receiver.
 */
@property (assign,nonatomic) UIOffset badgePositionOffset;
/**
 Set and get the badge size offset. The badge view is further laid out using this value to adjust its origin by a percentage of its own size.
 
 For example, if CGPointMake(-0.25, -0.25) was set the origin of the badge view would be CGPointMake(badgeView.origin.x + badgeView.size.width * badgeSizeOffset.x, badgeView.origin.y + badgeView.size.height * badgeSizeOffset.y).
 
 The default is CGPointMake(-0.25, -0.25), which means the badge view is offset to the left by its width * 0.25 and to the top by its height * 0.25.
 */
@property (assign,nonatomic) UIOffset badgeSizeOffset;
/**
 Get the KDIBadgeView instance managed by the receiver.
 
 @see KDIBadgeView
 */
@property (readonly,strong,nonatomic) KDIBadgeView *badgeView;
/**
 Get the KDIButton instance managed by the receiver.
 
 @see KDIButton
 */
@property (readonly,strong,nonatomic) KDIButton *button;

- (void)layoutSubviews NS_REQUIRES_SUPER;
- (CGSize)intrinsicContentSize NS_REQUIRES_SUPER;
- (CGSize)sizeThatFits:(CGSize)size NS_REQUIRES_SUPER;
- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event NS_REQUIRES_SUPER;

@end
