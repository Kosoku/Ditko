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

/**
 Protocol describing the data source of a KDIPickerViewButton instance.
 */
@protocol KDIPickerViewButtonDataSource <NSObject>
@required
/**
 Returns the number of rows in the provided component of the picker view button.
 
 @param pickerViewButton The sender of the message
 @param component The component for which to return the number of rows
 @return The number of rows
 */
- (NSInteger)pickerViewButton:(KDIPickerViewButton *)pickerViewButton numberOfRowsInComponent:(NSInteger)component;
@optional
/**
 Returns the number of components in the picker view button. If this method is not implemented, a return value of 1 is assumed.
 
 @param pickerViewButton The sender of the message
 @return The number of components
 */
- (NSInteger)numberOfComponentsInPickerViewButton:(KDIPickerViewButton *)pickerViewButton;

/**
 Returns the string title for the provided row and component of the picker view button. This method or pickerViewButton:attributedTitleForRow:forComponent: must be implemented or an exception will be thrown.
 
 @param pickerViewButton The sender of the message
 @param row The row for which to return the string title
 @param component The component for which to return the string title
 @return The string title
 */
- (nullable NSString *)pickerViewButton:(KDIPickerViewButton *)pickerViewButton titleForRow:(NSInteger)row forComponent:(NSInteger)component;
/**
 Returns the string title for the provided row and component of the picker view button. This method or pickerViewButton:titleForRow:forComponent: must be implemented or an exception will be thrown. If this method is implemented, it is preferred over pickerViewButton:titleForRow:forComponent:.
 
 @param pickerViewButton The sender of the message
 @param row The row for which to return the attributed string title
 @param component The component for which to return the attributed string title
 @return The attributed string title
 */
- (nullable NSAttributedString *)pickerViewButton:(KDIPickerViewButton *)pickerViewButton attributedTitleForRow:(NSInteger)row forComponent:(NSInteger)component;
@end

/**
 Protocol describing the delegate of a KDIPickerViewButton instance.
 */
@protocol KDIPickerViewButtonDelegate <NSObject>
@optional
/**
 Returns the string title that will be used as the picker view button's title given the selected rows. The provided array contains one NSNumber representing the selected row in each component.
 
 @param pickerViewButton The sender of the message
 @param selectedRows The selected rows for which to return the string title
 @return The string title
 */
- (NSString *)pickerViewButton:(KDIPickerViewButton *)pickerViewButton titleForSelectedRows:(NSArray<NSNumber *> *)selectedRows;
/**
 Returns the attributed string title that will be used as the picker view button's title given the selected rows. The provided array contains one NSNumber representing the selected row in each component. If this method is implemented, it is preferred over pickerViewButton:titleForSelectedRows:.
 
 @param pickerViewButton The sender of the message
 @param selectedRows The selected rows for which to return the attributed string title
 @return The attributed string title
 */
- (NSAttributedString *)pickerViewButton:(KDIPickerViewButton *)pickerViewButton attributedTitleForSelectedRows:(NSArray<NSNumber *> *)selectedRows;
/**
 Called when the picker view button selection changes.
 
 @param pickerViewButton The sender of the message
 @param row The row that was selected
 @param component The component that was selected
 */
- (void)pickerViewButton:(KDIPickerViewButton *)pickerViewButton didSelectRow:(NSInteger)row inComponent:(NSInteger)component;
@end

/**
 KDIPickerViewButton is a KDIButton subclass that manages a UIPickerView instance as its inputView.
 */
@interface KDIPickerViewButton : KDIButton

/**
 Get and set the data source of the picker view button.
 
 @see KDIPickerViewButtonDataSource
 */
@property (weak,nonatomic,nullable) id<KDIPickerViewButtonDataSource> dataSource;
/**
 Get and set the delegate of the picker view button.
 
 @see KDIPickerViewButtonDelegate
 */
@property (weak,nonatomic,nullable) id<KDIPickerViewButtonDelegate> delegate;

/**
 Get and set the string used to join each selected row string title when the selection of the picker view button changes. The default is @" ".
 */
@property (copy,nonatomic,null_resettable) NSString *selectedComponentsJoinString;

/**
 Reloads all the picker view button's rows/components.
 */
- (void)reloadData;

/**
 Returns the selected row for the provided component. Returns -1 if there is no row selected for the provided component.
 
 @param component The component for which to return the selected row
 @return The selected row
 */
- (NSInteger)selectedRowInComponent:(NSInteger)component;
/**
 Select the provided row in the component.
 
 @param row The row to select
 @param component The component to select
 */
- (void)selectRow:(NSInteger)row inComponent:(NSInteger)component;

@end

NS_ASSUME_NONNULL_END
