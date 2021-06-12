//
//  UIBarButtonItem+KDIExtensions.m
//  Ditko
//
//  Created by William Towe on 3/10/17.
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

#import "UIBarButtonItem+KDIExtensions.h"

#import <Stanley/KSTLoggingMacros.h>
#import <Stanley/KSTFunctions.h>

#import <objc/runtime.h>

static void const *kKDIBlockKey = &kKDIBlockKey;

@interface UIBarButtonItem (KDIPrivateExtensions)
- (IBAction)_KDI_blockAction:(UIBarButtonItem *)sender;
@end

@implementation UIBarButtonItem (KDIExtensions)

+ (UIBarButtonItem *)KDI_flexibleSpaceBarButtonItem; {
    return [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:NULL];
}
+ (UIBarButtonItem *)KDI_fixedSpaceBarButtonItemWithWidth:(CGFloat)width; {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [button setUserInteractionEnabled:NO];
    [button setImage:({
        UIGraphicsBeginImageContextWithOptions(CGSizeMake(width, 1), NO, 0);
        
        [[UIColor clearColor] setFill];
        UIRectFill(CGRectMake(0, 0, width, 1));
        
        UIImage *retval = UIGraphicsGetImageFromCurrentImageContext();
        
        UIGraphicsEndImageContext();
        
        retval;
    }) forState:UIControlStateNormal];
    
    [button sizeToFit];
    
    UIBarButtonItem *retval = [[UIBarButtonItem alloc] initWithCustomView:button];
    
    return retval;
}

+ (UIBarButtonItem *)KDI_labelBarButtonItemWithText:(NSString *)text; {
    return [self KDI_labelBarButtonItemWithText:text color:nil font:nil];
}
+ (UIBarButtonItem *)KDI_labelBarButtonItemWithText:(NSString *)text color:(UIColor *)color; {
    return [self KDI_labelBarButtonItemWithText:text color:color font:nil];
}
+ (UIBarButtonItem *)KDI_labelBarButtonItemWithText:(NSString *)text color:(UIColor *)color font:(UIFont *)font; {
    NSParameterAssert(text != nil);
    
    if (color == nil) {
        color = UIColor.blackColor;
    }
    if (font == nil) {
        font = [UIFont systemFontOfSize:17.0];
    }
    
    UILabel *view = [[UILabel alloc] initWithFrame:CGRectZero];
    
    view.text = text;
    view.textColor = color;
    view.font = font;
    
    return [[UIBarButtonItem alloc] initWithCustomView:view];
}

+ (UIBarButtonItem *)KDI_barButtonItemWithImage:(UIImage *)image style:(UIBarButtonItemStyle)style block:(KDIUIBarButtonItemBlock)block {
    UIBarButtonItem *retval = [[UIBarButtonItem alloc] initWithImage:image style:style target:nil action:NULL];
    
    [retval setKDI_block:block];
    
    return retval;
}
+ (UIBarButtonItem *)KDI_barButtonItemWithTitle:(NSString *)title style:(UIBarButtonItemStyle)style block:(KDIUIBarButtonItemBlock)block {
    UIBarButtonItem *retval = [[UIBarButtonItem alloc] initWithTitle:title style:style target:nil action:NULL];
    
    [retval setKDI_block:block];
    
    return retval;
}
+ (UIBarButtonItem *)KDI_barButtonSystemItem:(UIBarButtonSystemItem)barButtonSystemItem block:(KDIUIBarButtonItemBlock)block; {
    UIBarButtonItem *retval = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:barButtonSystemItem target:nil action:NULL];
    
    [retval setKDI_block:block];
    
    return retval;
}

@dynamic KDI_block;
- (KDIUIBarButtonItemBlock)KDI_block {
    return objc_getAssociatedObject(self, kKDIBlockKey);
}
- (void)setKDI_block:(KDIUIBarButtonItemBlock)KDI_block {
    objc_setAssociatedObject(self, kKDIBlockKey, KDI_block, OBJC_ASSOCIATION_COPY_NONATOMIC);
    
    if (KDI_block == nil) {
        [self setTarget:nil];
        [self setAction:NULL];
    }
    else {
        if (self.target != nil ||
            self.action != NULL) {
            
            KSTLog(@"non-nil target or non-null action on control %@ while setting block!",self);
        }
        
        [self setTarget:self];
        [self setAction:@selector(_KDI_blockAction:)];
    }
}

@end

@implementation UIBarButtonItem (KDIPrivateExtensions)

- (IBAction)_KDI_blockAction:(UIBarButtonItem *)sender; {
    KDIUIBarButtonItemBlock block = sender.KDI_block;
    
    if (block != nil) {
        block(sender);
    }
}

@end
