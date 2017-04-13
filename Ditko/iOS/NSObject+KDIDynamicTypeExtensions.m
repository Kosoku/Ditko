//
//  NSObject+KDIDynamicTypeExtensions.m
//  Ditko
//
//  Created by William Towe on 4/13/17.
//  Copyright © 2017 Kosoku Interactive, LLC. All rights reserved.
//
//  Redistribution and use in source and binary forms, with or without modification, are permitted provided that the following conditions are met:
//
//  1. Redistributions of source code must retain the above copyright notice, this list of conditions and the following disclaimer.
//
//  2. Redistributions in binary form must reproduce the above copyright notice, this list of conditions and the following disclaimer in the documentation and/or other materials provided with the distribution.
//
//  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

#import "NSObject+KDIDynamicTypeExtensions.h"

#import <Stanley/NSArray+KSTExtensions.h>

#import <objc/runtime.h>

@interface KDIDynamicTypeHelper : NSObject
@property (weak,nonatomic) id<KDIDynamicTypeView> dynamicTypeView;
@property (copy,nonatomic) UIFontTextStyle textStyle;

- (instancetype)initWithDynamicTypeView:(id<KDIDynamicTypeView>)dynamicTypeView textStyle:(UIFontTextStyle)textStyle;
@end

@implementation KDIDynamicTypeHelper

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (instancetype)initWithDynamicTypeView:(id<KDIDynamicTypeView>)dynamicTypeView textStyle:(UIFontTextStyle)textStyle {
    if (!(self = [super init]))
        return nil;
    
    _dynamicTypeView = dynamicTypeView;
    _textStyle = [textStyle copy];
    
    [_dynamicTypeView setKDI_dynamicTypeFont:[UIFont preferredFontForTextStyle:_textStyle]];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(_contentSizeCategoryDidChange:) name:UIContentSizeCategoryDidChangeNotification object:nil];
    
    return self;
}

- (void)_contentSizeCategoryDidChange:(NSNotification *)note {
    [self.dynamicTypeView setKDI_dynamicTypeFont:[UIFont preferredFontForTextStyle:self.textStyle]];
}

@end

@interface NSObject (KDIDynamicTypePrivateExtensions)
@property (strong,nonatomic) KDIDynamicTypeHelper *KDI_dynamicTypeHelper;
@end

@implementation NSObject (KDIDynamicTypeExtensions)

+ (void)KDI_registerDynamicTypeView:(id<KDIDynamicTypeView>)dynamicTypeView forTextStyle:(UIFontTextStyle)textStyle; {
    KDIDynamicTypeHelper *helper = [[KDIDynamicTypeHelper alloc] initWithDynamicTypeView:dynamicTypeView textStyle:textStyle];
    
    [(id)dynamicTypeView setKDI_dynamicTypeHelper:helper];
}
+ (void)KDI_registerDynamicTypeViews:(NSArray<id<KDIDynamicTypeView>> *)dynamicTypeViews forTextStyle:(UIFontTextStyle)textStyle; {
    for (id<KDIDynamicTypeView> view in [dynamicTypeViews KST_set]) {
        [self KDI_registerDynamicTypeView:view forTextStyle:textStyle];
    }
}

+ (void)KDI_unregisterDynamicTypeView:(id<KDIDynamicTypeView>)dynamicTypeView; {
    [(id)dynamicTypeView setKDI_dynamicTypeHelper:nil];
}
+ (void)KDI_unregisterDynamicTypeViews:(NSArray<id<KDIDynamicTypeView>> *)dynamicTypeViews; {
    for (id<KDIDynamicTypeView> view in [dynamicTypeViews KST_set]) {
        [self KDI_unregisterDynamicTypeView:view];
    }
}

@end

@implementation UILabel (KDIDynamicTypeExtensions)

@dynamic KDI_dynamicTypeFont;
- (UIFont *)KDI_dynamicTypeFont {
    return self.font;
}
- (void)setKDI_dynamicTypeFont:(UIFont *)KDI_dynamicTypeFont {
    [self setFont:KDI_dynamicTypeFont];
}

@end

@implementation UIButton (KDIDynamicTypeExtensions)

@dynamic KDI_dynamicTypeFont;
- (UIFont *)KDI_dynamicTypeFont {
    return self.titleLabel.font;
}
- (void)setKDI_dynamicTypeFont:(UIFont *)KDI_dynamicTypeFont {
    [self.titleLabel setFont:KDI_dynamicTypeFont];
}

@end

@implementation UITextField (KDIDynamicTypeExtensions)

@dynamic KDI_dynamicTypeFont;
- (UIFont *)KDI_dynamicTypeFont {
    return self.font;
}
- (void)setKDI_dynamicTypeFont:(UIFont *)KDI_dynamicTypeFont {
    [self setFont:KDI_dynamicTypeFont];
}

@end

@implementation UITextView (KDIDynamicTypeExtensions)

@dynamic KDI_dynamicTypeFont;
- (UIFont *)KDI_dynamicTypeFont {
    return self.font;
}
- (void)setKDI_dynamicTypeFont:(UIFont *)KDI_dynamicTypeFont {
    [self setFont:KDI_dynamicTypeFont];
}

@end

static void const *kKDI_dynamicTypeHelperKey = &kKDI_dynamicTypeHelperKey;

@implementation NSObject (KDIDynamicTypePrivateExtensions)

@dynamic KDI_dynamicTypeHelper;
- (KDIDynamicTypeHelper *)KDI_dynamicTypeHelper {
    return objc_getAssociatedObject(self, kKDI_dynamicTypeHelperKey);
}
- (void)setKDI_dynamicTypeHelper:(KDIDynamicTypeHelper *)KDI_dynamicTypeHelper {
    objc_setAssociatedObject(self, kKDI_dynamicTypeHelperKey, KDI_dynamicTypeHelper, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end
