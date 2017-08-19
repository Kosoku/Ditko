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

@interface UIFont (KDIDynamicTypeExtensions)

/**
 Set and get the class selector used to to retrieve the correct font when an update is needed. This must be a class method.
 
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
 Set and get the text style of the receiver. Setting this to a non-nil value indicates you wish the framework to register for dynamic type updates on your behalf. Setting this to nil unregisters for dynamic type updates.
 
 The default is nil.
 */
@property (copy,nonatomic,nullable) UIFontTextStyle KDI_dynamicTypeTextStyle;
@optional
/**
 This method should return the selector that will be called to set the receiver's font when an update occurs. For example, support for UILabel is provided by returning @selector(setFont:) from this method. Any custom view object wishing to adopt the protocol should return the appropriate set selector.
 */
@property (readonly,nonatomic) SEL KDI_dynamicTypeSetFontSelector;
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

NS_ASSUME_NONNULL_END
