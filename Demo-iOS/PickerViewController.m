//
//  PickerViewController.m
//  Demo-iOS
//
//  Created by William Towe on 4/10/18.
//  Copyright © 2019 Kosoku Interactive, LLC. All rights reserved.
//
//  Redistribution and use in source and binary forms, with or without modification, are permitted provided that the following conditions are met:
//
//  1. Redistributions of source code must retain the above copyright notice, this list of conditions and the following disclaimer.
//
//  2. Redistributions in binary form must reproduce the above copyright notice, this list of conditions and the following disclaimer in the documentation and/or other materials provided with the distribution.
//
//  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

#import "PickerViewController.h"
#import "Constants.h"
#import "UIViewController+Extensions.h"

#import <Ditko/Ditko.h>
#import <Stanley/Stanley.h>
#import <KSOFontAwesomeExtensions/KSOFontAwesomeExtensions.h>

@interface PickerViewController () <KDIPickerViewButtonDataSource,KDIPickerViewButtonDelegate>
@property (weak,nonatomic) IBOutlet KDIPickerViewButton *pickerViewButton;

@property (copy,nonatomic) NSArray<NSArray<NSString *> *> *rowsAndComponents;
@end

@implementation PickerViewController

- (NSString *)title {
    return [self.class detailViewTitle];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.rowsAndComponents = @[@[@"Red",@"Green",@"Blue"],
                               @[@"One",@"Two",@"Three"]];
    
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
