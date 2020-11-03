//
//  KDIPickerViewButton.m
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

#import "KDIPickerViewButton.h"
#import "KDINextPreviousInputAccessoryView.h"
#import "UIViewController+KDIExtensions.h"

#import <Stanley/Stanley.h>

NSNotificationName const KDIPickerViewButtonNotificationDidBecomeFirstResponder = @"KDIPickerViewButtonNotificationDidBecomeFirstResponder";
NSNotificationName const KDIPickerViewButtonNotificationDidResignFirstResponder = @"KDIPickerViewButtonNotificationDidResignFirstResponder";

@interface KDIPickerViewButtonRowView : UIView
@property (strong,nonatomic) UIImage *image;
@property (copy,nonatomic) NSAttributedString *attributedTitle;

@property (strong,nonatomic) UIStackView *stackView;
@property (strong,nonatomic) UIImageView *imageView;
@property (strong,nonatomic) UILabel *label;
@end

@implementation KDIPickerViewButtonRowView

- (instancetype)initWithFrame:(CGRect)frame {
    if (!(self = [super initWithFrame:frame]))
        return nil;
    
    _stackView = [[UIStackView alloc] initWithFrame:CGRectZero];
    _stackView.translatesAutoresizingMaskIntoConstraints = NO;
    _stackView.axis = UILayoutConstraintAxisHorizontal;
    _stackView.spacing = 8.0;
    [self addSubview:_stackView];
    
    _imageView = [[UIImageView alloc] initWithFrame:CGRectZero];
    _imageView.translatesAutoresizingMaskIntoConstraints = NO;
    _imageView.contentMode = UIViewContentModeCenter;
    [_stackView addArrangedSubview:_imageView];
    
    _label = [[UILabel alloc] initWithFrame:CGRectZero];
    _label.translatesAutoresizingMaskIntoConstraints = NO;
    _label.font = [UIFont systemFontOfSize:21.0 weight:UIFontWeightRegular];
    [_stackView addArrangedSubview:_label];
    
    [NSLayoutConstraint activateConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|->=0-[view]->=0-|" options:0 metrics:nil views:@{@"view": _stackView}]];
    [NSLayoutConstraint activateConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[view]|" options:0 metrics:nil views:@{@"view": _stackView}]];
    [NSLayoutConstraint activateConstraints:@[[_stackView.centerXAnchor constraintEqualToAnchor:self.centerXAnchor]]];
    
    return self;
}

@dynamic image;
- (UIImage *)image {
    return self.imageView.image;
}
- (void)setImage:(UIImage *)image {
    self.imageView.image = image;
    self.imageView.hidden = image == nil;
    self.imageView.isAccessibilityElement = image == nil;
}
@dynamic attributedTitle;
- (NSAttributedString *)attributedTitle {
    return self.label.attributedText;
}
- (void)setAttributedTitle:(NSAttributedString *)attributedTitle {
    self.label.attributedText = attributedTitle;
}

@end

@interface KDIPickerViewButton () <UIPickerViewDataSource, UIPickerViewDelegate>
@property (readwrite,assign,nonatomic) BOOL hasSelectedRow;
@property (readwrite,nonatomic) UIView *inputView;

@property (strong,nonatomic) UIPickerView *pickerView;

- (void)_KDIPickerViewButtonInit;
- (NSInteger)_numberOfComponentsInPickerView;
- (NSAttributedString *)_attributedTitleForRow:(NSInteger)row inComponent:(NSInteger)component;
- (NSAttributedString *)_attributedTitleForSelectedRowsInPickerView;
- (id)_imageForSelectedRowsInPickerView;
- (void)_reloadTitleForSelectedRowsInPickerView;

+ (NSString *)_defaultSelectedComponentsJoinString;
@end

@implementation KDIPickerViewButton
#pragma mark *** Subclass Overrides ***
- (instancetype)initWithFrame:(CGRect)frame {
    if (!(self = [super initWithFrame:frame]))
        return nil;
    
    [self _KDIPickerViewButtonInit];
    
    return self;
}
- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (!(self = [super initWithCoder:aDecoder]))
        return nil;
    
    [self _KDIPickerViewButtonInit];
    
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
#pragma mark UIPickerViewDataSource
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return [self _numberOfComponentsInPickerView];
}
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return [self.dataSource pickerViewButton:self numberOfRowsInComponent:component];
}
#pragma mark UIPickerViewDelegate
- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view {
    KDIPickerViewButtonRowView *retval = (KDIPickerViewButtonRowView *)view;
    
    if (retval == nil) {
        retval = [[KDIPickerViewButtonRowView alloc] initWithFrame:CGRectZero];
    }
    
    if ([self.dataSource respondsToSelector:@selector(pickerViewButton:imageForRow:forComponent:)]) {
        retval.image = [self.dataSource pickerViewButton:self imageForRow:row forComponent:component];
    }
    
    retval.attributedTitle = [self _attributedTitleForRow:row inComponent:component];
    
    return retval;
}
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    self.hasSelectedRow = YES;
    
    [self _reloadTitleForSelectedRowsInPickerView];
    
    if ([self.delegate respondsToSelector:@selector(pickerViewButton:didSelectRow:inComponent:)]) {
        [self.delegate pickerViewButton:self didSelectRow:row inComponent:component];
    }
}
#pragma mark *** Public Methods ***
- (void)reloadData {
    [self.pickerView reloadAllComponents];
    
    [self _reloadTitleForSelectedRowsInPickerView];
}
#pragma mark -
- (NSInteger)selectedRowInComponent:(NSInteger)component {
    if (component < [self.pickerView numberOfComponents]) {
        return [self.pickerView selectedRowInComponent:component];
    }
    else {
        return -1;
    }
}
- (void)selectRow:(NSInteger)row inComponent:(NSInteger)component {
    [self.pickerView selectRow:row inComponent:component animated:NO];
    
    self.hasSelectedRow = YES;
    
    [self _reloadTitleForSelectedRowsInPickerView];
}
#pragma mark -
- (void)presentPickerView {
    [self becomeFirstResponder];
}
- (void)dismissPickerView {
    [self resignFirstResponder];
}
#pragma mark Properties
- (void)setDataSource:(id<KDIPickerViewButtonDataSource>)dataSource {
    _dataSource = dataSource;
    
    if (_dataSource != nil) {
        NSParameterAssert([_dataSource respondsToSelector:@selector(pickerViewButton:titleForRow:forComponent:)] || [_dataSource respondsToSelector:@selector(pickerViewButton:attributedTitleForRow:forComponent:)]);
        
        [self reloadData];
    }
}
- (void)setDelegate:(id<KDIPickerViewButtonDelegate>)delegate {
    _delegate = delegate;
    
    if (_dataSource != nil &&
        _delegate != nil) {
        
        [self _reloadTitleForSelectedRowsInPickerView];
    }
}
- (void)setSelectedComponentsJoinString:(NSString *)selectedComponentsJoinString {
    _selectedComponentsJoinString = selectedComponentsJoinString ?: [self.class _defaultSelectedComponentsJoinString];
    
    [self _reloadTitleForSelectedRowsInPickerView];
}

