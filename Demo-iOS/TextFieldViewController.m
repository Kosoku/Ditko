//
//  TextFieldViewController.m
//  Demo-iOS
//
//  Created by William Towe on 4/10/18.
//  Copyright © 2018 Kosoku Interactive, LLC. All rights reserved.
//
//  Redistribution and use in source and binary forms, with or without modification, are permitted provided that the following conditions are met:
//
//  1. Redistributions of source code must retain the above copyright notice, this list of conditions and the following disclaimer.
//
//  2. Redistributions in binary form must reproduce the above copyright notice, this list of conditions and the following disclaimer in the documentation and/or other materials provided with the distribution.
//
//  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

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
