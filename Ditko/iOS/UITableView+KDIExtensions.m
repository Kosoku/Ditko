//
//  UITableView+KDIExtensions.m
//  Ditko
//
//  Created by William Towe on 4/4/18.
//  Copyright © 2018 Kosoku Interactive, LLC. All rights reserved.
//
//  Redistribution and use in source and binary forms, with or without modification, are permitted provided that the following conditions are met:
//
//  1. Redistributions of source code must retain the above copyright notice, this list of conditions and the following disclaimer.
//
//  2. Redistributions in binary form must reproduce the above copyright notice, this list of conditions and the following disclaimer in the documentation and/or other materials provided with the distribution.
//
//  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

#import "UITableView+KDIExtensions.h"

@implementation UITableView (KDIExtensions)

- (void)KDI_reloadHeightAnimated:(BOOL)animated; {
    [self KDI_reloadHeightAnimated:animated block:nil];
}
- (void)KDI_reloadHeightAnimated:(BOOL)animated block:(dispatch_block_t)block; {
    [self KDI_reloadHeightAnimated:animated block:block completion:nil];
}
- (void)KDI_reloadHeightAnimated:(BOOL)animated block:(dispatch_block_t)block completion:(dispatch_block_t)completion {
    void(^reload)(void) = ^{
        [CATransaction begin];
        [CATransaction setCompletionBlock:completion];
        
        [self beginUpdates];
        
        if (block != nil) {
            block();
        }
        
        [self endUpdates];
        
        [CATransaction commit];
    };
    
    if (animated) {
        reload();
    }
    else {
        [UIView performWithoutAnimation:reload];
    }
}

@end
