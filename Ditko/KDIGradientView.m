//
//  KDIGradientView.m
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

#import "KDIGradientView.h"

#import <QuartzCore/QuartzCore.h>

@interface KDIGradientView ()
@property (readonly,nonatomic) CAGradientLayer *layer;

- (void)_KDIGradientViewInit;
@end

@implementation KDIGradientView
#pragma mark *** Subclass Overrides ***
#if (TARGET_OS_IPHONE)
- (instancetype)initWithFrame:(CGRect)frame {
#else
- (instancetype)initWithFrame:(NSRect)frame {
#endif
    if (!(self = [super initWithFrame:frame]))
        return nil;
    
    [self _KDIGradientViewInit];
    
    return self;
}
    
#if (TARGET_OS_IPHONE)
+ (Class)layerClass {
    return [CAGradientLayer class];
}
#endif
#pragma mark Properties
@dynamic colors;
- (NSArray *)colors {
    NSMutableArray *retval = [[NSMutableArray alloc] init];
    NSArray *CGColors = self.layer.colors;
    
    for (NSInteger i=0; i<CGColors.count; i++) {
        CGColorRef colorRef = (__bridge CGColorRef)CGColors[i];
        
#if (TARGET_OS_IPHONE)
        [retval addObject:[UIColor colorWithCGColor:colorRef]];
#else
        [retval addObject:[NSColor colorWithCGColor:colorRef]];
#endif
    }
    
    return [retval copy];
}
    
- (void)setColors:(NSArray *)colors {
    NSMutableArray *temp = [[NSMutableArray alloc] init];
    
#if (TARGET_OS_IPHONE)
    for (UIColor *color in colors) {
#else
    for (NSColor *color in colors) {
#endif
        [temp addObject:(__bridge id)color.CGColor];
    }
    
    [self.layer setColors:temp];
}
        
@dynamic locations;
- (NSArray *)locations {
    return self.layer.locations;
}
- (void)setLocations:(NSArray *)locations {
    [self.layer setLocations:locations];
}
    
@dynamic startPoint;
#if (TARGET_OS_IPHONE)
- (CGPoint)startPoint {
    return self.layer.startPoint;
#else
- (NSPoint)startPoint {
    return NSPointFromCGPoint(self.layer.startPoint);
#endif
}
    
#if (TARGET_OS_IPHONE)
- (void)setStartPoint:(CGPoint)startPoint {
    [self.layer setStartPoint:startPoint];
#else
- (void)setStartPoint:(NSPoint)startPoint {
    [self.layer setStartPoint:NSPointToCGPoint(startPoint)];
#endif
}
    
@dynamic endPoint;
#if (TARGET_OS_IPHONE)
- (CGPoint)endPoint {
    return self.layer.endPoint;
#else
- (NSPoint)endPoint {
    return NSPointFromCGPoint(self.layer.endPoint);
#endif
}

#if (TARGET_OS_IPHONE)
- (void)setEndPoint:(CGPoint)endPoint {
    [self.layer setEndPoint:endPoint];
#else
- (void)setEndPoint:(NSPoint)endPoint {
    [self.layer setEndPoint:NSPointToCGPoint(endPoint)];
#endif
}
#pragma mark *** Private Methods ***
- (void)_KDIGradientViewInit {
#if (TARGET_OS_IPHONE)
    [self setBackgroundColor:[UIColor clearColor]];
#else
    [self setWantsLayer:YES];
    [self setLayer:[CAGradientLayer layer]];
#endif
}
#pragma mark Properties
@dynamic layer;
    
@end
