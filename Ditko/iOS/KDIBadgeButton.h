//
//  KDIBadgeButton.h
//  Ditko
//
//  Created by William Towe on 4/13/17.
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
 Enum describing the possible values for the badge position. They affect which view the badge view is laid out relative to in combination with badgeOffset.
 */
typedef NS_ENUM(NSInteger, KDIBadgeButtonBadgePosition) {
    /**
     Badge the top left of the button.
     */
    KDIBadgeButtonBadgePositionRelativeToBounds,
    /**
     Badge the top right of the button.
     */
    KDIBadgeButtonBadgePositionRelativeToImage,
    /**
     Badge the bottom left of the button.
     */
    KDIBadgeButtonBadgePositionRelativeToTitle
};

@class KDIBadgeView,KDIButton;

/**
 KDIBadgeButton is a UIView subclass that manages an instance of KDIButton and KDIBadgeView as subviews, allowing badging similar to system buttons (e.g. a UITabBarItem).
 */
@interface KDIBadgeButton : UIView

/**
 Set and get the badge position. The default is KDIBadgeButtonBadgePositionRelativeToImage.
 
 See KDIBadgeButtonBadgePosition
 */
@property (assign,nonatomic) KDIBadgeButtonBadgePosition badgePosition;
@property (assign,nonatomic) CGPoint badgePositionOffset;
@property (assign,nonatomic) CGPoint badgeSizeOffset;
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
