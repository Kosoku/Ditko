//
//  KDIClickableLabel.m
//  Ditko
//
//  Created by William Towe on 4/7/17.
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

#import "KDIClickableLabel.h"

@interface KDIClickableLabel ()
@property (assign,nonatomic,getter=isMouseInside) BOOL mouseInside;
@property (strong,nonatomic) NSTrackingArea *clickableTrackingArea;

@property (copy,nonatomic) NSAttributedString *originalAttributedString;

@property (strong,nonatomic) NSClickGestureRecognizer *clickGestureRecognizer;

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
    
    _clickGestureRecognizer = [[NSClickGestureRecognizer alloc] initWithTarget:self action:@selector(_clickGestureRecognizerAction:)];
    [self addGestureRecognizer:_clickGestureRecognizer];
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

- (IBAction)_clickGestureRecognizerAction:(id)sender {
    if (self.block != nil) {
        self.block(self);
    }
}

@end
