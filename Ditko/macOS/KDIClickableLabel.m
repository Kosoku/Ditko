//
//  KDIClickableLabel.m
//  Ditko
//
//  Created by William Towe on 4/7/17.
//  Copyright © 2017 Kosoku Interactive, LLC. All rights reserved.
//
//  Redistribution and use in source and binary forms, with or without modification, are permitted provided that the following conditions are met:
//
//  1. Redistributions of source code must retain the above copyright notice, this list of conditions and the following disclaimer.
//
//  2. Redistributions in binary form must reproduce the above copyright notice, this list of conditions and the following disclaimer in the documentation and/or other materials provided with the distribution.
//
//  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

#import "KDIClickableLabel.h"

@interface KDIClickableLabel ()
@property (assign,nonatomic,getter=isMouseInside) BOOL mouseInside;
@property (strong,nonatomic) NSTrackingArea *clickableTrackingArea;

@property (copy,nonatomic) NSAttributedString *originalAttributedString;

- (void)_KDIClickableLabelInit;

+ (NSDictionary *)_defaultClickableTextAttributes;
+ (NSCursor *)_defaultClickableCursor;
@end

@implementation KDIClickableLabel

- (instancetype)initWithFrame:(NSRect)frameRect {
    if (!(self = [super initWithFrame:frameRect]))
        return nil;
    
    [self _KDIClickableLabelInit];
    
    return self;
}
- (instancetype)initWithCoder:(NSCoder *)coder {
    if (!(self = [super initWithCoder:coder]))
        return nil;
    
    [self _KDIClickableLabelInit];
    
    return self;
}

- (void)mouseEntered:(NSEvent *)event {
    [self setMouseInside:YES];
}
- (void)mouseExited:(NSEvent *)event {
    [self setMouseInside:NO];
}
- (void)cursorUpdate:(NSEvent *)event {
    [self.clickableCursor push];
}
- (void)mouseUp:(NSEvent *)event {
    if (self.block != nil) {
        self.block(self);
    }
}

- (void)updateTrackingAreas {
    [super updateTrackingAreas];
    
    if (self.clickableTrackingArea != nil) {
        [self removeTrackingArea:self.clickableTrackingArea];
    }
    
    [self setMouseInside:NSMouseInRect([self convertPoint:[self.window mouseLocationOutsideOfEventStream] fromView:nil], self.visibleRect, self.isFlipped)];
    
    NSTrackingAreaOptions options = NSTrackingMouseEnteredAndExited|NSTrackingCursorUpdate|NSTrackingActiveInActiveApp|NSTrackingInVisibleRect;
    
    if (self.isMouseInside) {
        options |= NSTrackingAssumeInside;
    }
    
    [self setClickableTrackingArea:[[NSTrackingArea alloc] initWithRect:NSZeroRect options:options owner:self userInfo:nil]];
    [self addTrackingArea:self.clickableTrackingArea];
}

- (void)setClickableTextAttributes:(NSDictionary<NSString *,id> *)clickableTextAttributes {
    _clickableTextAttributes = clickableTextAttributes ?: [self.class _defaultClickableTextAttributes];
}
- (void)setClickableCursor:(NSCursor *)clickableCursor {
    _clickableCursor = clickableCursor ?: [self.class _defaultClickableCursor];
}

- (void)_KDIClickableLabelInit; {
    _clickableTextAttributes = [self.class _defaultClickableTextAttributes];
    _clickableCursor = [self.class _defaultClickableCursor];
    
    [self setBezeled:NO];
    [self setBordered:NO];
    [self setDrawsBackground:NO];
    [self setEditable:NO];
    [self setSelectable:NO];
}

+ (NSDictionary *)_defaultClickableTextAttributes; {
    return @{NSForegroundColorAttributeName: [NSColor blueColor],
             NSUnderlineColorAttributeName: [NSColor blueColor],
             NSUnderlineStyleAttributeName: @(NSUnderlineStyleSingle|NSUnderlinePatternSolid)};
}
+ (NSCursor *)_defaultClickableCursor; {
    return [NSCursor pointingHandCursor];
}

- (void)setMouseInside:(BOOL)mouseInside {
    if (_mouseInside == mouseInside) {
        return;
    }
    
    _mouseInside = mouseInside;
    
    if (_mouseInside) {
        [self setOriginalAttributedString:self.attributedStringValue];
        
        if (self.clickableTextAttributes != nil) {
            NSMutableAttributedString *attributedString = [self.attributedStringValue mutableCopy];
            
            [attributedString addAttributes:self.clickableTextAttributes range:NSMakeRange(0, attributedString.length)];
            
            [self setAttributedStringValue:attributedString];
        }
    }
    else {
        if (self.originalAttributedString != nil) {
            [self setAttributedStringValue:self.originalAttributedString];
        }
    }
}

@end
