//
//  UIScrollView+KDIExtensions.m
//  Ditko
//
//  Created by William Towe on 3/6/18.
//  Copyright © 2018 Kosoku Interactive, LLC. All rights reserved.
//
//  Redistribution and use in source and binary forms, with or without modification, are permitted provided that the following conditions are met:
//
//  1. Redistributions of source code must retain the above copyright notice, this list of conditions and the following disclaimer.
//
//  2. Redistributions in binary form must reproduce the above copyright notice, this list of conditions and the following disclaimer in the documentation and/or other materials provided with the distribution.
//
//  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

#import "UIScrollView+KDIExtensions.h"

@interface UIScrollView (KDIPrivateExtensions)
- (BOOL)_KDI_canScroll;
- (CGRect)_KDI_bottomRect;
@end

@implementation UIScrollView (KDIExtensions)

- (void)KDI_scrollToTopAnimated:(BOOL)animated; {
    if ([self _KDI_canScroll]) {
        [self setContentOffset:CGPointMake(self.contentInset.left, self.contentInset.top) animated:animated];
    }
}
- (void)KDI_scrollToBottomAnimated:(BOOL)animated; {
    if ([self _KDI_canScroll]) {
        [self setContentOffset:[self _KDI_bottomRect].origin animated:animated];
    }
}

- (BOOL)KDI_isAtTop {
    return CGRectGetMinY(self.KDI_visibleRect) <= CGRectGetMinY(self.bounds);
}
- (BOOL)KDI_isAtBottom {
    return CGRectGetMaxY(self.KDI_visibleRect) >= CGRectGetMaxY([self _KDI_bottomRect]);
}
- (CGRect)KDI_visibleRect {
    return CGRectMake(self.contentOffset.x, self.contentOffset.y, CGRectGetWidth(self.frame), CGRectGetHeight(self.frame));
}

@end

@implementation UIScrollView (KDIPrivateExtensions)
- (BOOL)_KDI_canScroll; {
    return self.contentSize.height > CGRectGetHeight(self.frame);
}
- (CGRect)_KDI_bottomRect; {
    return CGRectMake(self.contentInset.left, self.contentSize.height - CGRectGetHeight(self.bounds) + self.contentInset.bottom, CGRectGetWidth(self.bounds), CGRectGetHeight(self.bounds));
}
@end
