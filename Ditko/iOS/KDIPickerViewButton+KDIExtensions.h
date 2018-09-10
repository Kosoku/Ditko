//
//  KDIPickerViewButton+KDIExtensions.h
//  Ditko-iOS
//
//  Created by William Towe on 9/9/18.
//  Copyright © 2018 Kosoku Interactive, LLC. All rights reserved.
//
//  Redistribution and use in source and binary forms, with or without modification, are permitted provided that the following conditions are met:
//
//  1. Redistributions of source code must retain the above copyright notice, this list of conditions and the following disclaimer.
//
//  2. Redistributions in binary form must reproduce the above copyright notice, this list of conditions and the following disclaimer in the documentation and/or other materials provided with the distribution.
//
//  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

#import <Ditko/KDIPickerViewButton.h>

NS_ASSUME_NONNULL_BEGIN

@protocol KDIPickerViewButtonRow;

/**
 Block that is invoked to determine the picker view button title for the selected row. If you return nil, the default title is used instead.
 
 @param row The selected row
 @return The title or nil
 */
typedef NSString* _Nullable (^KDIPickerViewButtonDelegateTitleForSelectedRowBlock)(id<KDIPickerViewButtonRow> row);
/**
 Block that is invoked the determine the picker view button title for the selected rows. The array contains the selected row for each column in the picker view button. If you return nil, the default title is used instead.
 
 @param rows The selected row for each column
 @return The title or nil
 */
typedef NSString* _Nullable (^KDIPickerViewButtonDelegateTitleForSelectedRowsBlock)(NSArray<id<KDIPickerViewButtonRow>> *rows);

/**
 Block that is invoked when the user selects a picker view button row.
 
 @param row The selected row
 */
typedef void(^KDIPickerViewButtonDelegateDidSelectRowBlock)(id<KDIPickerViewButtonRow> row);
/**
 Block that is invoked when the user selects a picker view button row. The array contains the selected row for each column in the picker view button.
 
 @param rows The selected row for each column
 */
typedef void(^KDIPickerViewButtonDelegateDidSelectRowsBlock)(NSArray<id<KDIPickerViewButtonRow>> *rows);

/**
 A collection of category methods that wrap the KDIPickerViewButtonDataSource and KDIPickerViewButtonDelegate protocols for convenience.
 */
@interface KDIPickerViewButton (KDIExtensions)

/**
 Get the array of KDIPickerViewButtonRow objects that was set via the below methods.
 
 @see KDIPickerViewButtonRow
 */
@property (readonly,copy,nonatomic,nullable) NSArray<id<KDIPickerViewButtonRow>> *KDI_pickerViewButtonRows;
/**
 Get the array of arrays of KDIPickerViewButtonRow objects that was set via the below methods.
 
 @see KDIPickerViewButtonRow
 */
@property (readonly,copy,nonatomic,nullable) NSArray<NSArray<id<KDIPickerViewButtonRow>> *> *KDI_pickerViewButtonRowsAndColumns;

/**
 Calls KDI_setPickerViewButtonRows:titleForSelectedRowBlock:didSelectRowBlock:, passing *rows*, nil, and *didSelectRowBlock* respectively.
 
 @param rows The KDIPickerViewButtonRow objects to display in the picker view button
 @param didSelectRowBlock The block invoked when the user selects a row in the picker view button
 */
- (void)KDI_setPickerViewButtonRows:(NSArray<id<KDIPickerViewButtonRow>> *)rows didSelectRowBlock:(KDIPickerViewButtonDelegateDidSelectRowBlock)didSelectRowBlock;
/**
 Overrides the picker view button's dataSource and delegate properties to display *rows*.
 
 @param rows The KDIPickerViewButtonRow objects to display in the picker view button
 @param titleForSelectedRowBlock The block invoked to determine the title for the picker view button
 @param didSelectRowBlock The block invoked when the user selects a row in the picker view button
 */
- (void)KDI_setPickerViewButtonRows:(NSArray<id<KDIPickerViewButtonRow>> *)rows titleForSelectedRowBlock:(nullable KDIPickerViewButtonDelegateTitleForSelectedRowBlock)titleForSelectedRowBlock didSelectRowBlock:(KDIPickerViewButtonDelegateDidSelectRowBlock)didSelectRowBlock;

/**
 Calls KDI_setPickerViewButtonRowsAndColumns:titleForSelectedRowsBlock:didSelectRowsBlock:, passing *rowsAndColumns*, nil, and *didSelectRowsBlock* respectively.
 
 @param rowsAndColumns The columns of KDIPickerViewButtonRow objects to display in the picker view button
 @param didSelectRowsBlock The block invoked when the user selects a row in the picker view button
 */
- (void)KDI_setPickerViewButtonRowsAndColumns:(NSArray<NSArray<id<KDIPickerViewButtonRow>> *> *)rowsAndColumns didSelectRowsBlock:(KDIPickerViewButtonDelegateDidSelectRowsBlock)didSelectRowsBlock;
/**
 Overrides the picker view button's dataSource and delegate properties to display *rowsAndColumns*.
 
 @param rowsAndColumns The columns of KDIPickerViewButtonRow objects to display in the picker view button
 @param titleForSelectedRowsBlock The block invoked to determine the title for the picker view button
 @param didSelectRowsBlock The block invoked when the user selects a row in the picker view button
 */
- (void)KDI_setPickerViewButtonRowsAndColumns:(NSArray<NSArray<id<KDIPickerViewButtonRow>> *> *)rowsAndColumns titleForSelectedRowsBlock:(nullable KDIPickerViewButtonDelegateTitleForSelectedRowsBlock)titleForSelectedRowsBlock didSelectRowsBlock:(KDIPickerViewButtonDelegateDidSelectRowsBlock)didSelectRowsBlock;

@end

/**
 Protocol describing an object that can be displayed as a row in a KDIPickerViewButton.
 */
@protocol KDIPickerViewButtonRow <NSObject>
@required
/**
 The title that should be displayed for the given row.
 */
@property (readonly,nonatomic) NSString *pickerViewButtonRowTitle;
@end

/**
 Adds support for the KDIPickerViewButtonRow protocol to NSString.
 */
@interface NSString (KDIPickerViewButtonRowExtensions) <KDIPickerViewButtonRow>
@end

/**
 Adds support for the KDIPickerViewButtonRow protocol to NSAttributedString.
 */
@interface NSAttributedString (KDIPickerViewButtonRowExtensions) <KDIPickerViewButtonRow>
@end

NS_ASSUME_NONNULL_END
