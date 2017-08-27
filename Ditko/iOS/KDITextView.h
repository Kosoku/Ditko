//
//  KDITextView.h
//  Ditko
//
//  Created by William Towe on 3/10/17.
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

/**
 KDITextView is a UITextView subclass that provides placeholder functionality like UITextField.
 */
@interface KDITextView : UITextView

/**
 Set and get text field's placeholder text.
 */
@property (copy,nonatomic,nullable) NSString *placeholder;
/**
 Set and get text field's attributed placeholder text.
 */
@property (copy,nonatomic,nullable) NSAttributedString *attributedPlaceholder;

/**
 Set and get the placeholder text color, which is used when setting the placeholder via `setPlaceholder:`.
 
 The default is UIColor.lightGrayColor.
 */
@property (strong,nonatomic,null_resettable) UIColor *placeholderTextColor UI_APPEARANCE_SELECTOR;

@end

NS_ASSUME_NONNULL_END
