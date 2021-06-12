//
//  UIViewController+Extensions.m
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

#import "UIViewController+Extensions.h"
#import "DetailViewController.h"

#import <Ditko/Ditko.h>

@implementation UIViewController (Extensions)

- (void)KSO_addNavigationBarTitleView; {
    if (![self conformsToProtocol:@protocol(DetailViewController)]) {
        return;
    }
    
    KDINavigationBarTitleView *titleView = [[KDINavigationBarTitleView alloc] initWithFrame:CGRectZero];
    
    titleView.title = self.title;
    if ([self.class respondsToSelector:@selector(detailViewSubtitle)]) {
        titleView.subtitle = [(id<DetailViewController>)self.class detailViewSubtitle];
    }
    
    self.navigationItem.titleView = titleView;
}

@end
