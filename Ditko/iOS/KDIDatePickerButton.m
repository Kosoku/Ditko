//
//  KDIDatePickerButton.m
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

#import "KDIDatePickerButton.h"
#import "KDINextPreviousInputAccessoryView.h"
#import "UIViewController+KDIExtensions.h"

#import <Stanley/KSTScopeMacros.h>

@interface KDIDatePickerButton ()
@property (readwrite,nonatomic) UIView *inputView;
@property (readwrite,nonatomic) UIView *inputAccessoryView;

@property (strong,nonatomic) UIDatePicker *datePicker;

- (void)_KDIDatePickerButtonInit;
- (void)_reloadTitleFromDatePickerDate;

+ (NSDate *)_defaultDate;
+ (NSDateFormatter *)_defaultDateFormatter;
@end

@implementation KDIDatePickerButton

- (instancetype)initWithFrame:(CGRect)frame {
    if (!(self = [super initWithFrame:frame]))
        return nil;
    
    [self _KDIDatePickerButtonInit];
    
    return self;
}
- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (!(self = [super initWithCoder:aDecoder]))
        return nil;
    
    [self _KDIDatePickerButtonInit];
    
    return self;
}
#pragma mark -
- (BOOL)canBecomeFirstResponder {
    return YES;
}
- (BOOL)becomeFirstResponder {
    [self willChangeValueForKey:@kstKeypath(self,isFirstResponder)];
    
    BOOL retval = [super becomeFirstResponder];
    
    [self didChangeValueForKey:@kstKeypath(self,isFirstResponder)];
    
    [self firstResponderDidChange];
    
    [NSNotificationCenter.defaultCenter postNotificationName:KDIUIResponderNotificationDidBecomeFirstResponder object:self];
    
    UIAccessibilityPostNotification(UIAccessibilityLayoutChangedNotification, self.inputView);
    
    return retval;
}
- (BOOL)resignFirstResponder {
    [self willChangeValueForKey:@kstKeypath(self,isFirstResponder)];
    
    BOOL retval = [super resignFirstResponder];
    
    [self didChangeValueForKey:@kstKeypath(self,isFirstResponder)];
    
    [self firstResponderDidChange];
    
    [NSNotificationCenter.defaultCenter postNotificationName:KDIUIResponderNotificationDidResignFirstResponder object:self];
    
    UIAccessibilityPostNotification(UIAccessibilityLayoutChangedNotification, nil);
    
    return retval;
}

- (void)firstResponderDidChange {
    
}

- (void)reloadTitleFromDate; {
    [self _reloadTitleFromDatePickerDate];
}

- (void)presentDatePicker {
    [self becomeFirstResponder];
}
- (void)dismissDatePicker {
    [self resignFirstResponder];
}

@dynamic date;
- (NSDate *)date {
    return self.datePicker.date;
}
- (void)setDate:(NSDate *)date {
    [self.datePicker setDate:date ?: [self.class _defaultDate]];
    
    [self _reloadTitleFromDatePickerDate];
}
@dynamic mode;
- (UIDatePickerMode)mode {
    return self.datePicker.datePickerMode;
}
- (void)setMode:(UIDatePickerMode)mode {
    [self.datePicker setDatePickerMode:mode];
}
@dynamic minimumDate;
- (NSDate *)minimumDate {
    return self.datePicker.minimumDate;
}
- (void)setMinimumDate:(NSDate *)minimumDate {
    [self.datePicker setMinimumDate:minimumDate];
}
@dynamic maximumDate;
- (NSDate *)maximumDate {
    return self.datePicker.maximumDate;
}
- (void)setMaximumDate:(NSDate *)maximumDate {
    [self.datePicker setMaximumDate:maximumDate];
}
- (void)setDateFormatter:(NSDateFormatter *)dateFormatter {
    _dateFormatter = dateFormatter ?: [self.class _defaultDateFormatter];
    
    [self _reloadTitleFromDatePickerDate];
}
- (void)setDateTitleBlock:(KDIDatePickerButtonDateTitleBlock)dateTitleBlock {
    _dateTitleBlock = dateTitleBlock;
    
    [self _reloadTitleFromDatePickerDate];
}

- (BOOL)isPresentingDatePicker {
    return self.isFirstResponder;
}

- (void)_KDIDatePickerButtonInit; {
    _dateFormatter = [self.class _defaultDateFormatter];
    
    [self addTarget:self action:@selector(_toggleFirstResponderAction:) forControlEvents:UIControlEventTouchUpInside];
    
    _datePicker = [[UIDatePicker alloc] init];
    [_datePicker setTranslatesAutoresizingMaskIntoConstraints:NO];
    [_datePicker setDatePickerMode:UIDatePickerModeDateAndTime];
    [_datePicker addTarget:self action:@selector(_datePickerAction:) forControlEvents:UIControlEventValueChanged];
    
    UIInputView *inputView = [[UIInputView alloc] initWithFrame:CGRectZero inputViewStyle:UIInputViewStyleKeyboard];
    
    inputView.translatesAutoresizingMaskIntoConstraints = NO;
    inputView.allowsSelfSizing = YES;
    
    [inputView addSubview:_datePicker];
    
    [NSLayoutConstraint activateConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[view]|" options:0 metrics:nil views:@{@"view": _datePicker}]];
    [NSLayoutConstraint activateConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[view]|" options:0 metrics:nil views:@{@"view": _datePicker}]];
    
    self.inputView = inputView;
    
    [self setInputAccessoryView:[[KDINextPreviousInputAccessoryView alloc] initWithFrame:CGRectZero responder:self]];
    
    [self _reloadTitleFromDatePickerDate];
}
- (void)_reloadTitleFromDatePickerDate; {
    NSString *defaultTitle = [self.dateFormatter stringFromDate:self.date];
    NSString *title = self.dateTitleBlock == nil ? defaultTitle : (self.dateTitleBlock(self,defaultTitle) ?: defaultTitle);
    
    [self setTitle:title forState:UIControlStateNormal];
}

+ (NSDate *)_defaultDate; {
    return [NSDate date];
}
+ (NSDateFormatter *)_defaultDateFormatter; {
    static NSDateFormatter *kRetval;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        kRetval = [[NSDateFormatter alloc] init];
        
        [kRetval setDateStyle:NSDateFormatterMediumStyle];
        [kRetval setTimeStyle:NSDateFormatterMediumStyle];
    });
    return kRetval;
}

- (IBAction)_datePickerAction:(id)sender {
    [self willChangeValueForKey:@kstKeypath(self,date)];
    
    [self sendActionsForControlEvents:UIControlEventValueChanged];
    
    [self didChangeValueForKey:@kstKeypath(self,date)];
    
    [self _reloadTitleFromDatePickerDate];
}
- (IBAction)_toggleFirstResponderAction:(id)sender {
    if (self.isPresentingDatePicker) {
        [self dismissDatePicker];
    }
    else {
        [self presentDatePicker];
    }
}

@end
