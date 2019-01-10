//
//  UIBarButtonItem+KDIExtensions.m
//  Ditko
//
//  Created by William Towe on 3/10/17.
//  Copyright © 2019 Kosoku Interactive, LLC. All rights reserved.
//
//  Redistribution and use in source and binary forms, with or without modification, are permitted provided that the following conditions are met:
//
//  1. Redistributions of source code must retain the above copyright notice, this list of conditions and the following disclaimer.
//
//  2. Redistributions in binary form must reproduce the above copyright notice, this list of conditions and the following disclaimer in the documentation and/or other materials provided with the distribution.
//
//  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

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
