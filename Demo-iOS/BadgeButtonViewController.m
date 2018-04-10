//
//  BadgeButtonViewController.m
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

#import "BadgeButtonViewController.h"
#import "UIBarButtonItem+KDIExtensions.h"
#import "Constants.h"

#import <Ditko/Ditko.h>
#import <Stanley/Stanley.h>
#import <KSOFontAwesomeExtensions/KSOFontAwesomeExtensions.h>

@interface BadgeButtonViewController ()
@property (weak,nonatomic) IBOutlet KDIBadgeButton *badgeButton;
@property (strong,nonatomic) KDIBadgeButton *barButtonItemBadgeButton;
@end

@implementation BadgeButtonViewController

- (NSString *)title {
    return [self.class detailViewTitle];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    kstWeakify(self);
    
    void(^updateBadgesBlock)(void) = ^{
        kstStrongify(self);
        NSString *badge = [NSNumberFormatter localizedStringFromNumber:@(arc4random_uniform(999)) numberStyle:NSNumberFormatterDecimalStyle];
        
        self.badgeButton.badgeView.badge = badge;
        self.barButtonItemBadgeButton.badgeView.badge = badge;
    };
    
    self.badgeButton.badgePosition = KDIBadgeButtonBadgePositionRelativeToImage;
    self.badgeButton.button.titleContentVerticalAlignment = KDIButtonContentVerticalAlignmentBottom;
    self.badgeButton.button.imageContentVerticalAlignment = KDIButtonContentVerticalAlignmentTop;
    self.badgeButton.button.titleContentHorizontalAlignment = KDIButtonContentHorizontalAlignmentCenter;
    self.badgeButton.button.imageContentHorizontalAlignment = KDIButtonContentHorizontalAlignmentCenter;
    self.badgeButton.button.titleEdgeInsets = UIEdgeInsetsMake(kSubviewMargin, 0, 0, 0);
    [self.badgeButton.button setTitle:@"Badge Button!" forState:UIControlStateNormal];
    [self.badgeButton.button setImage:[UIImage KSO_fontAwesomeSolidImageWithString:@"\uf2b9" size:kButtonImageSize].KDI_templateImage forState:UIControlStateNormal];
    [self.badgeButton.button KDI_addBlock:^(__kindof UIControl * _Nonnull control, UIControlEvents controlEvents) {
        updateBadgesBlock();
    } forControlEvents:UIControlEventTouchUpInside];
    
    self.barButtonItemBadgeButton = [[KDIBadgeButton alloc] initWithFrame:CGRectZero];
    self.barButtonItemBadgeButton.translatesAutoresizingMaskIntoConstraints = NO;
    [self.barButtonItemBadgeButton.button setImage:[UIImage KSO_fontAwesomeSolidImageWithString:@"\uf2b9" size:kBarButtonItemImageSize].KDI_templateImage forState:UIControlStateNormal];
    [self.barButtonItemBadgeButton.button KDI_addBlock:^(__kindof UIControl * _Nonnull control, UIControlEvents controlEvents) {
        updateBadgesBlock();
    } forControlEvents:UIControlEventTouchUpInside];
    
    updateBadgesBlock();
    
    self.navigationItem.rightBarButtonItems = @[[[UIBarButtonItem alloc] initWithCustomView:self.barButtonItemBadgeButton]];
}

+ (NSString *)detailViewTitle {
    return @"KDIBadgeButton";
}
+ (NSString *)detailViewSubtitle {
    return @"UIView managing a button and badge";
}

@end
