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

#import "UIFont+KDIDynamicTypeExtensions.h"

#import <Stanley/NSArray+KSTExtensions.h>

#import <objc/runtime.h>

@interface KDIDynamicTypeHelper : NSObject
@property (weak,nonatomic) id<KDIDynamicTypeObject> dynamicTypeObject;
@property (copy,nonatomic) UIFontTextStyle textStyle;

- (instancetype)initWithDynamicTypeObject:(id<KDIDynamicTypeObject>)dynamicTypeObject textStyle:(UIFontTextStyle)textStyle;
- (void)updateDynamicTypeObject;
@end

@implementation KDIDynamicTypeHelper

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (instancetype)initWithDynamicTypeObject:(id<KDIDynamicTypeObject>)dynamicTypeObject textStyle:(UIFontTextStyle)textStyle {
    if (!(self = [super init]))
        return nil;
    
    _dynamicTypeObject = dynamicTypeObject;
    _textStyle = [textStyle copy];
    
    [self updateDynamicTypeObject];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(_contentSizeCategoryDidChange:) name:UIContentSizeCategoryDidChangeNotification object:nil];
    
    return self;
}
- (void)updateDynamicTypeObject; {
    SEL setFontSelector = [self.dynamicTypeObject KDI_dynamicTypeSetFontSelector];
    
    if (![self.dynamicTypeObject respondsToSelector:setFontSelector]) {
        return;
    }
    
    SEL getFontSelector = [UIFont KDI_dynamicTypeFontForTextStyleSelector];
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
    UIFont *font = [UIFont.class performSelector:getFontSelector withObject:self.textStyle];

    [self.dynamicTypeObject performSelector:setFontSelector withObject:font];
#pragma clang diagnostic pop
}

- (void)_contentSizeCategoryDidChange:(NSNotification *)note {
    [self updateDynamicTypeObject];
}

@end

@interface NSObject (KDIDynamicTypePrivateExtensions)
@property (strong,nonatomic) KDIDynamicTypeHelper *KDI_dynamicTypeHelper;
@end

static void const *kKDI_dynamicTypeFontForTextStyleSelectorKey = &kKDI_dynamicTypeFontForTextStyleSelectorKey;

@implementation UIFont (KDIDynamicTypeExtensions)

+ (SEL)KDI_dynamicTypeFontForTextStyleSelector {
    return NSSelectorFromString(objc_getAssociatedObject(self, kKDI_dynamicTypeFontForTextStyleSelectorKey)) ?: @selector(preferredFontForTextStyle:);
}
+ (void)setKDI_dynamicTypeFontForTextStyleSelector:(SEL)KDI_dynamicTypeFontForTextStyleSelector {
    objc_setAssociatedObject(self, kKDI_dynamicTypeFontForTextStyleSelectorKey, NSStringFromSelector(KDI_dynamicTypeFontForTextStyleSelector), OBJC_ASSOCIATION_COPY_NONATOMIC);
}

@end

static void const *kKDI_dynamicTypeTextStyleKey = &kKDI_dynamicTypeTextStyleKey;

@implementation UILabel (KDIDynamicTypeExtensions)

@dynamic KDI_dynamicTypeTextStyle;
- (UIFontTextStyle)KDI_dynamicTypeTextStyle {
    return self.KDI_dynamicTypeHelper.textStyle;
}
- (void)setKDI_dynamicTypeTextStyle:(UIFontTextStyle)KDI_dynamicTypeTextStyle {
    [self setKDI_dynamicTypeHelper:[[KDIDynamicTypeHelper alloc] initWithDynamicTypeObject:self textStyle:KDI_dynamicTypeTextStyle]];
}

- (SEL)KDI_dynamicTypeSetFontSelector {
    return @selector(setFont:);
}

@end

@implementation UITextField (KDIDynamicTypeExtensions)

@dynamic KDI_dynamicTypeTextStyle;
- (UIFontTextStyle)KDI_dynamicTypeTextStyle {
    return self.KDI_dynamicTypeHelper.textStyle;
}
- (void)setKDI_dynamicTypeTextStyle:(UIFontTextStyle)KDI_dynamicTypeTextStyle {
    [self setKDI_dynamicTypeHelper:[[KDIDynamicTypeHelper alloc] initWithDynamicTypeObject:self textStyle:KDI_dynamicTypeTextStyle]];
}

- (SEL)KDI_dynamicTypeSetFontSelector {
    return @selector(setFont:);
}

@end

@implementation UITextView (KDIDynamicTypeExtensions)

@dynamic KDI_dynamicTypeTextStyle;
- (UIFontTextStyle)KDI_dynamicTypeTextStyle {
    return self.KDI_dynamicTypeHelper.textStyle;
}
- (void)setKDI_dynamicTypeTextStyle:(UIFontTextStyle)KDI_dynamicTypeTextStyle {
    [self setKDI_dynamicTypeHelper:[[KDIDynamicTypeHelper alloc] initWithDynamicTypeObject:self textStyle:KDI_dynamicTypeTextStyle]];
}

- (SEL)KDI_dynamicTypeSetFontSelector {
    return @selector(setFont:);
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
