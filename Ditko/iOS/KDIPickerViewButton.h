//
//  KDIPickerViewButton.h
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

#import <Ditko/KDIButton.h>

NS_ASSUME_NONNULL_BEGIN

@class KDIPickerViewButton;

@protocol KDIPickerViewButtonDataSource <NSObject>
@required
- (NSInteger)pickerViewButton:(KDIPickerViewButton *)pickerViewButton numberOfRowsInComponent:(NSInteger)component;
@optional
- (NSInteger)numberOfComponentsInPickerViewButton:(KDIPickerViewButton *)pickerViewButton;
- (nullable NSString *)pickerViewButton:(KDIPickerViewButton *)pickerViewButton titleForRow:(NSInteger)row forComponent:(NSInteger)component;
- (nullable NSAttributedString *)pickerViewButton:(KDIPickerViewButton *)pickerViewButton attributedTitleForRow:(NSInteger)row forComponent:(NSInteger)component;
@end

@protocol KDIPickerViewButtonDelegate <NSObject>
@optional
- (NSString *)pickerViewButton:(KDIPickerViewButton *)pickerViewButton titleForSelectedRows:(NSArray<NSNumber *> *)selectedRows;
- (NSAttributedString *)pickerViewButton:(KDIPickerViewButton *)pickerViewButton attributedTitleForSelectedRows:(NSArray<NSNumber *> *)selectedRows;
- (void)pickerViewButton:(KDIPickerViewButton *)pickerViewButton didSelectRow:(NSInteger)row inComponent:(NSInteger)component;
@end

@interface KDIPickerViewButton : KDIButton

@property (weak,nonatomic,nullable) id<KDIPickerViewButtonDataSource> dataSource;
@property (weak,nonatomic,nullable) id<KDIPickerViewButtonDelegate> delegate;

@property (copy,nonatomic,null_resettable) NSString *selectedComponentsJoinString;

- (void)reloadData;

- (NSInteger)selectedRowInComponent:(NSInteger)component;
- (void)selectRow:(NSInteger)row inComponent:(NSInteger)component;

@end

NS_ASSUME_NONNULL_END
