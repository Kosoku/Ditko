//
//  KDIDatePickerButton.h
//  Ditko
//
//  Created by William Towe on 3/12/17.
//  Copyright © 2019 Kosoku Interactive, LLC. All rights reserved.
//
//  Redistribution and use in source and binary forms, with or without modification, are permitted provided that the following conditions are met:
//
//  1. Redistributions of source code must retain the above copyright notice, this list of conditions and the following disclaimer.
//
//  2. Redistributions in binary form must reproduce the above copyright notice, this list of conditions and the following disclaimer in the documentation and/or other materials provided with the distribution.
//
//  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

#import <Ditko/KDIButton.h>
#import <Ditko/KDIUIResponder.h>

NS_ASSUME_NONNULL_BEGIN

@class KDIDatePickerButton;

/**
 A block that is invoked to determine the title for display.
 
 @param datePickerButton The date picker button invoking the block
 @param defaultTitle The default title, already formatted using the attached dateFormatter
 @return The display title or nil if you want the default title to be used
 */
typedef NSString* _Nullable (^KDIDatePickerButtonDateTitleBlock)(__kindof KDIDatePickerButton *datePickerButton, NSString *defaultTitle);

/**
 KDIPickerViewButton is a KDIButton subclass that manages a UIDatePicker instance as its inputView.
 */
@interface KDIDatePickerButton : KDIButton <KDIUIResponder>

/**
 Set and get the date of the receiver.
 
 The default is [NSDate date].
 */
@property (copy,nonatomic,null_resettable) NSDate *date;

/**
 Set and get the mode used by the managed date picker view.
 
 The default is UIDatePickerModeDateAndTime.
 */
@property (assign,nonatomic) UIDatePickerMode mode;

/**
 Set and get the minimum date of the managed date picker view.
 
 The default is nil.
 */
@property (copy,nonatomic,nullable) NSDate *minimumDate;
/**
 Set and get the maximum date of the managed date picker view.
 
 The default is nil.
 */
@property (copy,nonatomic,nullable) NSDate *maximumDate;

/**
 Set and get the date formatter used to format the date of the receiver for display.
 
 The default is a NSDateFormatter with date style and time style set to NSDateFormatterMediumStyle.
 */
@property (strong,nonatomic,null_resettable) NSDateFormatter *dateFormatter UI_APPEARANCE_SELECTOR;

/**
 Set and get a block that is invoked to determine the displayed title. The receiver and default title are passed as arguments. The block should return a new title or nil if they want the default title to be used.
 
 @see KDIDatePickerButtonDateTitleBlock
 */
@property (copy,nonatomic,nullable) KDIDatePickerButtonDateTitleBlock dateTitleBlock;

/**
 Reloads the title from the date pickers current date.
 */
- (void)reloadTitleFromDate;

/**
 Get whether the receiver is presenting the date picker. This is updated whenever the user taps on the receiver or presentDatePicker or dismissDatePicker methods are called.
 */
@property (readonly,nonatomic,getter=isPresentingDatePicker) BOOL presentingDatePicker;

/**
 Present the UIDatePicker using the appropriate method. On iPad, present using a popover, otherwise become the first responder and present as the inputView.
 */
- (void)presentDatePicker;
/**
 Dismiss the UIDatePicker using the appropriate method.
 */
- (void)dismissDatePicker;

@end

NS_ASSUME_NONNULL_END
