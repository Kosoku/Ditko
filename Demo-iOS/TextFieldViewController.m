//
//  TextFieldViewController.m
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

#import "TextFieldViewController.h"
#import "UIViewController+Extensions.h"
#import "Constants.h"

#import <Ditko/Ditko.h>
#import <Stanley/Stanley.h>
#import <KSOFontAwesomeExtensions/KSOFontAwesomeExtensions.h>

@interface TextFieldViewController ()
@property (weak,nonatomic) IBOutlet KDITextField *textField;
@end

@implementation TextFieldViewController

- (NSString *)title {
    return [self.class detailViewTitle];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self KSO_addNavigationBarTitleView];
    
    self.textField.textEdgeInsets = UIEdgeInsetsMake(kSubviewMargin, kSubviewMargin, kSubviewMargin, kSubviewMargin);
    self.textField.leftViewEdgeInsets = UIEdgeInsetsMake(kSubviewMargin, kSubviewMargin, kSubviewMargin, 0);
    self.textField.leftView = ({
        UIImageView *retval = [[UIImageView alloc] initWithImage:[UIImage KSO_fontAwesomeSolidImageWithString:@"\uf0f3" size:kBarButtonItemImageSize].KDI_templateImage];
        
        retval.tintColor = UIColor.lightGrayColor;
        
        retval;
    });
    self.textField.leftViewMode = UITextFieldViewModeAlways;
    self.textField.rightViewEdgeInsets = UIEdgeInsetsMake(kSubviewMargin, 0, kSubviewMargin, kSubviewMargin);
    self.textField.rightView = ({
        UIButton *retval = [UIButton buttonWithType:UIButtonTypeSystem];
        
        [retval setImage:[UIImage KSO_fontAwesomeSolidImageWithString:@"\uf030" size:kBarButtonItemImageSize].KDI_templateImage forState:UIControlStateNormal];
        [retval sizeToFit];
        
        retval;
    });
    self.textField.rightViewMode = UITextFieldViewModeAlways;
}

+ (NSString *)detailViewTitle {
    return @"KDITextField";
}
+ (NSString *)detailViewSubtitle {
    return @"UITextField subclass with inset support";
}

@end
