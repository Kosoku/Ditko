//
//  UIBezierPath+KDIExtensions.m
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

#import "UIBezierPath+KDIExtensions.h"

@implementation UIBezierPath (KDIExtensions)

- (void)KDI_strokeInside; {
    [self KDI_strokeInsideWithRect:CGRectZero];
}
- (void)KDI_strokeInsideWithRect:(CGRect)rect; {
    CGFloat lineWidth = self.lineWidth;
    CGContextRef contextRef = UIGraphicsGetCurrentContext();
    
    CGContextSaveGState(contextRef);
    
    [self setLineWidth:lineWidth * 2.0];
    [self addClip];
    
    if (CGRectGetWidth(rect) > 0.0 &&
        CGRectGetHeight(rect) > 0.0) {
        
        CGContextClipToRect(contextRef, rect);
    }
    
    [self stroke];
    
    CGContextRestoreGState(contextRef);
    
    [self setLineWidth:lineWidth];
}

@end
