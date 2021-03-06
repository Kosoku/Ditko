//
//  UIFont+KDIDynamicTypeExtensions.h
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

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

/**
 KDIDynamicTypeFontAndTextStyle is a model class that represents a font text style and a base font to be used with UIFontMetrics if the class is available. Otherwise, the below methods will funnel through the class method specified by the KDI_dynamicTypeFontForTextStyleSelector property.
 */
@interface KDIDynamicTypeFontAndTextStyle : NSObject

/**
 Get the base font that the receiver was initizlied with.
 */
@property (readonly,strong,nonatomic,nullable) UIFont *font;
/**
 Get the font text style that the receiver was initialized with.
 */
@property (readonly,copy,nonatomic) UIFontTextStyle textStyle;

/**
 Create and return an instance with the provided base *font* and *textStyle*.
 
 @param font The base font
 @param textStyle The font text style
 @return The initialized instance
 */
- (instancetype)initWithFont:(nullable UIFont *)font textStyle:(UIFontTextStyle)textStyle NS_DESIGNATED_INITIALIZER;

- (instancetype)init NS_UNAVAILABLE;
+ (instancetype)new NS_UNAVAILABLE;

/**
 Calls initWithFont:textStyle:, passing *font* and *textStyle* respectively.
 
 @param font The base font
 @param textStyle The font text style
 @return The initialized instance
 */
+ (instancetype)dynamicTypeFontAndTextStyleWithFont:(nullable UIFont *)font textStyle:(UIFontTextStyle)textStyle;
@end

#define KDIDynamicTypeFontAndTextStyleCreate(theFont, theTextStyle) ([KDIDynamicTypeFontAndTextStyle dynamicTypeFontAndTextStyleWithFont:(theFont) textStyle:(theTextStyle)])

@protocol KDIDynamicTypeObject;

@interface NSObject (KDIDynamicTypeExtensions)

/**
 Set and get the dynamic type text style of the receiver. This will call through to KDI_registerDynamicTypeObject:forTextStyle: passing self and the text style or KDI_unregisterDynamicTypeObject: passing self, but only if self conforms to KDIDynamicTypeObject.
 
 The default is nil.
 */
@property (copy,nonatomic,nullable) UIFontTextStyle KDI_dynamicTypeTextStyle;
/**
 Set and get the dynamic type font and text style object associated with the receiver. These methods only have an effect if the receiver conforms to KDIDynamicTypeObject.
 
 The default is nil.
 */
@property (strong,nonatomic,nullable) KDIDynamicTypeFontAndTextStyle *KDI_dynamicTypeFontAndTextStyle;

/**
 Register the object for dynamic type updates with the provided *textStyle*.
 
 @param dynamicTypeObject The object to register for dynamic type updates
 @param textStyle The text style to use when applying updates
 */
+ (void)KDI_registerDynamicTypeObject:(id<KDIDynamicTypeObject>)dynamicTypeObject forTextStyle:(UIFontTextStyle)textStyle;
/**
 Register the object for dynamic type updates with the provided *textStyle* and *font*.
 
 @param dynamicTypeObject The object to register for dynamic type updates
 @param textStyle The text style to use when applying updates
 @param font The base font that should be used when calculating font changes, uses UIFontMetrics if available, otherwise falls back to default behavior
 */
+ (void)KDI_registerDynamicTypeObject:(id<KDIDynamicTypeObject>)dynamicTypeObject forTextStyle:(UIFontTextStyle)textStyle withFont:(nullable UIFont *)font;

/**
 Register a collection of objects for dynamic type updates with the provided *textStyle*.
 
 @param dynamicTypeObjects An array of objects to register for dynamic type updates
 @param textStyle The text style to use when applying updates
 */
+ (void)KDI_registerDynamicTypeObjects:(NSArray<id<KDIDynamicTypeObject>> *)dynamicTypeObjects forTextStyle:(UIFontTextStyle)textStyle;
/**
 Register a collection of objects for dynamic type updates with the provided *textStyle*.
 
 @param dynamicTypeObjects An array of objects to register for dynamic type updates
 @param textStyle The text style to use when applying updates
 @param font The base font that should be used when calculating font changes, uses UIFontMetrics if available, otherwise falls back to default behavior
 */
+ (void)KDI_registerDynamicTypeObjects:(NSArray<id<KDIDynamicTypeObject>> *)dynamicTypeObjects forTextStyle:(UIFontTextStyle)textStyle withFont:(nullable UIFont *)font;

/**
 Register collections of objects for dynamic type updates using the keys in *textStylesToDynamicTypeObjects* as the text styles and the objects as arrays of dynamic type objects. The keys of *textStylesToDynamicTypeObjects* should be UIFontTextStyle constants and the objects should be NSArray containing objects conforming to KDIDynamicTypeObject.
 
 @param textStylesToDynamicTypeObjects The dictionary of objects to register for dynamic type updates
 */
+ (void)KDI_registerDynamicTypeObjectsForTextStyles:(NSDictionary<UIFontTextStyle, NSArray<id<KDIDynamicTypeObject>> *> *)textStylesToDynamicTypeObjects;

/**
 Unregister the object for dynamic type updates. Calling this method is not required, the object is automatically unregistered when it is deallocated.
 
 @param dynamicTypeObject The object to unregister
 */
+ (void)KDI_unregisterDynamicTypeObject:(id<KDIDynamicTypeObject>)dynamicTypeObject;

@end

@interface UIFont (KDIDynamicTypeExtensions)

/**
 Set and get the class selector used to to retrieve the correct font when an update is needed. This must be a class method that takes a single argument, which is the text style.
 
 The default is [UIFont preferredFontForTextStyle:].
 */
@property (class,assign,nonatomic,null_resettable) SEL KDI_dynamicTypeFontForTextStyleSelector;

@end

/**
 Protocol describing an object (usually a view) interested in dynamic type changes.
 */
@protocol KDIDynamicTypeObject <NSObject>
@required
/**
 This method should return the selector that will be called to set the receiver's font when an update occurs. Any custom view object wishing to adopt the protocol should return the appropriate set selector.
 */
@property (readonly,nonatomic) SEL dynamicTypeSetFontSelector;
@end

/**
 Category allowing UILabel instances to be used with KDIDynamicTypeObject methods.
 */
@interface UILabel (KDIDynamicTypeExtensions) <KDIDynamicTypeObject>
@end

/**
 Category allowing UITextField instances to be used with KDIDynamicTypeObject methods.
 */
@interface UITextField (KDIDynamicTypeExtensions) <KDIDynamicTypeObject>
@end

/**
 Category allowing UITextView instances to be used with KDIDynamicTypeObject methods.
 */
@interface UITextView (KDIDynamicTypeExtensions) <KDIDynamicTypeObject>
@end

/**
 Category allowing UIButton instances to be used with KDIDynamicTypeObject methods.
 */
@interface UIButton (KDIDynamicTypeExtensions) <KDIDynamicTypeObject>
@end

/**
 Category allowing UISegmentedControl instances to be used with KDIDynamicTypeObject methods.
 */
@interface UISegmentedControl (KDIDynamicTypeExtensions) <KDIDynamicTypeObject>
@end

NS_ASSUME_NONNULL_END
