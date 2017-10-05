//
//  KDIDatePickerButton.m
//  Ditko
//
//  Created by William Towe on 3/12/17.
//  Copyright © 2017 Kosoku Interactive, LLC. All rights reserved.
//
//  Redistribution and use in source and binary forms, with or without modification, are permitted provided that the following conditions are met:
//
//  1. Redistributions of source code must retain the above copyright notice, this list of conditions and the following disclaimer.
//
//  2. Redistributions in binary form must reproduce the above copyright notice, this list of conditions and the following disclaimer in the documentation and/or other materials provided with the distribution.
//
//  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

#import "KDIDatePickerButton.h"
#import "KDINextPreviousInputAccessoryView.h"
#import "UIViewController+KDIExtensions.h"

#import <Stanley/KSTScopeMacros.h>

@interface KDIDatePickerButton () <UIPopoverPresentationControllerDelegate>
@property (readwrite,nonatomic) UIView *inputView;
@property (readwrite,nonatomic) UIView *inputAccessoryView;

@property (strong,nonatomic) UIDatePicker *datePicker;

@property (weak,nonatomic) UIPopoverPresentationController *popoverPresentationController;

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
    return UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone;
}
- (BOOL)becomeFirstResponder {
    [self willChangeValueForKey:@kstKeypath(self,isFirstResponder)];
    
    BOOL retval = [super becomeFirstResponder];
    
    [self didChangeValueForKey:@kstKeypath(self,isFirstResponder)];
    
    [self firstResponderDidChange];
    
    [NSNotificationCenter.defaultCenter postNotificationName:KDIUIResponderNotificationDidBecomeFirstResponder object:self];
    
    return retval;
}
- (BOOL)resignFirstResponder {
    [self willChangeValueForKey:@kstKeypath(self,isFirstResponder)];
    
    BOOL retval = [super resignFirstResponder];
    
    [self didChangeValueForKey:@kstKeypath(self,isFirstResponder)];
    
    [self firstResponderDidChange];
    
    [NSNotificationCenter.defaultCenter postNotificationName:KDIUIResponderNotificationDidResignFirstResponder object:self];
    
    return retval;
}

- (void)firstResponderDidChange {
    
}

- (void)popoverPresentationControllerDidDismissPopover:(UIPopoverPresentationController *)popoverPresentationController {
    [NSNotificationCenter.defaultCenter postNotificationName:KDIUIResponderNotificationDidResignFirstResponder object:self];
}

- (void)presentDatePicker {
    if (self.canBecomeFirstResponder) {
        [self becomeFirstResponder];
    }
    else {
        UIViewController *viewController = [[UIViewController alloc] init];
        
        [viewController setPreferredContentSize:self.datePicker.frame.size];
        [viewController setView:self.datePicker];
        [viewController setModalPresentationStyle:UIModalPresentationPopover];
        
        UIPopoverPresentationController *controller = viewController.popoverPresentationController;
        
        [self setPopoverPresentationController:controller];
        
        [controller setPermittedArrowDirections:UIPopoverArrowDirectionAny];
        [controller setSourceView:self];
        [controller setSourceRect:self.bounds];
        [controller setDelegate:self];
        
        [[UIViewController KDI_viewControllerForPresenting] presentViewController:viewController animated:YES completion:nil];
        
        [NSNotificationCenter.defaultCenter postNotificationName:KDIUIResponderNotificationDidBecomeFirstResponder object:self];
    }
}
- (void)dismissDatePicker {
    if (self.isFirstResponder) {
        [self resignFirstResponder];
    }
    else {
        [self.popoverPresentationController.presentedViewController.presentingViewController dismissViewControllerAnimated:YES completion:nil];
    }
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
    return self.isFirstResponder || self.popoverPresentationController != nil;
}

- (void)_KDIDatePickerButtonInit; {
    _dateFormatter = [self.class _defaultDateFormatter];
    
    [self addTarget:self action:@selector(_toggleFirstResponderAction:) forControlEvents:UIControlEventTouchUpInside];
    
    _datePicker = [[UIDatePicker alloc] init];
    [_datePicker setDatePickerMode:UIDatePickerModeDateAndTime];
    [_datePicker addTarget:self action:@selector(_datePickerAction:) forControlEvents:UIControlEventValueChanged];
    [_datePicker sizeToFit];
    
    [self setInputView:_datePicker];
    
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
