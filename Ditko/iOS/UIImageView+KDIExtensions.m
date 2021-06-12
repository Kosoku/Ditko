//
//  UIImageView+KDIExtensions.m
//  Ditko-iOS
//
//  Created by Jason Anderson on 9/25/18.
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

#import "UIImageView+KDIExtensions.h"

@implementation UIImageView (KDIExtensions)

- (CGRect)KDI_contentRect; {
    CGRect retval = self.bounds;
    
    if (self.image && self.contentMode == UIViewContentModeScaleAspectFit && self.image.size.width > 0 && self.image.size.height > 0) {
        CGFloat scale;
        if (self.image.size.width > self.image.size.height) {
            scale = self.bounds.size.width / self.image.size.width;
        } else {
            scale = self.bounds.size.height / self.image.size.height;
        }
        
        CGSize size = CGSizeMake(self.image.size.width * scale, self.image.size.height * scale);
        CGFloat x = (self.bounds.size.width - size.width) / 2.0;
        CGFloat y = (self.bounds.size.height - size.height) / 2.0;
        retval = CGRectMake(x, y, size.width, size.height);
    }
    
    return retval;
}

@end
