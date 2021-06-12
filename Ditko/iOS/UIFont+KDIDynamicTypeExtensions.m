//
//  NSObject+KDIDynamicTypeExtensions.m
//  Ditko
//
//  Created by William Towe on 4/13/17.
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

#import "UIFont+KDIDynamicTypeExtensions.h"

#import <Stanley/NSArray+KSTExtensions.h>
#import <Stanley/KSTLoggingMacros.h>

#import <objc/runtime.h>

@interface KDIDynamicTypeFontAndTextStyle ()
@property (readwrite,strong,nonatomic,nullable) UIFont *font;
@property (readwrite,copy,nonatomic) UIFontTextStyle textStyle;
@end

@implementation KDIDynamicTypeFontAndTextStyle
- (instancetype)initWithFont:(UIFont *)font textStyle:(UIFontTextStyle)textStyle {
    if (!(self = [super init]))
        return nil;
    
    _font = font;
    _textStyle = [textStyle copy];
    
    return self;
}

+ (instancetype)dynamicTypeFontAndTextStyleWithFont:(UIFont *)font textStyle:(UIFontTextStyle)textStyle {
    return [[self alloc] initWithFont:font textStyle:textStyle];
}
@end

@interface KDIDynamicTypeHelper : NSObject
@property (weak,nonatomic) id<KDIDynamicTypeObject> dynamicTypeObject;
@property (copy,nonatomic) UIFontTextStyle textStyle;
@property (strong,nonatomic) UIFont *font;

- (instancetype)initWithDynamicTypeObject:(id<KDIDynamicTypeObject>)dynamicTypeObject textStyle:(UIFontTextStyle)textStyle font:(UIFont *)font;
- (void)updateDynamicTypeObject;
@end

@implementation KDIDynamicTypeHelper

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (instancetype)initWithDynamicTypeObject:(id<KDIDynamicTypeObject>)dynamicTypeObject textStyle:(UIFontTextStyle)textStyle font:(UIFont *)font {
    if (!(self = [super init]))
        return nil;
    
    _dynamicTypeObject = dynamicTypeObject;
    _textStyle = [textStyle copy];
    _font = font;
    
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
    UIFont *font;
    
    UIFont*(^defaultFontBlock)(void) = ^UIFont*(void){
        return [UIFont.class performSelector:getFontSelector withObject:self.textStyle];
    };
    
    if (self.font == nil) {
        font = defaultFontBlock();
    }
    else {
        if (@available(iOS 11.0, tvOS 11.0, watchOS 4.0, *)) {
            UIFontMetrics *fontMetrics = [[UIFontMetrics alloc] initForTextStyle:self.textStyle];
            
            font = [fontMetrics scaledFontForFont:self.font];
        }
        else {
            font = defaultFontBlock();
        }
    }

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
    [(id)dynamicTypeObject setKDI_dynamicTypeHelper:[[KDIDynamicTypeHelper alloc] initWithDynamicTypeObject:dynamicTypeObject textStyle:textStyle font:nil]];
}
+ (void)KDI_registerDynamicTypeObject:(id<KDIDynamicTypeObject>)dynamicTypeObject forTextStyle:(UIFontTextStyle)textStyle withFont:(UIFont *)font; {
    [(id)dynamicTypeObject setKDI_dynamicTypeHelper:[[KDIDynamicTypeHelper alloc] initWithDynamicTypeObject:dynamicTypeObject textStyle:textStyle font:font]];
}
+ (void)KDI_registerDynamicTypeObjects:(NSArray<id<KDIDynamicTypeObject>> *)dynamicTypeObjects forTextStyle:(UIFontTextStyle)textStyle {
    [self KDI_registerDynamicTypeObjectsForTextStyles:@{textStyle: dynamicTypeObjects}];
}
+ (void)KDI_registerDynamicTypeObjects:(NSArray<id<KDIDynamicTypeObject>> *)dynamicTypeObjects forTextStyle:(UIFontTextStyle)textStyle withFont:(UIFont *)font; {
    for (id<KDIDynamicTypeObject> dto in dynamicTypeObjects) {
        [self KDI_registerDynamicTypeObject:dto forTextStyle:textStyle withFont:font];
    }
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

@dynamic KDI_dynamicTypeTextStyle;
- (UIFontTextStyle)KDI_dynamicTypeTextStyle {
    return self.KDI_dynamicTypeHelper.textStyle;
}
- (void)setKDI_dynamicTypeTextStyle:(UIFontTextStyle)KDI_dynamicTypeTextStyle {
    if (KDI_dynamicTypeTextStyle == nil) {
        self.KDI_dynamicTypeFontAndTextStyle = nil;
    }
    else {
        self.KDI_dynamicTypeFontAndTextStyle = KDIDynamicTypeFontAndTextStyleCreate(nil, KDI_dynamicTypeTextStyle);
    }
}
@dynamic KDI_dynamicTypeFontAndTextStyle;
- (KDIDynamicTypeFontAndTextStyle *)KDI_dynamicTypeFontAndTextStyle {
    KDIDynamicTypeHelper *helper = self.KDI_dynamicTypeHelper;
    
    if (helper == nil) {
        return nil;
    }
    
    return KDIDynamicTypeFontAndTextStyleCreate(helper.font, helper.textStyle);
}
- (void)setKDI_dynamicTypeFontAndTextStyle:(KDIDynamicTypeFontAndTextStyle *)KDI_dynamicTypeFontAndTextStyle {
    if (![self conformsToProtocol:@protocol(KDIDynamicTypeObject)]) {
        return;
    }
    
    if (KDI_dynamicTypeFontAndTextStyle == nil) {
        [NSObject KDI_unregisterDynamicTypeObject:(id<KDIDynamicTypeObject>)self];
    }
    else {
        [NSObject KDI_registerDynamicTypeObject:(id<KDIDynamicTypeObject>)self forTextStyle:KDI_dynamicTypeFontAndTextStyle.textStyle withFont:KDI_dynamicTypeFontAndTextStyle.font];
    }
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

@implementation UIButton (KDIDynamicTypeExtensions)

- (SEL)dynamicTypeSetFontSelector {
    return @selector(KDI_setFont:);
}

- (void)KDI_setFont:(UIFont *)font {
    self.titleLabel.font = font;
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
