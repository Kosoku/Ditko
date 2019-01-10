//
//  KDIBadgeView.m
//  Ditko
//
//  Created by William Towe on 3/10/17.
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

#if (TARGET_OS_IPHONE)
#pragma mark KDIDynamicTypeObject
- (SEL)dynamicTypeSetFontSelector {
    return @selector(setBadgeFont:);
}
#endif

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
    self.isAccessibilityElement = _badge.length > 0;
#else
    self.accessibilityElement = _badge.length > 0;
#endif
    
    self.accessibilityLabel = _badge;
    
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
    self.accessibilityTraits = UIAccessibilityTraitStaticText;
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
