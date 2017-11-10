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
#import <KSOFontAwesomeExtensions/KSOFontAwesomeExtensions.h>

@interface CustomInputAccessoryView : KDINextPreviousInputAccessoryView

@end

@implementation CustomInputAccessoryView
- (instancetype)initWithFrame:(CGRect)frame responder:(UIResponder *)responder {
    if (!(self = [super initWithFrame:frame responder:responder]))
        return nil;
    
    [self setToolbarItems:@[self.previousItem,
                            self.nextItem,
                            [UIBarButtonItem KDI_flexibleSpaceBarButtonItem],
                            [[UIBarButtonItem alloc] initWithTitle:@"Select All" style:UIBarButtonItemStylePlain target:self action:@selector(_editItemAction:)],
                            self.doneItem]];
    
    return self;
}

- (IBAction)_editItemAction:(id)sender {
    [self.responder selectAll:nil];
}
@end

@interface TextViewController ()
@property (weak,nonatomic) IBOutlet KDITextView *textView;
@property (weak,nonatomic) IBOutlet KDITextField *textField;
@property (weak,nonatomic) IBOutlet UITextField *titleTextField;
@property (weak,nonatomic) IBOutlet UITextField *subtitleTextField;
@end

@implementation TextViewController

- (NSString *)title {
    return @"Text";
}

- (BOOL)automaticallyAdjustsScrollViewInsets {
    return NO;
}

