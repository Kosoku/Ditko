//
//  KDIView.m
//  Ditko
//
//  Created by William Towe on 3/8/17.
//  Copyright © 2018 Kosoku Interactive, LLC. All rights reserved.
//
//  Redistribution and use in source and binary forms, with or without modification, are permitted provided that the following conditions are met:
//
//  1. Redistributions of source code must retain the above copyright notice, this list of conditions and the following disclaimer.
//
//  2. Redistributions in binary form must reproduce the above copyright notice, this list of conditions and the following disclaimer in the documentation and/or other materials provided with the distribution.
//
//  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

#import "KDIView.h"
#import "KDIBorderedViewImpl.h"

#if (TARGET_OS_OSX)
NSNotificationName const KDIViewNotificationDidChangeState = @"KDIViewNotificationDidChangeState";
#endif

@interface KDIView ()
#if (TARGET_OS_OSX)
@property (readwrite,assign,nonatomic) KDIViewState state;
#endif
@property (strong,nonatomic) KDIBorderedViewImpl *borderedViewImpl;

- (void)_KDIViewInit;
#if (TARGET_OS_OSX)
- (void)_updateState;
#endif
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

#pragma mark -
- (id)forwardingTargetForSelector:(SEL)aSelector {
    if ([self.borderedViewImpl respondsToSelector:aSelector]) {
        return self.borderedViewImpl;
    }
    return [super forwardingTargetForSelector:aSelector];
}
    
#if (TARGET_OS_OSX)
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
    
    [self.borderedViewImpl drawRect:dirtyRect];
}
#else
- (void)layoutSubviews {
    [super layoutSubviews];
    
    [self.borderedViewImpl layoutSubviews];
}
#endif
    
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
#pragma mark KDIBorderedView
@dynamic borderOptions;
@dynamic borderWidth;
@dynamic borderWidthRespectsScreenScale;
@dynamic borderEdgeInsets;
@dynamic borderColor;
#if (TARGET_OS_IPHONE)
- (void)setBorderColor:(KDIColor *)borderColor animated:(BOOL)animated {
    [self.borderedViewImpl setBorderColor:borderColor animated:animated];
}
#endif
#pragma mark *** Private Methods ***
- (void)_KDIViewInit; {
    _borderedViewImpl = [[KDIBorderedViewImpl alloc] initWithView:self];
    
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
