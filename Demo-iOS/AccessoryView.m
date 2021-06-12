//
//  AccessoryView.m
//  Demo-iOS
//
//  Created by William Towe on 4/9/18.
//  Copyright © 2021 Kosoku Interactive, LLC. All rights reserved.
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
        ((KDIWindow *)self.window).accessoryView = nil;
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
