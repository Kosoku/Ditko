//
//  NSView+KDIExtensions.m
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
