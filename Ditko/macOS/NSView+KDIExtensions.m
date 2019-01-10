//
//  NSView+KDIExtensions.m
//  Ditko
//
//  Created by William Towe on 3/10/17.
//  Copyright © 2019 Kosoku Interactive, LLC. All rights reserved.
//
//  Redistribution and use in source and binary forms, with or without modification, are permitted provided that the following conditions are met:
//
//  1. Redistributions of source code must retain the above copyright notice, this list of conditions and the following disclaimer.
//
//  2. Redistributions in binary form must reproduce the above copyright notice, this list of conditions and the following disclaimer in the documentation and/or other materials provided with the distribution.
//
//  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

#import "NSView+KDIExtensions.h"

#import <objc/runtime.h>

@implementation NSView (KDIExtensions)

@dynamic KDI_frameMinimumX;
- (CGFloat)KDI_frameMinimumX {
    return NSMinX(self.frame);
}
- (void)setKDI_frameMinimumX:(CGFloat)KDI_frameMinimumX {
    [self setFrame:NSMakeRect(KDI_frameMinimumX, NSMinY(self.frame), NSWidth(self.frame), NSHeight(self.frame))];
}
@dynamic KDI_frameMaximumX;
- (CGFloat)KDI_frameMaximumX {
    return NSMaxX(self.frame);
}
- (void)setKDI_frameMaximumX:(CGFloat)KDI_frameMaximumX {
    [self setFrame:NSMakeRect(KDI_frameMaximumX - NSWidth(self.frame), NSMinY(self.frame), NSWidth(self.frame), NSHeight(self.frame))];
}
@dynamic KDI_frameMinimumY;
- (CGFloat)KDI_frameMinimumY {
    return NSMinY(self.frame);
}
- (void)setKDI_frameMinimumY:(CGFloat)KDI_frameMinimumY {
    [self setFrame:NSMakeRect(NSMinX(self.frame), KDI_frameMinimumY, NSWidth(self.frame), NSHeight(self.frame))];
}
@dynamic KDI_frameMaximumY;
- (CGFloat)KDI_frameMaximumY {
    return NSMaxY(self.frame);
}
- (void)setKDI_frameMaximumY:(CGFloat)KDI_frameMaximumY {
    [self setFrame:NSMakeRect(NSMinX(self.frame), KDI_frameMaximumY - NSHeight(self.frame), NSWidth(self.frame), NSHeight(self.frame))];
}
@dynamic KDI_frameWidth;
- (CGFloat)KDI_frameWidth {
    return NSWidth(self.frame);
}
- (void)setKDI_frameWidth:(CGFloat)KDI_frameWidth {
    [self setFrame:NSMakeRect(NSMinX(self.frame), NSMinY(self.frame), KDI_frameWidth, NSHeight(self.frame))];
}
@dynamic KDI_frameHeight;
- (CGFloat)KDI_frameHeight {
    return NSHeight(self.frame);
}
- (void)setKDI_frameHeight:(CGFloat)KDI_frameHeight {
    [self setFrame:NSMakeRect(NSMinX(self.frame), NSMinY(self.frame), NSWidth(self.frame), KDI_frameHeight)];
}

- (NSArray<__kindof NSView *> *)KDI_recursiveSubviews {
    NSMutableOrderedSet *retval = [[NSMutableOrderedSet alloc] init];
    
    for (NSView *view in self.subviews) {
        [retval addObject:view];
        [retval addObjectsFromArray:[view KDI_recursiveSubviews]];
    }
    
    return retval.array;
}

@end
