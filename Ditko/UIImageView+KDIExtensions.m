//
//  UIImageView+KDIExtensions.m
//  Ditko-iOS
//
//  Created by Jason Anderson on 9/25/18.
//  Copyright © 2018 Kosoku Interactive, LLC. All rights reserved.
//

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
