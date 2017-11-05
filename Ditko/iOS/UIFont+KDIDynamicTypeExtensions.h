//
//  UIFont+KDIDynamicTypeExtensions.h
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

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol KDIDynamicTypeObject;

@interface NSObject (KDIDynamicTypeExtensions)

/**
 Set and get the dynamic type text style of the receiver. This will call through to KDI_registerDynamicTypeObject:forTextStyle: passing self and the text style or KDI_unregisterDynamicTypeObject: passing self, but only if self conforms to KDIDynamicTypeObject.
 
 The default is nil.
 */
@property (copy,nullable) UIFontTextStyle KDI_dynamicTypeTextStyle;

/**
 Register the object for dynamic type updates with the provided *textStyle*.
 
 @param dynamicTypeObject The object to register for dynamic type updates
 @param textStyle The text style to use when applying updates
 */
+ (void)KDI_registerDynamicTypeObject:(id<KDIDynamicTypeObject>)dynamicTypeObject forTextStyle:(UIFontTextStyle)textStyle;
/**
 Register a collection of objects for dynamic type updates with the provided *textStyle*.
 
 @param dynamicTypeObjects An array of objects to register for dynamic type updates
 @param textStyle The text style to use when applying updates
 */
+ (void)KDI_registerDynamicTypeObjects:(NSArray<id<KDIDynamicTypeObject>> *)dynamicTypeObjects forTextStyle:(UIFontTextStyle)textStyle;
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
 Category allowing UISegmentedControl instances to be used with KDIDynamicTypeObject methods.
 */
@interface UISegmentedControl (KDIDynamicTypeExtensions) <KDIDynamicTypeObject>
@end

NS_ASSUME_NONNULL_END
