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
#import <Stanley/KSTLoggingMacros.h>

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
    SEL setFontSelector = [self.dynamicTypeObject dynamicTypeSetFontSelector];
    
    if (![self.dynamicTypeObject respondsToSelector:setFontSelector]) {
        KSTLog(@"dynamic type object %@ does not respond to selector %@, returning",self.dynamicTypeObject,NSStringFromSelector(setFontSelector));
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

@implementation NSObject (KDIDynamicTypeExtensions)

+ (void)KDI_registerDynamicTypeObject:(id<KDIDynamicTypeObject>)dynamicTypeObject forTextStyle:(UIFontTextStyle)textStyle {
    [(id)dynamicTypeObject setKDI_dynamicTypeHelper:[[KDIDynamicTypeHelper alloc] initWithDynamicTypeObject:dynamicTypeObject textStyle:textStyle]];
}
+ (void)KDI_registerDynamicTypeObjects:(NSArray<id<KDIDynamicTypeObject>> *)dynamicTypeObjects forTextStyle:(UIFontTextStyle)textStyle {
    [self KDI_registerDynamicTypeObjectsForTextStyles:@{textStyle: dynamicTypeObjects}];
}
+ (void)KDI_registerDynamicTypeObjectsForTextStyles:(NSDictionary<UIFontTextStyle,NSArray<id<KDIDynamicTypeObject>> *> *)textStylesToDynamicTypeObjects {
    [textStylesToDynamicTypeObjects enumerateKeysAndObjectsUsingBlock:^(UIFontTextStyle  _Nonnull key, NSArray<id<KDIDynamicTypeObject>> * _Nonnull obj, BOOL * _Nonnull stop) {
        for (id<KDIDynamicTypeObject> dto in obj) {
            [self KDI_registerDynamicTypeObject:dto forTextStyle:key];
        }
    }];
}

+ (void)KDI_unregisterDynamicTypeObject:(id<KDIDynamicTypeObject>)dynamicTypeObject {
    [(id)dynamicTypeObject setKDI_dynamicTypeHelper:nil];
}

- (UIFontTextStyle)KDI_dynamicTypeTextStyle {
    return self.KDI_dynamicTypeHelper.textStyle;
}

@end

static void const *kDynamicTypeFontForTextStyleSelectorKey = &kDynamicTypeFontForTextStyleSelectorKey;

@implementation UIFont (KDIDynamicTypeExtensions)

+ (SEL)KDI_dynamicTypeFontForTextStyleSelector {
    return NSSelectorFromString(objc_getAssociatedObject(self, kDynamicTypeFontForTextStyleSelectorKey)) ?: @selector(preferredFontForTextStyle:);
}
+ (void)setKDI_dynamicTypeFontForTextStyleSelector:(SEL)dynamicTypeFontForTextStyleSelector {
    objc_setAssociatedObject(self, kDynamicTypeFontForTextStyleSelectorKey, NSStringFromSelector(dynamicTypeFontForTextStyleSelector), OBJC_ASSOCIATION_COPY_NONATOMIC);
}

@end

@implementation UILabel (KDIDynamicTypeExtensions)

- (SEL)dynamicTypeSetFontSelector {
    return @selector(setFont:);
}

@end

@implementation UITextField (KDIDynamicTypeExtensions)

- (SEL)dynamicTypeSetFontSelector {
    return @selector(setFont:);
}

@end

@implementation UITextView (KDIDynamicTypeExtensions)

- (SEL)dynamicTypeSetFontSelector {
    return @selector(setFont:);
}

@end

@implementation UISegmentedControl (KDIDynamicTypeExtensions)

- (SEL)dynamicTypeSetFontSelector {
    return @selector(KDI_setFont:);
}

- (void)KDI_setFont:(UIFont *)font {
    [self setTitleTextAttributes:@{NSFontAttributeName: font} forState:UIControlStateNormal];
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
