//
//  TextViewController.m
//  Ditko
//
//  Created by William Towe on 8/27/17.
//  Copyright © 2017 Kosoku Interactive, LLC. All rights reserved.
//
//  Redistribution and use in source and binary forms, with or without modification, are permitted provided that the following conditions are met:
//
//  1. Redistributions of source code must retain the above copyright notice, this list of conditions and the following disclaimer.
//
//  2. Redistributions in binary form must reproduce the above copyright notice, this list of conditions and the following disclaimer in the documentation and/or other materials provided with the distribution.
//
//  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

#import "TextViewController.h"

#import <Ditko/Ditko.h>
#import <Stanley/Stanley.h>

@interface TextViewController ()
@property (weak,nonatomic) IBOutlet KDITextView *textView;
@property (weak,nonatomic) IBOutlet KDITextField *textField;
@end

@implementation TextViewController

- (NSString *)title {
    return @"Text";
}

- (BOOL)automaticallyAdjustsScrollViewInsets {
    return NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    kstWeakify(self);
    
    [self.view setBackgroundColor:UIColor.lightGrayColor];
    
    [self.textView setScrollEnabled:NO];
    [self.textView setBackgroundColor:UIColor.whiteColor];
    [self.textView setPlaceholder:@"Text view placeholder…"];
    
    [self.textField setBackgroundColor:UIColor.whiteColor];
    [self.textField setPlaceholder:@"Text field placeholder…"];
    [self.textField setBorderOptions:KDITextFieldBorderOptionsAll];
    [self.textField setBorderColor:KDIColorRandomRGB()];
    
    UISwitch *switchControl = [[UISwitch alloc] initWithFrame:CGRectZero];
    
    [switchControl setOn:NO];
    [switchControl KDI_addBlock:^(__kindof UIControl * _Nonnull control, UIControlEvents controlEvents) {
        kstStrongify(self);
        [self.textField setBorderWidthRespectsScreenScale:switchControl.isOn];
    } forControlEvents:UIControlEventValueChanged];
    [switchControl sizeToFit];
    
    [self.navigationItem setLeftBarButtonItems:@[[[UIBarButtonItem alloc] initWithCustomView:switchControl]]];
    
    [self.navigationItem setRightBarButtonItems:@[[UIBarButtonItem KDI_barButtonItemWithTitle:@"Color" style:UIBarButtonItemStylePlain block:^(__kindof UIBarButtonItem * _Nonnull barButtonItem) {
        kstStrongify(self);
        [self.textField setBorderColor:KDIColorRandomRGB()];
    }],[UIBarButtonItem KDI_barButtonItemWithTitle:@"Insets" style:UIBarButtonItemStylePlain block:^(__kindof UIBarButtonItem * _Nonnull barButtonItem) {
        kstStrongify(self);
        uint32_t max = 11;
        CGFloat top = arc4random_uniform(max), left = arc4random_uniform(max), bottom = arc4random_uniform(max), right = arc4random_uniform(max);
        UIEdgeInsets insets = UIEdgeInsetsMake(top, left, bottom, right);
        
        KSTLog(@"setting borderEdgeInsets to %@",NSStringFromUIEdgeInsets(UIEdgeInsetsMake(top, left, bottom, right)));
        
        [self.textField setBorderEdgeInsets:insets];
        
        
    }],[UIBarButtonItem KDI_barButtonItemWithTitle:@"Width" style:UIBarButtonItemStylePlain block:^(__kindof UIBarButtonItem * _Nonnull barButtonItem) {
        kstStrongify(self);
        CGFloat width = arc4random_uniform(6);
        
        KSTLog(@"setting borderWidth to %@",@(width));
        
        [self.textField setBorderWidth:width];
    }]]];
}
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    [self.textView becomeFirstResponder];
}

@end
