//
//  KDIBadgeView.m
//  Ditko
//
//  Created by William Towe on 3/10/17.
//  Copyright © 2017 Kosoku Interactive, LLC. All rights reserved.
//
//  Redistribution and use in source and binary forms, with or without modification, are permitted provided that the following conditions are met:
//
//  1. Redistributions of source code must retain the above copyright notice, this list of conditions and the following disclaimer.
//
//  2. Redistributions in binary form must reproduce the above copyright notice, this list of conditions and the following disclaimer in the documentation and/or other materials provided with the distribution.
//
//  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

#import "KDIBadgeView.h"
#import "KDIDefines.h"

#import <Stanley/KSTGeometryFunctions.h>

@interface KDIBadgeView ()

- (void)_KDIBadgeViewInit;

+ (KDIColor *)_defaultBadgeForegroundColor;
+ (KDIColor *)_defaultBadgeBackgroundColor;
+ (KDIColor *)_defaultBadgeHighlightedForegroundColor;
+ (KDIColor *)_defaultBadgeHighlightedBackgroundColor;
+ (KDIFont *)_defaultBadgeFont;
+ (KDIEdgeInsets)_defaultBadgeEdgeInsets;
+ (CGFloat)_defaultBadgeCornerRadius;
@end

@implementation KDIBadgeView

#pragma mark ** Subclass Overrides **
- (instancetype)initWithFrame:(KDIRect)frame {
    if (!(self = [super initWithFrame:frame]))
        return nil;
    
    [self _KDIBadgeViewInit];
    
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    if (!(self = [super initWithCoder:aDecoder]))
        return nil;
    
    [self _KDIBadgeViewInit];
    
    return self;
}

- (KDISize)intrinsicContentSize {
    return [self sizeThatFits:KDISizeZero];
}

- (KDISize)sizeThatFits:(KDISize)size {
    if (self.badge.length == 0) {
        return KDISizeZero;
    }
    
    KDISize retval = [self.badge sizeWithAttributes:@{NSFontAttributeName: self.badgeFont}];
    
    retval.width += self.badgeEdgeInsets.left + self.badgeEdgeInsets.right;
    retval.height += self.badgeEdgeInsets.top + self.badgeEdgeInsets.bottom;
    
    if (retval.height > retval.width) {
        retval.width = retval.height;
    }
    
    return retval;
}

- (BOOL)isOpaque {
    return NO;
}

- (void)drawRect:(KDIRect)rect {
    if (self.isHighlighted) {
        [self.badgeHighlightedBackgroundColor setFill];
    }
    else {
        [self.badgeBackgroundColor setFill];
    }
    
#if (TARGET_OS_IPHONE)
    [[UIBezierPath bezierPathWithRoundedRect:self.bounds cornerRadius:self.badgeCornerRadius] fill];
#else
    [[NSBezierPath bezierPathWithRoundedRect:self.bounds xRadius:self.badgeCornerRadius yRadius:self.badgeCornerRadius] fill];
#endif
    
    KDISize size = [self.badge sizeWithAttributes:@{NSFontAttributeName: self.badgeFont}];
    
    [self.badge drawInRect:KSTCGRectCenterInRect(CGRectMake(0, 0, size.width, size.height), self.bounds) withAttributes:@{NSFontAttributeName: self.badgeFont, NSForegroundColorAttributeName: self.isHighlighted ? self.badgeHighlightedForegroundColor : self.badgeForegroundColor}];
}
#pragma mark ** Public Methods **
#pragma mark Properties
- (void)setHighlighted:(BOOL)highlighted {
    _highlighted = highlighted;
    
#if (TARGET_OS_IPHONE)
    [self setNeedsDisplay];
#else
    [self setNeedsDisplay:YES];
#endif
}

- (void)setBadge:(NSString *)badge {
    _badge = badge;
    
#if (TARGET_OS_IPHONE)
    [self setNeedsDisplay];
#else
    [self setNeedsDisplay:YES];
#endif
    [self invalidateIntrinsicContentSize];
}

