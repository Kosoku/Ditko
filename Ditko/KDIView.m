//
//  KDIView.m
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

#import "KDIView.h"

#if (TARGET_OS_OSX)
NSString *const KDIViewNotificationDidChangeState = @"KDIViewNotificationDidChangeState";
#endif

@interface KDIView ()
#if (TARGET_OS_OSX)
@property (readwrite,assign,nonatomic) KDIViewState state;
#endif
#if (TARGET_OS_IPHONE)
@property (strong,nonatomic) UIView *topBorderView, *leftBorderView, *bottomBorderView, *rightBorderView;
#endif

- (void)_KDIViewInit;
#if (TARGET_OS_OSX)
- (void)_updateState;
#endif

+ (CGFloat)_defaultBorderWidth;
+ (KDIColor *)_defaultBorderColor;
@end

@implementation KDIView

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (instancetype)initWithFrame:(KDIRect)frame {
    if (!(self = [super initWithFrame:frame]))
        return nil;
    
    [self _KDIViewInit];
    
    return self;
}
- (instancetype)initWithCoder:(NSCoder *)coder {
    if (!(self = [super initWithCoder:coder]))
        return nil;
    
    [self _KDIViewInit];
    
    return self;
}
    
#if (TARGET_OS_IPHONE)
- (void)didMoveToWindow {
    [super didMoveToWindow];
    
    if (self.window.screen != nil) {
        [self setNeedsLayout];
    }
}
- (void)didAddSubview:(UIView *)subview {
    if (subview == self.topBorderView ||
        subview == self.leftBorderView ||
        subview == self.bottomBorderView ||
        subview == self.rightBorderView) {
        
        [subview setBackgroundColor:self.borderColor];
    }
    
    [self bringSubviewToFront:self.topBorderView];
    [self bringSubviewToFront:self.leftBorderView];
    [self bringSubviewToFront:self.bottomBorderView];
    [self bringSubviewToFront:self.rightBorderView];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    if (self.window.screen == nil) {
        return;
    }
    
    CGFloat borderWidth = self.respectScreenScale ? self.borderWidth : self.borderWidth / self.window.screen.scale;
    
    [self.topBorderView setFrame:CGRectMake(self.borderEdgeInsets.left, self.borderEdgeInsets.top, CGRectGetWidth(self.bounds) - self.borderEdgeInsets.left - self.borderEdgeInsets.right, borderWidth)];
    [self.leftBorderView setFrame:CGRectMake(self.borderEdgeInsets.left, self.borderEdgeInsets.top, borderWidth, CGRectGetHeight(self.bounds) - self.borderEdgeInsets.top - self.borderEdgeInsets.bottom)];
    [self.bottomBorderView setFrame:CGRectMake(self.borderEdgeInsets.left, CGRectGetHeight(self.bounds) - borderWidth - self.borderEdgeInsets.bottom, CGRectGetWidth(self.bounds) - self.borderEdgeInsets.left - self.borderEdgeInsets.right, borderWidth)];
    [self.rightBorderView setFrame:CGRectMake(CGRectGetWidth(self.bounds) - borderWidth - self.borderEdgeInsets.right, self.borderEdgeInsets.top, borderWidth, CGRectGetHeight(self.bounds) - self.borderEdgeInsets.top - self.borderEdgeInsets.bottom)];
}
#else
- (BOOL)becomeFirstResponder {
    [self _updateState];
    
    return [super becomeFirstResponder];
}
- (BOOL)resignFirstResponder {
    [self _updateState];
    
    return [super resignFirstResponder];
}

- (BOOL)isOpaque {
    return NO;
}
- (void)drawRect:(NSRect)dirtyRect {
    if (self.backgroundColor) {
        [self.backgroundColor setFill];
        NSRectFill(self.bounds);
    }
    
    if (self.window.screen == nil) {
        return;
    }
    
    CGFloat borderWidth = self.respectScreenScale ? self.borderWidth : self.borderWidth / self.window.screen.backingScaleFactor;
    
    if (self.borderOptions & KDIViewBorderOptionsTop) {
        [self.borderColor setFill];
        if (self.isFlipped) {
            NSRectFill(NSMakeRect(self.borderEdgeInsets.left, self.borderEdgeInsets.top, NSWidth(self.bounds) - self.borderEdgeInsets.left - self.borderEdgeInsets.right, borderWidth));
        }
        else {
            NSRectFill(NSMakeRect(self.borderEdgeInsets.left, NSHeight(self.bounds) - self.borderEdgeInsets.top - borderWidth, NSWidth(self.bounds) - self.borderEdgeInsets.left - self.borderEdgeInsets.right, borderWidth));
        }
    }
    
    if (self.borderOptions & KDIViewBorderOptionsLeft) {
        [self.borderColor setFill];
        NSRectFill(NSMakeRect(self.borderEdgeInsets.left, self.borderEdgeInsets.top, borderWidth, NSHeight(self.bounds) - self.borderEdgeInsets.top - self.borderEdgeInsets.bottom));
    }
    
    if (self.borderOptions & KDIViewBorderOptionsBottom) {
        [self.borderColor setFill];
        if (self.isFlipped) {
            NSRectFill(NSMakeRect(self.borderEdgeInsets.left, NSMaxY(self.bounds) - borderWidth - self.borderEdgeInsets.bottom, NSWidth(self.bounds) - self.borderEdgeInsets.left - self.borderEdgeInsets.right, borderWidth));
        }
        else {
            NSRectFill(NSMakeRect(self.borderEdgeInsets.left, self.borderEdgeInsets.bottom, NSWidth(self.bounds) - self.borderEdgeInsets.left - self.borderEdgeInsets.right, borderWidth));
        }
    }
    
    if (self.borderOptions & KDIViewBorderOptionsRight) {
        [self.borderColor setFill];
        NSRectFill(NSMakeRect(NSMaxX(self.bounds) - borderWidth - self.borderEdgeInsets.right, self.borderEdgeInsets.top, borderWidth, NSHeight(self.bounds) - self.borderEdgeInsets.top - self.borderEdgeInsets.bottom));
    }
}
#endif
    
