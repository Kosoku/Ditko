//
//  KDIWindow.h
//  Ditko-iOS
//
//  Created by William Towe on 11/1/17.
//  Copyright © 2019 Kosoku Interactive, LLC. All rights reserved.
//
//  Redistribution and use in source and binary forms, with or without modification, are permitted provided that the following conditions are met:
//
//  1. Redistributions of source code must retain the above copyright notice, this list of conditions and the following disclaimer.
//
//  2. Redistributions in binary form must reproduce the above copyright notice, this list of conditions and the following disclaimer in the documentation and/or other materials provided with the distribution.
//
//  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

/**
 Enum for possible accessory view positions. When positioned at the top, the height of the accessory view will be increased to account for the status bar.
 */
typedef NS_ENUM(NSInteger, KDIWindowAccessoryViewPosition) {
    /**
     The accessory view is anchored to the top of the window.
     */
    KDIWindowAccessoryViewPositionTop = 0,
    /**
     The accessory view is anchored to the bottom of the window.
     */
    KDIWindowAccessoryViewPositionBottom
};

/**
 Posted when the accessory view of the receiver changes. The object of the notification is the KDIWindow instance.
 */
FOUNDATION_EXTERN NSNotificationName const KDIWindowNotificationDidChangeAccessoryView;
/**
 Posted when the accessory view position of the receiver changes. The object of the notification is the KDIWindow instance.
 */
FOUNDATION_EXTERN NSNotificationName const KDIWindowNotificationDidChangeAccessoryViewPosition;

/**
 KDIWindow is a UIWindow subclass that provides support for an accessory view to be displayed aligned against the top or bottom edge of the window.
 */
@interface KDIWindow : UIWindow

/**
 Set and get the accessory view. The accessory is anchored to the top or bottom of the window, similar to UINavigationBar or UIToolbar. The remaining content of the window, that is the rootViewController and all presented view controllers will be laid out above or below the accessory view, based on the value of accessoryViewPosition.
 
 The window will determine the height of the accessory in the following order:
 
 - If the accessory view class returns YES for requiresConstraintBasedLayout, the instance will be sent systemLayoutSizeFittingSize: passing UILayoutFittingCompressedSize
 - The instance is asked for its intrinsicContentSize, if the height of the returned is > 0.0, it is used
 - Finally, the instance is sent sizeThatFits: passing CGSizeZero and the height of the returned size is used
 */
@property (strong,nonatomic,nullable) __kindof UIView *accessoryView;
/**
 Set and get the accessory view position, which affects where the accessory view is anchored within the window.
 
 The default is KDIWindowAccessoryViewPositionTop.
 */
@property (assign,nonatomic) KDIWindowAccessoryViewPosition accessoryViewPosition;

@end

NS_ASSUME_NONNULL_END
