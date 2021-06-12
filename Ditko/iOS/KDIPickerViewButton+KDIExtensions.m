//
//  KDIPickerViewButton+KDIExtensions.m
//  Ditko-iOS
//
//  Created by William Towe on 9/9/18.
//  Copyright © 2021 Kosoku Interactive, LLC. All rights reserved.
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

#import "KDIPickerViewButton+KDIExtensions.h"

#import <Stanley/Stanley.h>

#import <objc/runtime.h>

@interface KDIPickerViewButtonDataSourceDelegateWrapper : NSObject <KDIPickerViewButtonDataSource, KDIPickerViewButtonDelegate>
@property (weak,nonatomic) KDIPickerViewButton *button;
@property (copy,nonatomic) NSArray<NSArray<id<KDIPickerViewButtonRow>> *> *rowsAndColumns;
@property (copy,nonatomic) KDIPickerViewButtonDelegateTitleForSelectedRowBlock titleForSelectedRowBlock;
@property (copy,nonatomic) KDIPickerViewButtonDelegateTitleForSelectedRowsBlock titleForSelectedRowsBlock;
@property (copy,nonatomic) KDIPickerViewButtonDelegateDidSelectRowBlock didSelectRowBlock;
@property (copy,nonatomic) KDIPickerViewButtonDelegateDidSelectRowsBlock didSelectRowsBlock;

- (instancetype)initWithPickerViewButton:(KDIPickerViewButton *)button rowsAndColumns:(NSArray<NSArray<id<KDIPickerViewButtonRow>> *> *)rowsAndColumns titleForSelectedRowBlock:(KDIPickerViewButtonDelegateTitleForSelectedRowBlock)titleForSelectedRowBlock titleForSelectedRowsBlock:(KDIPickerViewButtonDelegateTitleForSelectedRowsBlock)titleForSelectedRowsBlock didSelectRowBlock:(KDIPickerViewButtonDelegateDidSelectRowBlock)didSelectRowBlock didSelectRowsBlock:(KDIPickerViewButtonDelegateDidSelectRowsBlock)didSelectRowsBlock;
@end

@interface KDIPickerViewButton (KDIPrivateExtensions)
@property (strong,nonatomic) KDIPickerViewButtonDataSourceDelegateWrapper *KDI_pickerViewButtonDataSourceDelegateWrapper;
@end

@implementation KDIPickerViewButton (KDIExtensions)

- (NSArray<id<KDIPickerViewButtonRow>> *)KDI_pickerViewButtonRows {
    return self.KDI_pickerViewButtonRowsAndColumns.firstObject;
}
- (NSArray<NSArray<id<KDIPickerViewButtonRow>> *> *)KDI_pickerViewButtonRowsAndColumns {
    return self.KDI_pickerViewButtonDataSourceDelegateWrapper.rowsAndColumns;
}

- (void)KDI_setPickerViewButtonRows:(NSArray<id<KDIPickerViewButtonRow>> *)rows didSelectRowBlock:(KDIPickerViewButtonDelegateDidSelectRowBlock)didSelectRowBlock; {
    [self KDI_setPickerViewButtonRows:rows titleForSelectedRowBlock:nil didSelectRowBlock:didSelectRowBlock];
}
- (void)KDI_setPickerViewButtonRows:(NSArray<id<KDIPickerViewButtonRow>> *)rows titleForSelectedRowBlock:(KDIPickerViewButtonDelegateTitleForSelectedRowBlock)titleForSelectedRowBlock didSelectRowBlock:(KDIPickerViewButtonDelegateDidSelectRowBlock)didSelectRowBlock {
    self.KDI_pickerViewButtonDataSourceDelegateWrapper = [[KDIPickerViewButtonDataSourceDelegateWrapper alloc] initWithPickerViewButton:self rowsAndColumns:@[rows] titleForSelectedRowBlock:titleForSelectedRowBlock titleForSelectedRowsBlock:nil didSelectRowBlock:didSelectRowBlock didSelectRowsBlock:nil];
}

- (void)KDI_setPickerViewButtonRowsAndColumns:(NSArray<NSArray<id<KDIPickerViewButtonRow>> *> *)rowsAndColumns didSelectRowsBlock:(KDIPickerViewButtonDelegateDidSelectRowsBlock)didSelectRowsBlock; {
    [self KDI_setPickerViewButtonRowsAndColumns:rowsAndColumns titleForSelectedRowsBlock:nil didSelectRowsBlock:didSelectRowsBlock];
}
- (void)KDI_setPickerViewButtonRowsAndColumns:(NSArray<NSArray<id<KDIPickerViewButtonRow>> *> *)rowsAndColumns titleForSelectedRowsBlock:(KDIPickerViewButtonDelegateTitleForSelectedRowsBlock)titleForSelectedRowsBlock didSelectRowsBlock:(KDIPickerViewButtonDelegateDidSelectRowsBlock)didSelectRowsBlock {
    self.KDI_pickerViewButtonDataSourceDelegateWrapper = [[KDIPickerViewButtonDataSourceDelegateWrapper alloc] initWithPickerViewButton:self rowsAndColumns:rowsAndColumns titleForSelectedRowBlock:nil titleForSelectedRowsBlock:titleForSelectedRowsBlock didSelectRowBlock:nil didSelectRowsBlock:didSelectRowsBlock];
}

