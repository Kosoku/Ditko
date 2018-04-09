//
//  BadgeViewController.m
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

#import "BadgeViewController.h"
#import "UIViewController+Extensions.h"

#import <Ditko/Ditko.h>
#import <Stanley/Stanley.h>

@interface BadgeViewController ()
@property (weak,nonatomic) IBOutlet KDIBadgeView *badgeView;
@property (weak,nonatomic) IBOutlet KDITextField *foregroundColorTextField;
@property (weak,nonatomic) IBOutlet KDITextField *backgroundColorTextField;
@property (weak,nonatomic) IBOutlet KDITextField *badgeTextField;
@property (weak,nonatomic) IBOutlet KDITextField *cornerRadiusTextField;
@property (weak,nonatomic) IBOutlet KDITextField *topTextField;
@property (weak,nonatomic) IBOutlet KDITextField *leftTextField;
@property (weak,nonatomic) IBOutlet KDITextField *bottomTextField;
@property (weak,nonatomic) IBOutlet KDITextField *rightTextField;
@end

@implementation BadgeViewController

- (NSString *)title {
    return [self.class detailViewTitle];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    kstWeakify(self);
    
    [self KSO_addNavigationBarTitleView];
    
    self.badgeView.badge = @"Badged!";
    self.badgeView.badgeBackgroundColor = KDIColorRandomRGB();
    self.badgeView.badgeForegroundColor = [self.badgeView.badgeBackgroundColor KDI_contrastingColor];
    
    self.badgeTextField.text = self.badgeView.badge;
    
    self.foregroundColorTextField.text = [self.badgeView.badgeForegroundColor KDI_hexadecimalString];
    
    self.backgroundColorTextField.text = [self.badgeView.badgeBackgroundColor KDI_hexadecimalString];
    
    [self.foregroundColorTextField KDI_addBlock:^(__kindof UIControl * _Nonnull control, UIControlEvents controlEvents) {
        kstStrongify(self);
        self.badgeView.badgeForegroundColor = KDIColorHexadecimal(self.foregroundColorTextField.text);
    } forControlEvents:UIControlEventEditingChanged];
    
    [self.backgroundColorTextField KDI_addBlock:^(__kindof UIControl * _Nonnull control, UIControlEvents controlEvents) {
        kstStrongify(self);
        self.badgeView.badgeBackgroundColor = KDIColorHexadecimal(self.backgroundColorTextField.text);
    } forControlEvents:UIControlEventEditingChanged];
    
    [self.badgeTextField KDI_addBlock:^(__kindof UIControl * _Nonnull control, UIControlEvents controlEvents) {
        kstStrongify(self);
        self.badgeView.badge = self.badgeTextField.text;
    } forControlEvents:UIControlEventEditingChanged];
    
    [self.cornerRadiusTextField KDI_addBlock:^(__kindof UIControl * _Nonnull control, UIControlEvents controlEvents) {
        kstStrongify(self);
        self.badgeView.badgeCornerRadius = self.cornerRadiusTextField.text.doubleValue;
    } forControlEvents:UIControlEventEditingChanged];
    
    [self.topTextField KDI_addBlock:^(__kindof UIControl * _Nonnull control, UIControlEvents controlEvents) {
        kstStrongify(self);
        UIEdgeInsets edgeInsets = self.badgeView.badgeEdgeInsets;
        
        edgeInsets.top = self.topTextField.text.doubleValue;
        
        self.badgeView.badgeEdgeInsets = edgeInsets;
    } forControlEvents:UIControlEventEditingChanged];
    
    [self.leftTextField KDI_addBlock:^(__kindof UIControl * _Nonnull control, UIControlEvents controlEvents) {
        kstStrongify(self);
        UIEdgeInsets edgeInsets = self.badgeView.badgeEdgeInsets;
        
        edgeInsets.left = self.leftTextField.text.doubleValue;
        
        self.badgeView.badgeEdgeInsets = edgeInsets;
    } forControlEvents:UIControlEventEditingChanged];
    
    [self.bottomTextField KDI_addBlock:^(__kindof UIControl * _Nonnull control, UIControlEvents controlEvents) {
        kstStrongify(self);
        UIEdgeInsets edgeInsets = self.badgeView.badgeEdgeInsets;
        
        edgeInsets.bottom = self.bottomTextField.text.doubleValue;
        
        self.badgeView.badgeEdgeInsets = edgeInsets;
    } forControlEvents:UIControlEventEditingChanged];
    
    [self.rightTextField KDI_addBlock:^(__kindof UIControl * _Nonnull control, UIControlEvents controlEvents) {
        kstStrongify(self);
        UIEdgeInsets edgeInsets = self.badgeView.badgeEdgeInsets;
        
        edgeInsets.right = self.rightTextField.text.doubleValue;
        
        self.badgeView.badgeEdgeInsets = edgeInsets;
    } forControlEvents:UIControlEventEditingChanged];
}

+ (NSString *)detailViewTitle {
    return @"KDIBadgeView";
}
+ (NSString *)detailViewSubtitle {
    return @"UIView subclass providing badging";
}

@end
