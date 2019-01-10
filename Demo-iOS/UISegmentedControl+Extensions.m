//
//  UISegmentedControl+Extensions.m
//  Demo-iOS
//
//  Created by William Towe on 4/9/18.
//  Copyright © 2019 Kosoku Interactive, LLC. All rights reserved.
//
//  Redistribution and use in source and binary forms, with or without modification, are permitted provided that the following conditions are met:
//
//  1. Redistributions of source code must retain the above copyright notice, this list of conditions and the following disclaimer.
//
//  2. Redistributions in binary form must reproduce the above copyright notice, this list of conditions and the following disclaimer in the documentation and/or other materials provided with the distribution.
//
//  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

#import "UISegmentedControl+Extensions.h"

#import <Stanley/Stanley.h>
#import <Ditko/Ditko.h>

@implementation UISegmentedControl (Extensions)

- (void)KSO_configureForBorderedViews:(NSArray<id<KDIBorderedView>> *)borderedViews; {
    kstWeakify(self);
    [self KDI_addBlock:^(__kindof UIControl * _Nonnull control, UIControlEvents controlEvents) {
        kstStrongify(self);
        for (id<KDIBorderedView> borderView in borderedViews) {
            KDIBorderOptions options = borderView.borderOptions;
            
            switch (self.selectedSegmentIndex) {
                case 0:
                    options ^= KDIBorderOptionsTop;
                    break;
                case 1:
                    options ^= KDIBorderOptionsLeft;
                    break;
                case 2:
                    options ^= KDIBorderOptionsBottom;
                    break;
                case 3:
                    options ^= KDIBorderOptionsRight;
                    break;
                default:
                    break;
            }
            
            borderView.borderOptions = options;
        }
    } forControlEvents:UIControlEventValueChanged];
}

@end