- (instancetype)init {
    if (!(self = [super init]))
        return nil;
    
    [self setTabBarItem:[[UITabBarItem alloc] initWithTitle:self.title image:[[UIImage KSO_fontAwesomeImageWithIcon:(KSOFontAwesomeIcon)arc4random_uniform((uint32_t)KSO_FONT_AWESOME_ICON_TOTAL_ICONS) size:CGSizeMake(25, 25)] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate] tag:0]];
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    kstWeakify(self);
    
    [self.view setBackgroundColor:UIColor.lightGrayColor];
    
    [self.textView setBackgroundColor:KDIColorRandomRGB()];
    [self.textView setTintColor:UIColor.blackColor];
    [self.textView setTextContainerInset:UIEdgeInsetsMake(8, 8, 8, 8)];
    [self.textView setInputAccessoryView:[[CustomInputAccessoryView alloc] initWithFrame:CGRectZero responder:self.textView]];
    [self.textView setMaximumNumberOfLines:4];
    [self.textView setPlaceholder:@"Text view placeholder…"];
    [self.textView setBorderOptions:KDIBorderOptionsAll];
    [self.textView setBorderWidthRespectsScreenScale:YES];
    [self.textView setBorderColor:KDIColorRandomRGB()];
    
    [self.textField setBackgroundColor:KDIColorRandomRGB()];
    [self.textField setTintColor:UIColor.blackColor];
    [self.textField setPlaceholder:@"Text field placeholder…"];
    [self.textField setInputAccessoryView:[[CustomInputAccessoryView alloc] initWithFrame:CGRectZero responder:self.textField]];
    [self.textField setTextEdgeInsets:UIEdgeInsetsMake(8, 8, 8, 8)];
    [self.textField setBorderOptions:KDIBorderOptionsAll];
    [self.textField setBorderWidthRespectsScreenScale:YES];
    [self.textField setBorderColor:KDIColorRandomRGB()];
    
    [self.titleTextField setTintColor:nil];
    [self.titleTextField setText:self.title];
    [self.titleTextField setInputAccessoryView:[[CustomInputAccessoryView alloc] initWithFrame:CGRectZero responder:self.titleTextField]];
    [self.titleTextField KDI_addBlock:^(__kindof UIControl * _Nonnull control, UIControlEvents controlEvents) {
        kstStrongify(self);
        ((KDINavigationBarTitleView *)self.navigationItem.titleView).title = self.titleTextField.text;
    } forControlEvents:UIControlEventEditingChanged];
    
    [self.subtitleTextField setTintColor:nil];
    [self.subtitleTextField setInputAccessoryView:[[CustomInputAccessoryView alloc] initWithFrame:CGRectZero responder:self.subtitleTextField]];
    [self.subtitleTextField KDI_addBlock:^(__kindof UIControl * _Nonnull control, UIControlEvents controlEvents) {
        kstStrongify(self);
        ((KDINavigationBarTitleView *)self.navigationItem.titleView).subtitle = self.subtitleTextField.text;
    } forControlEvents:UIControlEventEditingChanged];
    
    UIButton *infoButton = [UIButton buttonWithType:UIButtonTypeInfoDark];
    
    [infoButton setTintColor:UIColor.blackColor];
    [infoButton sizeToFit];
    [self.textField setLeftView:infoButton];
    [self.textField setLeftViewMode:UITextFieldViewModeAlways];
    [self.textField setLeftViewEdgeInsets:UIEdgeInsetsMake(0, 8, 0, 0)];
    
    UIButton *rightButton = [UIButton buttonWithType:UIButtonTypeSystem];
    
    [rightButton setTintColor:UIColor.blackColor];
    [rightButton setImage:[[UIImage KSO_fontAwesomeImageWithIcon:KSOFontAwesomeIconBeer size:CGSizeMake(48, 48)] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate] forState:UIControlStateNormal];
    [rightButton sizeToFit];
    [self.textField setRightView:rightButton];
    [self.textField setRightViewMode:UITextFieldViewModeAlways];
    [self.textField setRightViewEdgeInsets:UIEdgeInsetsMake(8, 0, 8, 8)];
    
    UISwitch *switchControl = [[UISwitch alloc] initWithFrame:CGRectZero];
    
    [switchControl setOn:self.textView.borderWidthRespectsScreenScale];
    [switchControl KDI_addBlock:^(__kindof UIControl * _Nonnull control, UIControlEvents controlEvents) {
        kstStrongify(self);
        [self.textField setBorderWidthRespectsScreenScale:switchControl.isOn];
        [self.textView setBorderWidthRespectsScreenScale:switchControl.isOn];
    } forControlEvents:UIControlEventValueChanged];
    [switchControl sizeToFit];
    
    [self.navigationItem setLeftBarButtonItems:@[[[UIBarButtonItem alloc] initWithCustomView:switchControl]]];
    
    [self.navigationItem setRightBarButtonItems:@[[UIBarButtonItem KDI_barButtonItemWithTitle:@"Color" style:UIBarButtonItemStylePlain block:^(__kindof UIBarButtonItem * _Nonnull barButtonItem) {
        kstStrongify(self);
        [self.textField setBorderColor:KDIColorRandomRGB() animated:YES];
        [self.textView setBorderColor:KDIColorRandomRGB() animated:YES];
    }],[UIBarButtonItem KDI_barButtonItemWithTitle:@"Insets" style:UIBarButtonItemStylePlain block:^(__kindof UIBarButtonItem * _Nonnull barButtonItem) {
        kstStrongify(self);
        uint32_t max = 11;
        CGFloat top = arc4random_uniform(max), left = arc4random_uniform(max), bottom = arc4random_uniform(max), right = arc4random_uniform(max);
        UIEdgeInsets insets = UIEdgeInsetsMake(top, left, bottom, right);
        
        KSTLog(@"setting borderEdgeInsets to %@",NSStringFromUIEdgeInsets(UIEdgeInsetsMake(top, left, bottom, right)));
        
        [self.textField setBorderEdgeInsets:insets];
        [self.textView setBorderEdgeInsets:insets];
    }],[UIBarButtonItem KDI_barButtonItemWithTitle:@"Width" style:UIBarButtonItemStylePlain block:^(__kindof UIBarButtonItem * _Nonnull barButtonItem) {
        kstStrongify(self);
        CGFloat width = arc4random_uniform(6);
        
        KSTLog(@"setting borderWidth to %@",@(width));
        
        [self.textField setBorderWidth:width];
        [self.textView setBorderWidth:width];
    }]]];
    
    [self KDI_registerForNextPreviousNotificationsWithResponders:@[self.textView,self.textField,self.titleTextField,self.subtitleTextField]];
    
    [NSNotificationCenter.defaultCenter addObserver:self selector:@selector(_firstResponderDidChange:) name:KDIUIResponderNotificationDidBecomeFirstResponder object:nil];
    [NSNotificationCenter.defaultCenter addObserver:self selector:@selector(_firstResponderDidChange:) name:KDIUIResponderNotificationDidResignFirstResponder object:nil];
    
    KDINavigationBarTitleView *titleView = [[KDINavigationBarTitleView alloc] initWithFrame:CGRectZero];
    
    titleView.title = self.title;
    
    [self.navigationItem setTitleView:titleView];
}
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    [self.textView becomeFirstResponder];
}

- (void)_firstResponderDidChange:(NSNotification *)note {
    [self.textView setBackgroundColor:self.textView.isFirstResponder ? UIColor.whiteColor : KDIColorRandomRGB()];
    [self.textField setBackgroundColor:self.textField.isFirstResponder ? UIColor.whiteColor : KDIColorRandomRGB()];
}

@end
