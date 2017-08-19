//
//  KDIPickerViewButton.m
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

#import "KDIPickerViewButton.h"
#import "KDINextPreviousInputAccessoryView.h"

@interface KDIPickerViewButton () <UIPickerViewDataSource,UIPickerViewDelegate>
@property (readwrite,nonatomic) UIView *inputView;
@property (readwrite,nonatomic) UIView *inputAccessoryView;

@property (strong,nonatomic) UIPickerView *pickerView;

- (void)_KDIPickerViewButtonInit;
- (NSInteger)_numberOfComponentsInPickerView;
- (NSAttributedString *)_attributedTitleForRow:(NSInteger)row inComponent:(NSInteger)component;
- (NSAttributedString *)_attributedTitleForSelectedRowsInPickerView;
- (void)_reloadTitleForSelectedRowsInPickerView;

+ (NSString *)_defaultSelectedComponentsJoinString;
@end

@implementation KDIPickerViewButton

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

- (BOOL)canBecomeFirstResponder {
    return YES;
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return [self _numberOfComponentsInPickerView];
}
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return [self.dataSource pickerViewButton:self numberOfRowsInComponent:component];
}

- (NSAttributedString *)pickerView:(UIPickerView *)pickerView attributedTitleForRow:(NSInteger)row forComponent:(NSInteger)component {
    if ([self.dataSource respondsToSelector:@selector(pickerView:attributedTitleForRow:forComponent:)]) {
        return [self.dataSource pickerViewButton:self attributedTitleForRow:row forComponent:component];
    }
    else {
        return [[NSAttributedString alloc] initWithString:[self.dataSource pickerViewButton:self titleForRow:row forComponent:component]];
    }
}
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    [self _reloadTitleForSelectedRowsInPickerView];
    
    if ([self.delegate respondsToSelector:@selector(pickerViewButton:didSelectRow:inComponent:)]) {
        [self.delegate pickerViewButton:self didSelectRow:row inComponent:component];
    }
}

- (void)reloadData {
    [self.pickerView reloadAllComponents];
    
    [self _reloadTitleForSelectedRowsInPickerView];
}

- (NSInteger)selectedRowInComponent:(NSInteger)component {
    return [self.pickerView selectedRowInComponent:component];
}
- (void)selectRow:(NSInteger)row inComponent:(NSInteger)component {
    [self.pickerView selectRow:row inComponent:component animated:NO];
    
    [self _reloadTitleForSelectedRowsInPickerView];
}

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

- (void)_KDIPickerViewButtonInit; {
    _selectedComponentsJoinString = [self.class _defaultSelectedComponentsJoinString];
    
    [self addTarget:self action:@selector(_toggleFirstResponderAction:) forControlEvents:UIControlEventTouchUpInside];
    
    _pickerView = [[UIPickerView alloc] initWithFrame:CGRectZero];
    [_pickerView setShowsSelectionIndicator:YES];
    [_pickerView setDataSource:self];
    [_pickerView setDelegate:self];
    [_pickerView sizeToFit];
    
    [self setInputView:_pickerView];
    
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
    if ([self.delegate respondsToSelector:@selector(pickerViewButton:attributedTitleForSelectedRows:)] ||
        [self.delegate respondsToSelector:@selector(pickerViewButton:titleForSelectedRows:)]) {
        
        NSMutableArray *selectedRowIndexes = [[NSMutableArray alloc] init];
        
        for (NSInteger i=0; i<[self _numberOfComponentsInPickerView]; i++) {
            NSInteger row = [self selectedRowInComponent:i];
            
            [selectedRowIndexes addObject:@(row)];
        }
        
        if ([self.delegate respondsToSelector:@selector(pickerViewButton:attributedTitleForSelectedRows:)]) {
            return [self.delegate pickerViewButton:self attributedTitleForSelectedRows:selectedRowIndexes];
        }
        else {
            return [[NSAttributedString alloc] initWithString:[self.delegate pickerViewButton:self titleForSelectedRows:selectedRowIndexes]];
        }
    }
    else {
        NSMutableAttributedString *retval = [[NSMutableAttributedString alloc] initWithString:@""];
        
        for (NSInteger i=0; i<[self _numberOfComponentsInPickerView]; i++) {
            NSInteger row = [self selectedRowInComponent:i];
            
            [retval appendAttributedString:[self _attributedTitleForRow:row inComponent:i]];
            
            if (i != [self _numberOfComponentsInPickerView] - 1) {
                [retval appendAttributedString:[[NSAttributedString alloc] initWithString:self.selectedComponentsJoinString]];
            }
        }
        
        return retval;
    }
}
- (void)_reloadTitleForSelectedRowsInPickerView; {
    [self setAttributedTitle:[self _attributedTitleForSelectedRowsInPickerView] forState:UIControlStateNormal];
}

+ (NSString *)_defaultSelectedComponentsJoinString; {
    return @" ";
}

- (IBAction)_toggleFirstResponderAction:(id)sender {
    if (self.isFirstResponder) {
        [self resignFirstResponder];
    }
    else {
        [self becomeFirstResponder];
    }
}

@end
