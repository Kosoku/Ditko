//
//  ButtonViewController.m
//  Ditko
//
//  Created by William Towe on 8/29/17.
//  Copyright © 2017 Kosoku Interactive, LLC. All rights reserved.
//

#import "ButtonViewController.h"

#import <Ditko/Ditko.h>
#import <Stanley/Stanley.h>
#import <KSOFontAwesomeExtensions/KSOFontAwesomeExtensions.h>

typedef NS_ENUM(NSInteger, SubviewTag) {
    SubviewTagTitle,
    SubviewTagImage
};

@interface ButtonViewController ()
@property (weak,nonatomic) IBOutlet UISegmentedControl *titleVerticalSegmentedControl;
@property (weak,nonatomic) IBOutlet UISegmentedControl *titleHorizontalSegmentedControl;
@property (weak,nonatomic) IBOutlet UISegmentedControl *imageVerticalSegmentedControl;
@property (weak,nonatomic) IBOutlet UISegmentedControl *imageHorizontalSegmentedControl;
@property (weak,nonatomic) IBOutlet UISegmentedControl *badgeSegmentedControl;
@property (weak,nonatomic) IBOutlet KDIButton *button;
@property (weak,nonatomic) IBOutlet KDIBadgeButton *badgeButton;
@end

@implementation ButtonViewController

- (NSString *)title {
    return @"Buttons";
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    kstWeakify(self);
    
    [self.titleVerticalSegmentedControl KDI_addBlock:^(__kindof UIControl * _Nonnull control, UIControlEvents controlEvents) {
        kstStrongify(self);
        [self.button setTitleContentVerticalAlignment:[(UISegmentedControl *)control selectedSegmentIndex]];
        [self.badgeButton.button setTitleContentVerticalAlignment:[(UISegmentedControl *)control selectedSegmentIndex]];
    } forControlEvents:UIControlEventValueChanged];
    
    [self.titleHorizontalSegmentedControl KDI_addBlock:^(__kindof UIControl * _Nonnull control, UIControlEvents controlEvents) {
        kstStrongify(self);
        [self.button setTitleContentHorizontalAlignment:[(UISegmentedControl *)control selectedSegmentIndex]];
        [self.badgeButton.button setTitleContentHorizontalAlignment:[(UISegmentedControl *)control selectedSegmentIndex]];
    } forControlEvents:UIControlEventValueChanged];
    
    [self.imageVerticalSegmentedControl KDI_addBlock:^(__kindof UIControl * _Nonnull control, UIControlEvents controlEvents) {
        kstStrongify(self);
        [self.button setImageContentVerticalAlignment:[(UISegmentedControl *)control selectedSegmentIndex]];
        [self.badgeButton.button setImageContentVerticalAlignment:[(UISegmentedControl *)control selectedSegmentIndex]];
    } forControlEvents:UIControlEventValueChanged];
    
    [self.imageHorizontalSegmentedControl KDI_addBlock:^(__kindof UIControl * _Nonnull control, UIControlEvents controlEvents) {
        kstStrongify(self);
        [self.button setImageContentHorizontalAlignment:[(UISegmentedControl *)control selectedSegmentIndex]];
        [self.badgeButton.button setImageContentHorizontalAlignment:[(UISegmentedControl *)control selectedSegmentIndex]];
    } forControlEvents:UIControlEventValueChanged];
    
    [self.badgeSegmentedControl KDI_addBlock:^(__kindof UIControl * _Nonnull control, UIControlEvents controlEvents) {
        kstStrongify(self);
        KDIBadgeButtonBadgePosition position = KDIBadgeButtonBadgePositionRelativeToBounds;
        
        switch (self.badgeSegmentedControl.selectedSegmentIndex) {
            case 0:
                break;
            case 1:
                position = KDIBadgeButtonBadgePositionRelativeToImage;
                break;
            case 2:
                position = KDIBadgeButtonBadgePositionRelativeToTitle;
                break;
            default:
                break;
        }
        
        [self.badgeButton setBadgePosition:position];
    } forControlEvents:UIControlEventValueChanged];
    
    [self.button setBorderOptions:KDIBorderOptionsAll];
    [self.button setBorderColor:KDIColorRandomRGB()];
    [self.button setContentEdgeInsets:UIEdgeInsetsMake(8, 8, 8, 8)];
    [self.button setTitleEdgeInsets:UIEdgeInsetsMake(8, 8, 8, 8)];
    [self.button setImageEdgeInsets:UIEdgeInsetsMake(8, 8, 8, 8)];
    [self.button setImage:[[UIImage KSO_fontAwesomeImageWithIcon:KSOFontAwesomeIconBug size:CGSizeMake(32, 32)] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate] forState:UIControlStateNormal];
    [self.button setTitle:@"button title that is really long and will truncate if the screen is not wide enough" forState:UIControlStateNormal];
    
    void(^setBadgeBlock)(void) = ^{
        kstStrongify(self);
        [self.badgeButton.badgeView setBadge:[NSNumberFormatter localizedStringFromNumber:@(arc4random_uniform(1001)) numberStyle:NSNumberFormatterDecimalStyle]];
    };
    
    [self.badgeButton.button setBorderOptions:KDIBorderOptionsAll];
    [self.badgeButton.button setBorderColor:KDIColorRandomRGB()];
    [self.badgeButton.button setContentEdgeInsets:UIEdgeInsetsMake(8, 8, 8, 8)];
    [self.badgeButton.button setTitleEdgeInsets:UIEdgeInsetsMake(8, 8, 8, 8)];
    [self.badgeButton.button setImageEdgeInsets:UIEdgeInsetsMake(8, 8, 8, 8)];
    [self.badgeButton.button setImage:[[UIImage KSO_fontAwesomeImageWithIcon:KSOFontAwesomeIconBus size:CGSizeMake(48, 48)] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate] forState:UIControlStateNormal];
    [self.badgeButton.button setTitle:@"button title that is really long and will truncate if the screen is not wide enough" forState:UIControlStateNormal];
    [self.badgeButton.button KDI_addBlock:^(__kindof UIControl * _Nonnull control, UIControlEvents controlEvents) {
        setBadgeBlock();
    } forControlEvents:UIControlEventTouchUpInside];
    
    setBadgeBlock();
}

@end
