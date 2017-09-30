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
@property (weak,nonatomic) IBOutlet KDIButton *systemButton;
@property (strong,nonatomic) IBOutletCollection(KDILabel) NSArray *labels;
@end

@implementation ButtonViewController

- (NSString *)title {
    return @"Buttons";
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
    
    UIColor *tintColor = UIApplication.sharedApplication.delegate.window.tintColor;
    UIColor *backgroundColor = [tintColor KDI_contrastingColor];
    
    [self.view setBackgroundColor:backgroundColor];
    
    [self.navigationItem setRightBarButtonItems:@[[UIBarButtonItem KDI_barButtonSystemItem:UIBarButtonSystemItemRefresh block:^(__kindof UIBarButtonItem * _Nonnull barButtonItem) {
        kstStrongify(self);
        [self.view setTintColor:KDIColorRandomRGB()];
    }]]];
    
    for (KDILabel *label in self.labels) {
        [label setBorderColor:KDIColorRandomRGB()];
        [label setBorderWidthRespectsScreenScale:YES];
        [label setBorderOptions:KDIBorderOptionsBottom];
        [label setEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 8)];
        [label setCopyable:YES];
        [label setTextColor:tintColor];
    }
    
    [self.titleVerticalSegmentedControl KDI_addBlock:^(__kindof UIControl * _Nonnull control, UIControlEvents controlEvents) {
        kstStrongify(self);
        [self.button setTitleContentVerticalAlignment:[(UISegmentedControl *)control selectedSegmentIndex]];
        [self.systemButton setTitleContentVerticalAlignment:[(UISegmentedControl *)control selectedSegmentIndex]];
        [self.badgeButton.button setTitleContentVerticalAlignment:[(UISegmentedControl *)control selectedSegmentIndex]];
    } forControlEvents:UIControlEventValueChanged];
    
    [self.titleHorizontalSegmentedControl KDI_addBlock:^(__kindof UIControl * _Nonnull control, UIControlEvents controlEvents) {
        kstStrongify(self);
        [self.button setTitleContentHorizontalAlignment:[(UISegmentedControl *)control selectedSegmentIndex]];
        [self.systemButton setTitleContentHorizontalAlignment:[(UISegmentedControl *)control selectedSegmentIndex]];
        [self.badgeButton.button setTitleContentHorizontalAlignment:[(UISegmentedControl *)control selectedSegmentIndex]];
    } forControlEvents:UIControlEventValueChanged];
    
    [self.imageVerticalSegmentedControl KDI_addBlock:^(__kindof UIControl * _Nonnull control, UIControlEvents controlEvents) {
        kstStrongify(self);
        [self.button setImageContentVerticalAlignment:[(UISegmentedControl *)control selectedSegmentIndex]];
        [self.systemButton setImageContentVerticalAlignment:[(UISegmentedControl *)control selectedSegmentIndex]];
        [self.badgeButton.button setImageContentVerticalAlignment:[(UISegmentedControl *)control selectedSegmentIndex]];
    } forControlEvents:UIControlEventValueChanged];
    
    [self.imageHorizontalSegmentedControl KDI_addBlock:^(__kindof UIControl * _Nonnull control, UIControlEvents controlEvents) {
        kstStrongify(self);
        [self.button setImageContentHorizontalAlignment:[(UISegmentedControl *)control selectedSegmentIndex]];
        [self.systemButton setImageContentHorizontalAlignment:[(UISegmentedControl *)control selectedSegmentIndex]];
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
    
    [self.badgeButton setBackgroundColor:backgroundColor];
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
    
    [self.systemButton setKDI_cornerRadius:5.0];
    [self.systemButton setContentEdgeInsets:UIEdgeInsetsMake(8, 8, 8, 8)];
    [self.systemButton setTitleEdgeInsets:UIEdgeInsetsMake(8, 8, 8, 8)];
    [self.systemButton setImageEdgeInsets:UIEdgeInsetsMake(8, 8, 8, 8)];
    [self.systemButton setRounded:YES];
    [self.systemButton setImage:[[UIImage KSO_fontAwesomeImageWithIcon:KSOFontAwesomeIconBook size:CGSizeMake(25, 25)] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate] forState:UIControlStateNormal];
    [self.systemButton KDI_addBlock:^(__kindof UIControl * _Nonnull control, UIControlEvents controlEvents) {
        [(KDIButton *)control setInverted:![(KDIButton *)control isInverted]];
    } forControlEvents:UIControlEventTouchUpInside];
    
    setBadgeBlock();
    
    [NSObject KDI_registerDynamicTypeObjectsForTextStyles:@{UIFontTextStyleBody: self.labels,
                                                            UIFontTextStyleFootnote: @[self.titleVerticalSegmentedControl,self.titleHorizontalSegmentedControl,self.imageVerticalSegmentedControl,self.imageHorizontalSegmentedControl,self.badgeSegmentedControl,self.button.titleLabel,self.badgeButton.button.titleLabel,self.systemButton.titleLabel]
                                                            }];
}

@end