- (void)setBadgeForegroundColor:(KDIColor *)badgeForegroundColor {
    _badgeForegroundColor = badgeForegroundColor ?: [self.class _defaultBadgeForegroundColor];
    
#if (TARGET_OS_IPHONE)
    [self setNeedsDisplay];
#else
    [self setNeedsDisplay:YES];
#endif
}

- (void)setBadgeBackgroundColor:(KDIColor *)badgeBackgroundColor {
    _badgeBackgroundColor = badgeBackgroundColor ?: [self.class _defaultBadgeBackgroundColor];
    
#if (TARGET_OS_IPHONE)
    [self setNeedsDisplay];
#else
    [self setNeedsDisplay:YES];
#endif
}

- (void)setBadgeHighlightedForegroundColor:(KDIColor *)badgeHighlightedForegroundColor {
    _badgeHighlightedForegroundColor = badgeHighlightedForegroundColor ?: [self.class _defaultBadgeHighlightedForegroundColor];
    
#if (TARGET_OS_IPHONE)
    [self setNeedsDisplay];
#else
    [self setNeedsDisplay:YES];
#endif
}
- (void)setBadgeHighlightedBackgroundColor:(KDIColor *)badgeHighlightedBackgroundColor {
    _badgeHighlightedBackgroundColor = badgeHighlightedBackgroundColor ?: [self.class _defaultBadgeHighlightedBackgroundColor];
    
#if (TARGET_OS_IPHONE)
    [self setNeedsDisplay];
#else
    [self setNeedsDisplay:YES];
#endif
}

- (void)setBadgeFont:(KDIFont *)badgeFont {
    _badgeFont = badgeFont ?: [self.class _defaultBadgeFont];
    
#if (TARGET_OS_IPHONE)
    [self setNeedsDisplay];
#else
    [self setNeedsDisplay:YES];
#endif
    [self invalidateIntrinsicContentSize];
}
- (void)setBadgeCornerRadius:(CGFloat)badgeCornerRadius {
    _badgeCornerRadius = (badgeCornerRadius < 0.0) ? [self.class _defaultBadgeCornerRadius] : badgeCornerRadius;
    
#if (TARGET_OS_IPHONE)
    [self setNeedsDisplay];
#else
    [self setNeedsDisplay:YES];
#endif
}
- (void)setBadgeEdgeInsets:(KDIEdgeInsets)badgeEdgeInsets {
    _badgeEdgeInsets = badgeEdgeInsets;
    
#if (TARGET_OS_IPHONE)
    [self setNeedsDisplay];
#else
    [self setNeedsDisplay:YES];
#endif
    [self invalidateIntrinsicContentSize];
}
#pragma mark ** Private Methods **
- (void)_KDIBadgeViewInit; {
#if (TARGET_OS_IPHONE)
    [self setUserInteractionEnabled:NO];
#endif
    _badgeForegroundColor = [self.class _defaultBadgeForegroundColor];
    _badgeBackgroundColor = [self.class _defaultBadgeBackgroundColor];
    _badgeHighlightedForegroundColor = [self.class _defaultBadgeHighlightedForegroundColor];
    _badgeHighlightedBackgroundColor = [self.class _defaultBadgeHighlightedBackgroundColor];
    _badgeFont = [self.class _defaultBadgeFont];
    _badgeCornerRadius = [self.class _defaultBadgeCornerRadius];
    _badgeEdgeInsets = [self.class _defaultBadgeEdgeInsets];
}

+ (KDIColor *)_defaultBadgeForegroundColor; {
    return [KDIColor whiteColor];
}
+ (KDIColor *)_defaultBadgeBackgroundColor; {
    return [KDIColor blackColor];
}
+ (KDIColor *)_defaultBadgeHighlightedForegroundColor; {
    return [KDIColor lightGrayColor];
}
+ (KDIColor *)_defaultBadgeHighlightedBackgroundColor; {
    return [KDIColor whiteColor];
}
+ (KDIFont *)_defaultBadgeFont; {
    return [KDIFont boldSystemFontOfSize:17.0];
}
+ (KDIEdgeInsets)_defaultBadgeEdgeInsets; {
    return KDIEdgeInsetsMake(4.0, 8.0, 4.0, 8.0);
}
+ (CGFloat)_defaultBadgeCornerRadius; {
    return 8.0;
}

@end
