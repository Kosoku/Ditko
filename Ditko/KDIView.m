//
//  KDIView.m
//  Ditko
//
//  Created by William Towe on 3/8/17.
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
