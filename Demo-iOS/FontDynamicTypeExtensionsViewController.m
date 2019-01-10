//
//  FontDynamicTypeExtensionsViewController.m
//  Demo-iOS
//
//  Created by William Towe on 4/11/18.
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

#import "FontDynamicTypeExtensionsViewController.h"
#import "UIViewController+Extensions.h"

#import <Ditko/Ditko.h>
#import <Stanley/Stanley.h>

@interface FontDynamicTypeExtensionsViewController ()
@property (weak,nonatomic) IBOutlet KDIPickerViewButton *fontPickerViewButton;
@property (weak,nonatomic) IBOutlet UILabel *label;
@property (weak,nonatomic) IBOutlet UIButton *button;
@property (weak,nonatomic) IBOutlet UISegmentedControl *segmentedControl;
@property (weak,nonatomic) IBOutlet UITextField *textField;
@property (weak,nonatomic) IBOutlet KDITextView *textView;
@property (weak,nonatomic) IBOutlet KDIBadgeView *badgeView;

- (void)_updateDynamicTypeObjectsWithFontName:(NSString *)fontName;
@end

@implementation FontDynamicTypeExtensionsViewController

- (NSString *)title {
    return [self.class detailViewTitle];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    kstWeakify(self);
    
    [self KSO_addNavigationBarTitleView];
    
    self.textView.placeholder = @"Text View";
    
    self.badgeView.badge = @"Badge View";
    
    NSMutableArray *fontNames = [[NSMutableArray alloc] init];
    
    for (NSString *familyName in UIFont.familyNames) {
        [fontNames addObjectsFromArray:[UIFont fontNamesForFamilyName:familyName]];
    }
    
    [self _updateDynamicTypeObjectsWithFontName:fontNames.firstObject];
    
    [self.fontPickerViewButton KDI_setPickerViewButtonRows:fontNames didSelectRowBlock:^(NSString * _Nonnull row) {
        kstStrongify(self);
        [self _updateDynamicTypeObjectsWithFontName:row];
    }];
}

+ (NSString *)detailViewTitle {
    return @"UIFont+KDIDynamicTypeExtensions";
}
+ (NSString *)detailViewSubtitle {
    return @"Dynamic type support for custom objects";
}

- (void)_updateDynamicTypeObjectsWithFontName:(NSString *)fontName; {
    [NSObject KDI_registerDynamicTypeObjects:@[self.textField, self.textView, self.button, self.segmentedControl, self.label, self.badgeView, self.fontPickerViewButton] forTextStyle:UIFontTextStyleBody withFont:[UIFont fontWithName:fontName size:17.0]];
}

@end
