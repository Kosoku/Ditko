//
//  AccessoryView.m
//  Demo-iOS
//
//  Created by William Towe on 4/9/18.
//  Copyright © 2018 Kosoku Interactive, LLC. All rights reserved.
//
//  Redistribution and use in source and binary forms, with or without modification, are permitted provided that the following conditions are met:
//
//  1. Redistributions of source code must retain the above copyright notice, this list of conditions and the following disclaimer.
//
//  2. Redistributions in binary form must reproduce the above copyright notice, this list of conditions and the following disclaimer in the documentation and/or other materials provided with the distribution.
//
//  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

#import "AccessoryView.h"
#import "Constants.h"

#import <Ditko/Ditko.h>

@interface AccessoryView ()
@property (strong,nonatomic) KDIButton *button;
@end

@implementation AccessoryView

- (instancetype)initWithFrame:(CGRect)frame {
    if (!(self = [super initWithFrame:frame]))
        return nil;
    
    self.backgroundColor = KDIColorRandomRGB();
    
    self.button = [KDIButton buttonWithType:UIButtonTypeSystem];
    self.button.contentEdgeInsets = UIEdgeInsetsMake(kSubviewMargin, 0, kSubviewMargin, 0);
    self.button.contentVerticalAlignment = UIControlContentVerticalAlignmentBottom;
    self.button.titleLabel.KDI_dynamicTypeTextStyle = UIFontTextStyleCallout;
    [self.button setTitle:@"Tap to dismiss accessory view" forState:UIControlStateNormal];
    [self.button setTitleColor:[self.backgroundColor KDI_contrastingColor] forState:UIControlStateNormal];
    [self.button KDI_addBlock:^(__kindof UIControl * _Nonnull control, UIControlEvents controlEvents) {
        ((KDIWindow *)UIApplication.sharedApplication.keyWindow).accessoryView = nil;
    } forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.button];
    
    return self;
}

- (CGSize)sizeThatFits:(CGSize)size {
    return [self.button sizeThatFits:size];
}
- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.button.frame = self.bounds;
}

@end
