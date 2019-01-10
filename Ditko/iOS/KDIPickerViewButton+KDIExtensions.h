//
//  KDIPickerViewButton+KDIExtensions.h
//  Ditko-iOS
//
//  Created by William Towe on 9/9/18.
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