- (BOOL)isPresentingPickerView {
    return self.isFirstResponder;
}
#pragma mark *** Private Methods ***
- (void)_KDIPickerViewButtonInit; {
    _selectedComponentsJoinString = [self.class _defaultSelectedComponentsJoinString];
    
    [self addTarget:self action:@selector(_toggleFirstResponderAction:) forControlEvents:UIControlEventTouchUpInside];
    
    _pickerView = [[UIPickerView alloc] initWithFrame:CGRectZero];
    [_pickerView setTranslatesAutoresizingMaskIntoConstraints:NO];
    [_pickerView setDataSource:self];
    [_pickerView setDelegate:self];
    
    UIInputView *inputView = [[UIInputView alloc] initWithFrame:CGRectZero inputViewStyle:UIInputViewStyleKeyboard];
    
    inputView.translatesAutoresizingMaskIntoConstraints = NO;
    inputView.allowsSelfSizing = YES;
    
    [inputView addSubview:_pickerView];
    
    [NSLayoutConstraint activateConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[view]|" options:0 metrics:nil views:@{@"view": _pickerView}]];
    [NSLayoutConstraint activateConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[view]|" options:0 metrics:nil views:@{@"view": _pickerView}]];
    
    self.inputView = inputView;
    
    [self setInputAccessoryView:[[KDINextPreviousInputAccessoryView alloc] initWithFrame:CGRectZero responder:self]];
}
- (NSInteger)_numberOfComponentsInPickerView; {
    if ([self.dataSource respondsToSelector:@selector(numberOfComponentsInPickerViewButton:)]) {
        return [self.dataSource numberOfComponentsInPickerViewButton:self];
    }
    else {
        return 1;
    }
}
- (NSAttributedString *)_attributedTitleForRow:(NSInteger)row inComponent:(NSInteger)component; {
    if (row == -1) {
        return [[NSAttributedString alloc] initWithString:@""];
    }
    else if ([self.dataSource respondsToSelector:@selector(pickerViewButton:attributedTitleForRow:forComponent:)]) {
        return [self.dataSource pickerViewButton:self attributedTitleForRow:row forComponent:component] ?: [[NSAttributedString alloc] initWithString:@""];
    }
    else if ([self.dataSource respondsToSelector:@selector(pickerViewButton:titleForRow:forComponent:)]) {
        return [[NSAttributedString alloc] initWithString:[self.dataSource pickerViewButton:self titleForRow:row forComponent:component] ?: @""];
    }
    else {
        return [[NSAttributedString alloc] initWithString:@""];
    }
}
- (NSAttributedString *)_attributedTitleForSelectedRowsInPickerView; {
    NSAttributedString*(^defaultRetvalBlock)(void) = ^NSAttributedString*(void){
        NSMutableAttributedString *retval = [[NSMutableAttributedString alloc] initWithString:@""];
        
        for (NSInteger i=0; i<[self _numberOfComponentsInPickerView]; i++) {
            NSInteger row = [self selectedRowInComponent:i];
            
            [retval appendAttributedString:[self _attributedTitleForRow:row inComponent:i]];
            
            if (i != [self _numberOfComponentsInPickerView] - 1) {
                [retval appendAttributedString:[[NSAttributedString alloc] initWithString:self.selectedComponentsJoinString]];
            }
        }
        
        return retval;
    };
    
    if ([self.delegate respondsToSelector:@selector(pickerViewButton:attributedTitleForSelectedRows:)] ||
        [self.delegate respondsToSelector:@selector(pickerViewButton:titleForSelectedRows:)]) {
        
        NSMutableArray *selectedRowIndexes = [[NSMutableArray alloc] init];
        
        for (NSInteger i=0; i<[self _numberOfComponentsInPickerView]; i++) {
            NSInteger row = [self selectedRowInComponent:i];
            
            [selectedRowIndexes addObject:@(row)];
        }
        
        if ([self.delegate respondsToSelector:@selector(pickerViewButton:attributedTitleForSelectedRows:)]) {
            NSAttributedString *retval = [self.delegate pickerViewButton:self attributedTitleForSelectedRows:selectedRowIndexes];
            
            return KSTIsEmptyObject(retval) ? defaultRetvalBlock() : retval;
        }
        else {
            NSString *retval = [self.delegate pickerViewButton:self titleForSelectedRows:selectedRowIndexes];
            
            return KSTIsEmptyObject(retval) ? defaultRetvalBlock() : [[NSAttributedString alloc] initWithString:retval];
        }
    }
    else {
        return defaultRetvalBlock();
    }
}
- (id)_imageForSelectedRowsInPickerView {
    if ([self.delegate respondsToSelector:@selector(pickerViewButton:imageForSelectedRows:)]) {
        NSMutableArray *selectedRowIndexes = [[NSMutableArray alloc] init];
        
        for (NSInteger i=0; i<[self _numberOfComponentsInPickerView]; i++) {
            NSInteger row = [self selectedRowInComponent:i];
            
            [selectedRowIndexes addObject:@(row)];
        }
        
        return [self.delegate pickerViewButton:self imageForSelectedRows:selectedRowIndexes];
    }
    return NSNull.null;
}
- (void)_reloadTitleForSelectedRowsInPickerView; {
    NSAttributedString *attrString = [self _attributedTitleForSelectedRowsInPickerView];
    
    if (self.buttonType == UIButtonTypeSystem) {
        [self setTitle:attrString.string forState:UIControlStateNormal];
    }
    else {
        [self setAttributedTitle:attrString forState:UIControlStateNormal];
    }
    
    id image = [self _imageForSelectedRowsInPickerView];
    
    // if our internal method returns NSNull, do not change the image
    if ([image isEqual:NSNull.null]) {
        return;
    }
    
    [self setImage:image forState:UIControlStateNormal];
}

+ (NSString *)_defaultSelectedComponentsJoinString; {
    return @" ";
}
#pragma mark Actions
- (IBAction)_toggleFirstResponderAction:(id)sender {
    if (self.isPresentingPickerView) {
        [self dismissPickerView];
    }
    else {
        [self presentPickerView];
    }
}

@end
