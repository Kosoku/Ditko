//
//  KDIView.h
//  Ditko
//
//  Created by William Towe on 3/8/17.
//  Copyright © 2017 Kosoku Interactive, LLC. All rights reserved.
//
//  Redistribution and use in source and binary forms, with or without modification, are permitted provided that the following conditions are met:
//
//  1. Redistributions of source code must retain the above copyright notice, this list of conditions and the following disclaimer.
//
//  2. Redistributions in binary form must reproduce the above copyright notice, this list of conditions and the following disclaimer in the documentation and/or other materials provided with the distribution.
//
//  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

#import <Ditko/KDIDefines.h>

NS_ASSUME_NONNULL_BEGIN

/**
 Options mask describing the border options of the receiver.
 */
typedef NS_OPTIONS(NSUInteger, KDIViewBorderOptions) {
    /**
     No borders are drawn.
     */
    KDIViewBorderOptionsNone = 0,
    /**
     The top border is drawn.
     */
    KDIViewBorderOptionsTop = 1 << 0,
    /**
     The left border is drawn.
     */
    KDIViewBorderOptionsLeft = 1 << 1,
    /**
     The bottom border is drawn.
     */
    KDIViewBorderOptionsBottom = 1 << 2,
    /**
     The right border is drawn.
     */
    KDIViewBorderOptionsRight = 1 << 3,
    /**
     Top and bottom borders are drawn.
     */
    KDIViewBorderOptionsTopAndBottom = KDIViewBorderOptionsTop | KDIViewBorderOptionsBottom,
    /**
     Left and right borders are drawn.
     */
    KDIViewBorderOptionsLeftAndRight = KDIViewBorderOptionsLeft | KDIViewBorderOptionsRight,
    /**
     Top, left, bottom, and right borders are drawn.
     */
    KDIViewBorderOptionsAll = KDIViewBorderOptionsTop | KDIViewBorderOptionsLeft | KDIViewBorderOptionsBottom | KDIViewBorderOptionsRight
};

#if (TARGET_OS_OSX)
/**
 Options mask describing the state of the receiver.
 */
typedef NS_OPTIONS(NSUInteger, KDIViewState) {
    /**
     The view has no state.
     */
    KDIViewStateNone = 0,
    /**
     The app is active.
     */
    KDIViewStateActive = 1 << 0,
    /**
     The view's window is the main window.
     */
    KDIViewStateMain = 1 << 1,
    /**
     The view's window is the key window.
     */
    KDIViewStateKey = 1 << 2,
    /**
     The view is the current first responder.
     */
    KDIViewStateFirstResponder = 1 << 3
};

/**
 Notification that is posted when the state of the receiver changes.
 */
FOUNDATION_EXPORT NSNotificationName const KDIViewNotificationDidChangeState;
#endif

/**
 KDIView is a UIView/NSView subclass that provides a number of convenience methods.
 */
#if (TARGET_OS_IPHONE)
@interface KDIView : UIView
#else
@interface KDIView : NSView
#endif

/**
 If YES, the borderWidth is adjusted based on the screen scale. Meaning, a borderWidth of 1.0 becomes 2.0 on a retina screen.
 
 The default is NO.
 */
@property (assign,nonatomic) BOOL respectScreenScale;

/**
 Set and get the border options of the receiver.
 
 @see KDIViewBorderOptions
 */
@property (assign,nonatomic) KDIViewBorderOptions borderOptions;

/**
 Set and get the border width of the receiver. This affects the height of the top and bottom borders as well as the width of the left and right borders.
 
 The default is 1.0.
 */
#if (TARGET_OS_IPHONE)
@property (assign,nonatomic) CGFloat borderWidth UI_APPEARANCE_SELECTOR;
#else
@property (assign,nonatomic) CGFloat borderWidth;
#endif

/**
 Set and get the border edge insets of the receiver.
 
 The default is UIEdgeInsetsZero/NSEdgeInsetsZero.
 */
#if (TARGET_OS_IPHONE)
@property (assign,nonatomic) UIEdgeInsets borderEdgeInsets UI_APPEARANCE_SELECTOR;
#else
@property (assign,nonatomic) NSEdgeInsets borderEdgeInsets;
#endif

/**
 Set and get the border color of the receiver.
 
 The default is [UIColor blackColor]/[NSColor blackColor].
 */
#if (TARGET_OS_IPHONE)
@property (strong,nonatomic,null_resettable) UIColor *borderColor UI_APPEARANCE_SELECTOR;
#else
@property (strong,nonatomic,null_resettable) NSColor *borderColor;
#endif

/**
 Set and get the background color of the receiver.
 
 Equivalent to backgroundColor on UIView.
 */
#if (TARGET_OS_OSX)
@property (readonly,assign,nonatomic) KDIViewState state;

@property (strong,nonatomic,nullable) NSColor *backgroundColor;
#endif

#if (TARGET_OS_IPHONE)
- (void)didAddSubview:(UIView *)subview NS_REQUIRES_SUPER;
- (void)layoutSubviews NS_REQUIRES_SUPER;
#else
- (BOOL)becomeFirstResponder NS_REQUIRES_SUPER;
- (BOOL)resignFirstResponder NS_REQUIRES_SUPER;
- (void)drawRect:(NSRect)dirtyRect NS_REQUIRES_SUPER;
#endif

@end

NS_ASSUME_NONNULL_END
