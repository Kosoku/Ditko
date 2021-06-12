//
//  BadgeButtonViewController.m
//  Demo-iOS
//
//  Created by William Towe on 4/10/18.
//  Copyright © 2021 Kosoku Interactive, LLC. All rights reserved.
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

#import "BadgeButtonViewController.h"
#import "UIBarButtonItem+KDIExtensions.h"
#import "Constants.h"
#import "UIViewController+Extensions.h"

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
    
    [self KSO_addNavigationBarTitleView];
    
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
