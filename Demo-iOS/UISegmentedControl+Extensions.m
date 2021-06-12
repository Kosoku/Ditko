//
//  UISegmentedControl+Extensions.m
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
