//
//  UIScrollView+KDIExtensions.m
//  Ditko
//
//  Created by William Towe on 3/6/18.
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
        if ([self isKindOfClass:UITableView.class]) {
            UITableView *tableView = (UITableView *)self;
            NSInteger section = [tableView numberOfSections] - 1;
            NSInteger row = [tableView numberOfRowsInSection:section] - 1;
            
            if (row == -1) {
                return;
            }
            
            [tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:row inSection:section] atScrollPosition:UITableViewScrollPositionBottom animated:animated];
        }
        else if ([self isKindOfClass:UICollectionView.class]) {
            UICollectionView *collectionView = (UICollectionView *)self;
            NSInteger section = [collectionView numberOfSections] - 1;
            NSInteger item = [collectionView numberOfItemsInSection:section] - 1;
            
            if (item == -1) {
                return;
            }
            
            [collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:item inSection:section] atScrollPosition:UICollectionViewScrollPositionBottom animated:animated];
        }
        else {
            [self setContentOffset:[self _KDI_bottomRect].origin animated:animated];
        }
    }
}

- (BOOL)KDI_isAtTop {
    return self.contentOffset.y <= self.contentInset.top;
}
- (BOOL)KDI_isAtBottom {
    return self.contentOffset.y >= (floor(self.contentSize.height) - CGRectGetHeight(self.frame) + self.contentInset.bottom);
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
