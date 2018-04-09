//
//  ViewController.m
//  Demo-iOS
//
//  Created by William Towe on 4/9/18.
//  Copyright © 2018 Kosoku Interactive, LLC. All rights reserved.
//
//  Redistribution and use in source and binary forms, with or without modification, are permitted provided that the following conditions are met:
//
//  1. Redistributions of source code must retain the above copyright notice, this list of conditions and the following disclaimer.
//
//  2. Redistributions in binary form must reproduce the above copyright notice, this list of conditions and the following disclaimer in the documentation and/or other materials provided with the distribution.
//
//  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

#import "ViewController.h"
#import "UIViewController+Extensions.h"
#import "UISegmentedControl+Extensions.h"

#import <Ditko/Ditko.h>
#import <Stanley/Stanley.h>

@interface ViewController ()
@property (weak,nonatomic) IBOutlet KDIView *borderView;
@property (weak,nonatomic) IBOutlet KDITextField *borderColorTextField;
@property (weak,nonatomic) IBOutlet UISegmentedControl *borderOptionsSegmentedControl;
@property (weak,nonatomic) IBOutlet UIStepper *borderWidthStepper;
@property (weak,nonatomic) IBOutlet UILabel *borderWidthLabel;
@property (weak,nonatomic) IBOutlet UISwitch *respectScreenScaleSwitch;
@property (weak,nonatomic) IBOutlet KDITextField *topTextField;
@property (weak,nonatomic) IBOutlet KDITextField *leftTextField;
@property (weak,nonatomic) IBOutlet KDITextField *bottomTextField;
@property (weak,nonatomic) IBOutlet KDITextField *rightTextField;
@end

@implementation ViewController

- (NSString *)title {
    return [self.class detailViewTitle];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    kstWeakify(self);
    
    [self KSO_addNavigationBarTitleView];
    
    void(^updateBorderWidthBlock)(double) = ^(double width){
        kstStrongify(self);
        self.borderView.borderWidth = width;
        self.borderWidthLabel.text = [NSString stringWithFormat:@"Width: %@",[NSNumberFormatter localizedStringFromNumber:@(width) numberStyle:NSNumberFormatterDecimalStyle]];
    };
    
    self.borderView.borderOptions = KDIBorderOptionsAll;
    self.borderView.borderColor = KDIColorRandomRGB();
    updateBorderWidthBlock(5.0);
    
    self.borderWidthStepper.value = self.borderView.borderWidth;
    
    self.borderColorTextField.text = [self.borderView.borderColor KDI_hexadecimalString];
    
    [self.borderColorTextField KDI_addBlock:^(__kindof UIControl * _Nonnull control, UIControlEvents controlEvents) {
        kstStrongify(self);
        self.borderView.borderColor = KDIColorHexadecimal(self.borderColorTextField.text);
    } forControlEvents:UIControlEventEditingChanged];
    
    [self.borderOptionsSegmentedControl KSO_configureForBorderedViews:@[self.borderView]];
    
    [self.borderWidthStepper KDI_addBlock:^(__kindof UIControl * _Nonnull control, UIControlEvents controlEvents) {
        kstStrongify(self);
        updateBorderWidthBlock(self.borderWidthStepper.value);
    } forControlEvents:UIControlEventValueChanged];
    
    [self.respectScreenScaleSwitch KDI_addBlock:^(__kindof UIControl * _Nonnull control, UIControlEvents controlEvents) {
        kstStrongify(self);
        self.borderView.borderWidthRespectsScreenScale = self.respectScreenScaleSwitch.isOn;
    } forControlEvents:UIControlEventValueChanged];
    
    [self.topTextField KDI_addBlock:^(__kindof UIControl * _Nonnull control, UIControlEvents controlEvents) {
        kstStrongify(self);
        UIEdgeInsets edgeInsets = self.borderView.borderEdgeInsets;
        
        edgeInsets.top = self.topTextField.text.doubleValue;
        
        self.borderView.borderEdgeInsets = edgeInsets;
    } forControlEvents:UIControlEventEditingChanged];
    
    [self.leftTextField KDI_addBlock:^(__kindof UIControl * _Nonnull control, UIControlEvents controlEvents) {
        kstStrongify(self);
        UIEdgeInsets edgeInsets = self.borderView.borderEdgeInsets;
        
        edgeInsets.left = self.leftTextField.text.doubleValue;
        
        self.borderView.borderEdgeInsets = edgeInsets;
    } forControlEvents:UIControlEventEditingChanged];
    
    [self.bottomTextField KDI_addBlock:^(__kindof UIControl * _Nonnull control, UIControlEvents controlEvents) {
        kstStrongify(self);
        UIEdgeInsets edgeInsets = self.borderView.borderEdgeInsets;
        
        edgeInsets.bottom = self.bottomTextField.text.doubleValue;
        
        self.borderView.borderEdgeInsets = edgeInsets;
    } forControlEvents:UIControlEventEditingChanged];
    
    [self.rightTextField KDI_addBlock:^(__kindof UIControl * _Nonnull control, UIControlEvents controlEvents) {
        kstStrongify(self);
        UIEdgeInsets edgeInsets = self.borderView.borderEdgeInsets;
        
        edgeInsets.right = self.rightTextField.text.doubleValue;
        
        self.borderView.borderEdgeInsets = edgeInsets;
    } forControlEvents:UIControlEventEditingChanged];
}
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    [self.borderColorTextField becomeFirstResponder];
}

+ (NSString *)detailViewTitle {
    return @"KDIView";
}
+ (NSString *)detailViewSubtitle {
    return @"UIView subclass with borders";
}

@end