- (void)setRespectScreenScale:(BOOL)respectScreenScale {
    if (_respectScreenScale == respectScreenScale) {
        return;
    }
    
    _respectScreenScale = respectScreenScale;
    
#if (TARGET_OS_IPHONE)
    [self setNeedsLayout];
#else
    [self setNeedsDisplay:YES];
#endif
}
    
- (void)setBorderOptions:(KDIViewBorderOptions)borderOptions {
    _borderOptions = borderOptions;
    
#if (TARGET_OS_IPHONE)
    if (_borderOptions & KDIViewBorderOptionsTop) {
        if (!self.topBorderView) {
            [self setTopBorderView:[[UIView alloc] initWithFrame:CGRectZero]];
            [self addSubview:self.topBorderView];
        }
    }
    else {
        [self.topBorderView removeFromSuperview];
        [self setTopBorderView:nil];
    }
    
    if (_borderOptions & KDIViewBorderOptionsLeft) {
        if (!self.leftBorderView) {
            [self setLeftBorderView:[[UIView alloc] initWithFrame:CGRectZero]];
            [self addSubview:self.leftBorderView];
        }
    }
    else {
        [self.leftBorderView removeFromSuperview];
        [self setLeftBorderView:nil];
    }
    
    if (_borderOptions & KDIViewBorderOptionsBottom) {
        if (!self.bottomBorderView) {
            [self setBottomBorderView:[[UIView alloc] initWithFrame:CGRectZero]];
            [self addSubview:self.bottomBorderView];
        }
    }
    else {
        [self.bottomBorderView removeFromSuperview];
        [self setBottomBorderView:nil];
    }
    
    if (_borderOptions & KDIViewBorderOptionsRight) {
        if (!self.rightBorderView) {
            [self setRightBorderView:[[UIView alloc] initWithFrame:CGRectZero]];
            [self addSubview:self.rightBorderView];
        }
    }
    else {
        [self.rightBorderView removeFromSuperview];
        [self setRightBorderView:nil];
    }
#else
    [self setNeedsDisplay:YES];
#endif
}
    
- (void)setBorderWidth:(CGFloat)borderWidth {
    _borderWidth = borderWidth;
    
#if (TARGET_OS_IPHONE)
    [self setNeedsLayout];
#else
    [self setNeedsDisplay:YES];
#endif
}

- (void)setBorderEdgeInsets:(KDIEdgeInsets)borderEdgeInsets {
    _borderEdgeInsets = borderEdgeInsets;
        
#if (TARGET_OS_IPHONE)
    [self setNeedsLayout];
#else
    [self setNeedsDisplay:YES];
#endif
}

- (void)setBorderColor:(KDIColor *)borderColor {
    _borderColor = borderColor ?: [self.class _defaultBorderColor];
    
#if (TARGET_OS_IPHONE)
    [self.topBorderView setBackgroundColor:_borderColor];
    [self.leftBorderView setBackgroundColor:_borderColor];
    [self.bottomBorderView setBackgroundColor:_borderColor];
    [self.rightBorderView setBackgroundColor:_borderColor];
#else
    [self setNeedsDisplay:YES];
#endif
}
    
#if (TARGET_OS_OSX)
- (void)setState:(KDIViewState)state {
    _state = state;
    
    [[NSNotificationCenter defaultCenter] postNotificationName:KDIViewNotificationDidChangeState object:self];
}

- (void)setBackgroundColor:(NSColor *)backgroundColor {
    _backgroundColor = backgroundColor;
    
    [self setNeedsDisplay:YES];
}
#endif

+ (CGFloat)_defaultBorderWidth; {
    return 1.0;
}
+ (KDIColor *)_defaultBorderColor; {
    return [KDIColor blackColor];
}
    
- (void)_KDIViewInit; {
    _borderWidth = [self.class _defaultBorderWidth];
    _borderColor = [self.class _defaultBorderColor];
    
#if (TARGET_OS_OSX)
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(_stateDidChange:) name:NSApplicationDidBecomeActiveNotification object:NSApp];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(_stateDidChange:) name:NSApplicationDidResignActiveNotification object:NSApp];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(_stateDidChange:) name:NSWindowDidBecomeMainNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(_stateDidChange:) name:NSWindowDidResignMainNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(_stateDidChange:) name:NSWindowDidBecomeKeyNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(_stateDidChange:) name:NSWindowDidResignKeyNotification object:nil];
#endif
}

#if (TARGET_OS_OSX)
- (void)_updateState; {
    KDIViewState state = KDIViewStateNone;
    
    if ([NSApplication sharedApplication].isActive) {
        state |= KDIViewStateActive;
    }
    if (self.window.isMainWindow) {
        state |= KDIViewStateMain;
    }
    if (self.window.isKeyWindow) {
        state |= KDIViewStateKey;
    }
    if (self.window.firstResponder == self) {
        state |= KDIViewStateFirstResponder;
    }
    
    [self setState:state];
}

- (void)_stateDidChange:(NSNotification *)note {
    [self _updateState];
}
#endif

@end
