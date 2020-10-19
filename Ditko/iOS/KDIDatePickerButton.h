//
//  KDIDatePickerButton.h
//  Ditko
//
//  Created by William Towe on 3/12/17.
//  Copyright © 2019 Kosoku Interactive, LLC. All rights reserved.
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
 Get whether the date has been set, either by the date property or by user interaction.
 */
@property (readonly,assign,nonatomic) BOOL hasSelectedDate;

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
