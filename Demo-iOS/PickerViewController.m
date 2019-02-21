//
//  PickerViewController.m
//  Demo-iOS
//
//  Created by William Towe on 4/10/18.
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

#import "PickerViewController.h"
#import "Constants.h"
#import "UIViewController+Extensions.h"

#import <Ditko/Ditko.h>
#import <Stanley/Stanley.h>
#import <KSOFontAwesomeExtensions/KSOFontAwesomeExtensions.h>

@interface PickerViewController () <KDIPickerViewButtonDataSource,KDIPickerViewButtonDelegate>
@property (weak,nonatomic) IBOutlet KDIPickerViewButton *pickerViewButton;

@property (copy,nonatomic) NSArray<NSArray<NSString *> *> *rowsAndComponents;
@property (copy,nonatomic) NSArray<NSArray<NSString *> *> *imageStrings;
@end

@implementation PickerViewController

- (NSString *)title {
    return [self.class detailViewTitle];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.rowsAndComponents = @[@[@"Red",@"Green",@"Blue"],
                               @[@"One",@"Two",@"Three"]];
    self.imageStrings = @[@[@"\uf2b9",@"\uf058",@"\uf0f3"],
                          @[NSNull.null,NSNull.null,NSNull.null]];
    
    [self KSO_addNavigationBarTitleView];
    
    self.pickerViewButton.titleEdgeInsets = UIEdgeInsetsMake(0, kSubviewMargin, 0, 0);
    [self.pickerViewButton setImage:[UIImage KSO_fontAwesomeSolidImageWithString:@"\uf08d" size:kBarButtonItemImageSize].KDI_templateImage forState:UIControlStateNormal];
    self.pickerViewButton.selectedComponentsJoinString = @", ";
    self.pickerViewButton.dataSource = self;
    self.pickerViewButton.delegate = self;
}

- (NSInteger)numberOfComponentsInPickerViewButton:(KDIPickerViewButton *)pickerViewButton {
    return self.rowsAndComponents.count;
}
- (NSInteger)pickerViewButton:(KDIPickerViewButton *)pickerViewButton numberOfRowsInComponent:(NSInteger)component {
    return self.rowsAndComponents[component].count;
}
- (NSString *)pickerViewButton:(KDIPickerViewButton *)pickerViewButton titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    return self.rowsAndComponents[component][row];
}
- (UIImage *)pickerViewButton:(KDIPickerViewButton *)pickerViewButton imageForRow:(NSInteger)row forComponent:(NSInteger)component {
    id string = self.imageStrings[component][row];
    
    if (KSTIsEmptyObject(string)) {
        return nil;
    }
    
    return [UIImage KSO_fontAwesomeRegularImageWithString:string size:kBarButtonItemImageSize].KDI_templateImage;
}

- (UIImage *)pickerViewButton:(KDIPickerViewButton *)pickerViewButton imageForSelectedRows:(NSArray<NSNumber *> *)selectedRows {
    return [UIImage KSO_fontAwesomeRegularImageWithString:self.imageStrings.firstObject[selectedRows.firstObject.integerValue] size:kBarButtonItemImageSize].KDI_templateImage;
}
- (void)pickerViewButton:(KDIPickerViewButton *)pickerViewButton didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    KSTLog(@"row %@ component %@",@(row),@(component));
}

+ (NSString *)detailViewTitle {
    return @"KDIPickerViewButton";
}
+ (NSString *)detailViewSubtitle {
    return @"UIButton that manages a UIPickerView";
}

@end