@end

@implementation NSString (KDIPickerViewButtonRowExtensions)

- (NSString *)pickerViewButtonRowTitle {
    return self;
}

@end

@implementation NSAttributedString (KDIPickerViewButtonRowExtensions)

- (NSString *)pickerViewButtonRowTitle {
    return self.string;
}

@end

@implementation KDIPickerViewButton (KDIPrivateExtensions)

static void const *kKDI_pickerViewButtonDataSourceDelegateWrapperKey = &kKDI_pickerViewButtonDataSourceDelegateWrapperKey;

@dynamic KDI_pickerViewButtonDataSourceDelegateWrapper;
- (KDIPickerViewButtonDataSourceDelegateWrapper *)KDI_pickerViewButtonDataSourceDelegateWrapper {
    return objc_getAssociatedObject(self, kKDI_pickerViewButtonDataSourceDelegateWrapperKey);
}
- (void)setKDI_pickerViewButtonDataSourceDelegateWrapper:(KDIPickerViewButtonDataSourceDelegateWrapper *)KDI_pickerViewButtonDataSourceDelegateWrapper {
    objc_setAssociatedObject(self, kKDI_pickerViewButtonDataSourceDelegateWrapperKey, KDI_pickerViewButtonDataSourceDelegateWrapper, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end

@implementation KDIPickerViewButtonDataSourceDelegateWrapper

- (NSInteger)numberOfComponentsInPickerViewButton:(KDIPickerViewButton *)pickerViewButton {
    return self.rowsAndColumns.count;
}
- (NSInteger)pickerViewButton:(KDIPickerViewButton *)pickerViewButton numberOfRowsInComponent:(NSInteger)component {
    return self.rowsAndColumns[component].count;
}
- (NSString *)pickerViewButton:(KDIPickerViewButton *)pickerViewButton titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    return self.rowsAndColumns[component][row].pickerViewButtonRowTitle;
}

- (NSString *)pickerViewButton:(KDIPickerViewButton *)pickerViewButton titleForSelectedRows:(NSArray<NSNumber *> *)selectedRows {
    NSMutableArray *temp = [[NSMutableArray alloc] init];
    
    [selectedRows enumerateObjectsUsingBlock:^(NSNumber * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [temp addObject:self.rowsAndColumns[idx][obj.integerValue]];
    }];
    
    if (self.titleForSelectedRowsBlock != nil) {
        return self.titleForSelectedRowsBlock(temp);
    }
    else if (self.titleForSelectedRowBlock != nil) {
        return self.titleForSelectedRowBlock(temp.firstObject);
    }
    return nil;
}
- (void)pickerViewButton:(KDIPickerViewButton *)pickerViewButton didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    NSMutableArray *temp = [[NSMutableArray alloc] init];
    
    for (NSInteger i=0; i<self.rowsAndColumns.count; i++) {
        NSInteger j = [self.button selectedRowInComponent:i];
        
        [temp addObject:self.rowsAndColumns[i][j]];
    }
    
    if (self.didSelectRowsBlock != nil) {
        self.didSelectRowsBlock(temp);
    }
    else if (self.didSelectRowBlock != nil) {
        self.didSelectRowBlock(temp.firstObject);
    }
}

- (instancetype)initWithPickerViewButton:(KDIPickerViewButton *)button rowsAndColumns:(NSArray<NSArray<id<KDIPickerViewButtonRow>> *> *)rowsAndColumns titleForSelectedRowBlock:(KDIPickerViewButtonDelegateTitleForSelectedRowBlock)titleForSelectedRowBlock titleForSelectedRowsBlock:(KDIPickerViewButtonDelegateTitleForSelectedRowsBlock)titleForSelectedRowsBlock didSelectRowBlock:(KDIPickerViewButtonDelegateDidSelectRowBlock)didSelectRowBlock didSelectRowsBlock:(KDIPickerViewButtonDelegateDidSelectRowsBlock)didSelectRowsBlock {
    if (!(self = [super init]))
        return nil;
    
    _button = button;
    _rowsAndColumns = [rowsAndColumns copy];
    _titleForSelectedRowBlock = [titleForSelectedRowBlock copy];
    _titleForSelectedRowsBlock = [titleForSelectedRowsBlock copy];
    _didSelectRowBlock = [didSelectRowBlock copy];
    _didSelectRowsBlock = [didSelectRowsBlock copy];
    
    _button.dataSource = self;
    _button.delegate = self;
    
    return self;
}

@end
