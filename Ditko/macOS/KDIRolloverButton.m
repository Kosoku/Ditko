//
//  KDIRolloverButton.m
//  Ditko
//
//  Created by William Towe on 4/5/17.
//  Copyright © 2019 Kosoku Interactive, LLC. All rights reserved.
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

#import "KDIRolloverButton.h"

@interface KDIRolloverButton ()
@property (strong,nonatomic) NSMutableDictionary<NSNumber *, NSImage *> *statesToImages;
@property (assign,nonatomic,getter=isActive) BOOL active;
@property (assign,nonatomic,getter=isMouseInside) BOOL mouseInside;
@property (strong,nonatomic) NSTrackingArea *rolloverTrackingArea;

- (void)_KDIRolloverButtonInit;
- (void)_updateImages;
@end

@implementation KDIRolloverButton

- (instancetype)initWithFrame:(NSRect)frameRect {
    if (!(self = [super initWithFrame:frameRect]))
        return nil;
    
    [self _KDIRolloverButtonInit];
    
    return self;
}
- (instancetype)initWithCoder:(NSCoder *)coder {
    if (!(self = [super initWithCoder:coder]))
        return nil;
    
    [self _KDIRolloverButtonInit];
    
    return self;
}

- (void)viewWillMoveToWindow:(NSWindow *)newWindow {
    [super viewWillMoveToWindow:newWindow];
    
    if (self.window != nil) {
        [[NSNotificationCenter defaultCenter] removeObserver:self name:NSWindowDidBecomeMainNotification object:self.window];
        [[NSNotificationCenter defaultCenter] removeObserver:self name:NSWindowDidResignMainNotification object:self.window];
        [[NSNotificationCenter defaultCenter] removeObserver:self name:NSWindowDidBecomeKeyNotification object:self.window];
        [[NSNotificationCenter defaultCenter] removeObserver:self name:NSWindowDidResignKeyNotification object:self.window];
    }
    
    if (newWindow != nil) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(_windowDidChange:) name:NSWindowDidBecomeMainNotification object:newWindow];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(_windowDidChange:) name:NSWindowDidResignMainNotification object:newWindow];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(_windowDidChange:) name:NSWindowDidBecomeKeyNotification object:newWindow];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(_windowDidChange:) name:NSWindowDidResignKeyNotification object:newWindow];
    }
}

- (void)updateTrackingAreas {
    [super updateTrackingAreas];
    
    if (self.rolloverTrackingArea != nil) {
        [self removeTrackingArea:self.rolloverTrackingArea];
    }
    
    [self setMouseInside:NSMouseInRect([self convertPoint:[self.window mouseLocationOutsideOfEventStream] fromView:nil], self.visibleRect, self.isFlipped)];
    
    NSTrackingAreaOptions options = NSTrackingMouseEnteredAndExited|NSTrackingActiveAlways;
    
    if (self.isMouseInside) {
        options |= NSTrackingAssumeInside;
    }
    
    [self setRolloverTrackingArea:[[NSTrackingArea alloc] initWithRect:self.bounds options:options owner:self userInfo:nil]];
    [self addTrackingArea:self.rolloverTrackingArea];
}

- (void)mouseEntered:(NSEvent *)event {
    [self setMouseInside:YES];
}
- (void)mouseExited:(NSEvent *)event {
    [self setMouseInside:NO];
}

- (void)setImage:(NSImage *)image forState:(KDIRolloverButtonState)state; {
    if (image == nil) {
        [self.statesToImages removeObjectForKey:@(state)];
    }
    else {
        [self.statesToImages setObject:image forKey:@(state)];
    }
    
    [self _updateImages];
}

- (void)_KDIRolloverButtonInit; {
    [self setButtonType:NSButtonTypeMomentaryChange];
    [self setBordered:NO];
}
- (void)_updateImages; {
    NSImage *image = self.statesToImages[@(KDIRolloverButtonStateNormal)];
    NSImage *alternateImage = self.statesToImages[@(KDIRolloverButtonStatePressed)];
    
    if (self.isMouseInside) {
        if (self.statesToImages[@(KDIRolloverButtonStateRollover)] != nil) {
            image = self.statesToImages[@(KDIRolloverButtonStateRollover)];
        }
        
        if (!self.isActive &&
            self.statesToImages[@(KDIRolloverButtonStateRolloverInactive)] != nil) {
            
            image = self.statesToImages[@(KDIRolloverButtonStateRolloverInactive)];
        }
    }
    else if (!self.isActive) {
        if (self.statesToImages[@(KDIRolloverButtonStateNormalInactive)] != nil) {
            image = self.statesToImages[@(KDIRolloverButtonStateNormalInactive)];
        }
        if (self.statesToImages[@(KDIRolloverButtonStatePressedInactive)] != nil) {
            alternateImage = self.statesToImages[@(KDIRolloverButtonStatePressedInactive)];
        }
    }
    
    [self setImage:image];
    [self setAlternateImage:alternateImage];
}

- (NSMutableDictionary *)statesToImages {
    if (_statesToImages == nil) {
        _statesToImages = [[NSMutableDictionary alloc] init];
    }
    return _statesToImages;
}
- (void)setActive:(BOOL)active {
    _active = active;
    
    [self _updateImages];
}
- (void)setMouseInside:(BOOL)mouseInside {
    _mouseInside = mouseInside;
    
    [self _updateImages];
}

- (void)_windowDidChange:(NSNotification *)note {
    [self setActive:(self.window.styleMask & NSWindowStyleMaskFullScreen) || self.window.isMainWindow || self.window.isKeyWindow];
}

@end
