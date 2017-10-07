//
//  ViewController.m
//  DitkoDemo-iOS
//
//  Created by William Towe on 3/8/17.
//  Copyright © 2017 Kosoku Interactive, LLC. All rights reserved.
//
//  Redistribution and use in source and binary forms, with or without modification, are permitted provided that the following conditions are met:
//
//  1. Redistributions of source code must retain the above copyright notice, this list of conditions and the following disclaimer.
//
//  2. Redistributions in binary form must reproduce the above copyright notice, this list of conditions and the following disclaimer in the documentation and/or other materials provided with the distribution.
//
//  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

#import "ViewController.h"
#import "PushViewController.h"
#import "UIBarButtonItem+DemoExtensions.h"

#import <Ditko/Ditko.h>
#import <Stanley/Stanley.h>
#import <Loki/Loki.h>
#import <KSOFontAwesomeExtensions/KSOFontAwesomeExtensions.h>

static NSArray<NSArray<NSString *> *> *kPickerViewButtonComponentsAndRows;

@interface ViewController () <KDIPickerViewButtonDataSource,KDIPickerViewButtonDelegate>
@property (strong,nonatomic) UIStackView *stackView;
@property (strong,nonatomic) UIScrollView *scrollView;
@end

@implementation ViewController

+ (void)initialize {
    if (self == [ViewController class]) {
        kPickerViewButtonComponentsAndRows = @[@[@"Dog",@"Cat",@"Fish"],@[@"Red",@"Green",@"Blue"]];
    }
}

- (NSString *)title {
    return @"Controls";
}

- (instancetype)init {
    if (!(self = [super init]))
        return nil;
    
    [self setTabBarItem:[[UITabBarItem alloc] initWithTitle:self.title image:[[UIImage KSO_fontAwesomeImageWithIcon:(KSOFontAwesomeIcon)arc4random_uniform((uint32_t)KSO_FONT_AWESOME_ICON_TOTAL_ICONS) size:CGSizeMake(25, 25)] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate] tag:0]];
    
    return self;
}

- (void)loadView {
    KDIView *view = [[KDIView alloc] initWithFrame:CGRectZero];
    
    [view setBackgroundColor:KDIColorRandomRGB()];
    [view setBorderColor:KDIColorRandomRGB()];
    [view setBorderWidth:4.0];
    [view setBorderOptions:KDIBorderOptionsAll];
    [view setBorderEdgeInsets:UIEdgeInsetsMake(8.0, 8.0, 8.0, 8.0)];
    
    [self setView:view];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    kstWeakify(self);
    
    UIColor *backgroundColor = [UIApplication.sharedApplication.delegate.window.tintColor KDI_contrastingColor];
    
    KDIGradientView *gradientView = [[KDIGradientView alloc] initWithFrame:CGRectZero];
    
    [gradientView setTranslatesAutoresizingMaskIntoConstraints:NO];
    [gradientView setColors:@[KDIColorRandomRGB(),KDIColorRandomRGB()]];
    
    [self.view addSubview:gradientView];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-margin-[view]-margin-|" options:0 metrics:@{@"margin": @16.0} views:@{@"view": gradientView}]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-margin-[view]-margin-|" options:0 metrics:@{@"margin": @16.0} views:@{@"view": gradientView}]];
    
    [self setScrollView:[[UIScrollView alloc] initWithFrame:CGRectZero]];
    [self.scrollView setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.scrollView setAlwaysBounceVertical:YES];
    
    [gradientView addSubview:self.scrollView];
    [NSLayoutConstraint activateConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[view]|" options:0 metrics:nil views:@{@"view": self.scrollView}]];
    [NSLayoutConstraint activateConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[view]|" options:0 metrics:nil views:@{@"view": self.scrollView}]];
    
    [self setStackView:[[UIStackView alloc] initWithFrame:CGRectZero]];
    [self.stackView setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.stackView setAxis:UILayoutConstraintAxisVertical];
    [self.stackView setAlignment:UIStackViewAlignmentLeading];
    [self.stackView setSpacing:8.0];
    
    [self.scrollView addSubview:self.stackView];
    [NSLayoutConstraint activateConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[view]|" options:0 metrics:nil views:@{@"view": self.stackView}]];
    [NSLayoutConstraint activateConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[view]|" options:0 metrics:nil views:@{@"view": self.stackView}]];
    
    KDIBadgeView *badgeView = [[KDIBadgeView alloc] initWithFrame:CGRectZero];
    
    [badgeView setBadge:@"1234"];
    [badgeView setBadgeForegroundColor:KDIColorRandomRGB()];
    [badgeView setBadgeBackgroundColor:[badgeView.badgeForegroundColor KDI_inverseColor]];
    [badgeView setTranslatesAutoresizingMaskIntoConstraints:NO];
    
    [self.stackView addArrangedSubview:badgeView];
    
    KDIButton *blockButton = [KDIButton buttonWithType:UIButtonTypeSystem];
    
    [blockButton setTranslatesAutoresizingMaskIntoConstraints:NO];
    [blockButton setBackgroundColor:KDIColorRandomRGB()];
    [blockButton setContentEdgeInsets:UIEdgeInsetsMake(8, 16, 8, 16)];
    [blockButton setImageEdgeInsets:UIEdgeInsetsMake(0, 4, 0, 0)];
    [blockButton setTitleEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 4)];
    [blockButton setTintColor:[blockButton.backgroundColor KDI_contrastingColor]];
    [blockButton setTitle:@"Action Sheet" forState:UIControlStateNormal];
    [blockButton setImage:[UIImage imageNamed:@"globe"] forState:UIControlStateNormal];
    [blockButton KDI_addBlock:^(__kindof UIControl * _Nonnull control, UIControlEvents controlEvents) {
        [blockButton setBackgroundColor:KDIColorRandomRGB()];
        [blockButton setTintColor:[blockButton.backgroundColor KDI_contrastingColor]];
        
        [UIAlertController KDI_presentAlertControllerWithOptions:@{KDIUIAlertControllerOptionsKeyStyle: @(UIAlertControllerStyleActionSheet), KDIUIAlertControllerOptionsKeyTitle: @"Title", KDIUIAlertControllerOptionsKeyMessage: @"This is an alert message", KDIUIAlertControllerOptionsKeyActions: @[@{KDIUIAlertControllerOptionsActionKeyTitle: @"Cancel", KDIUIAlertControllerOptionsActionKeyStyle: @(UIAlertActionStyleCancel)},@{KDIUIAlertControllerOptionsActionKeyTitle: @"Destroy!",KDIUIAlertControllerOptionsActionKeyStyle: @(UIAlertActionStyleDestructive)},@{KDIUIAlertControllerOptionsActionKeyTitle: @"Action",KDIUIAlertControllerOptionsActionKeyPreferred: @YES}]} completion:^(__kindof UIAlertController *alertController, NSInteger buttonIndex) {
            NSLog(@"%@",@(buttonIndex));
        }];
    } forControlEvents:UIControlEventTouchUpInside];
    [blockButton setTitleContentVerticalAlignment:KDIButtonContentVerticalAlignmentCenter];
    [blockButton setTitleContentHorizontalAlignment:KDIButtonContentHorizontalAlignmentLeft];
    [blockButton setImageContentVerticalAlignment:KDIButtonContentVerticalAlignmentCenter];
    [blockButton setImageContentHorizontalAlignment:KDIButtonContentHorizontalAlignmentRight];
    [blockButton setRounded:YES];
    
    [self.stackView addArrangedSubview:blockButton];
    
    KDIPickerViewButton *pickerViewButton = [KDIPickerViewButton buttonWithType:UIButtonTypeSystem];
    
    [pickerViewButton setTranslatesAutoresizingMaskIntoConstraints:NO];
    [pickerViewButton setBackgroundColor:backgroundColor];
    [pickerViewButton setContentEdgeInsets:UIEdgeInsetsMake(8, 16, 8, 16)];
    [pickerViewButton setTitleEdgeInsets:UIEdgeInsetsMake(0, 8, 0, 0)];
    [pickerViewButton setImage:[UIImage imageNamed:@"snake"] forState:UIControlStateNormal];
    [pickerViewButton setTitleContentVerticalAlignment:KDIButtonContentVerticalAlignmentCenter];
    [pickerViewButton setTitleContentHorizontalAlignment:KDIButtonContentHorizontalAlignmentRight];
    [pickerViewButton setImageContentVerticalAlignment:KDIButtonContentVerticalAlignmentCenter];
    [pickerViewButton setImageContentHorizontalAlignment:KDIButtonContentHorizontalAlignmentLeft];
    [pickerViewButton setRounded:YES];
    [pickerViewButton setDataSource:self];
    [pickerViewButton setDelegate:self];
    [pickerViewButton setSelectedComponentsJoinString:@", "];
    
    [self.stackView addArrangedSubview:pickerViewButton];
    
    KDIDatePickerButton *datePickerButton = [KDIDatePickerButton buttonWithType:UIButtonTypeSystem];
    
    [datePickerButton setTranslatesAutoresizingMaskIntoConstraints:NO];
    [datePickerButton setContentEdgeInsets:UIEdgeInsetsMake(8, 16, 8, 16)];
    [datePickerButton setTitleEdgeInsets:UIEdgeInsetsMake(0, 8, 0, 0)];
    [datePickerButton setImage:[[UIImage imageNamed:@"ticket"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate] forState:UIControlStateNormal];
    [datePickerButton setDateTitleBlock:^NSString * _Nullable(__kindof KDIDatePickerButton * _Nonnull datePickerButton, NSString * _Nonnull defaultTitle) {
        return [NSString stringWithFormat:@"Date: %@",defaultTitle];
    }];
    [datePickerButton setTitleContentVerticalAlignment:KDIButtonContentVerticalAlignmentCenter];
    [datePickerButton setTitleContentHorizontalAlignment:KDIButtonContentHorizontalAlignmentRight];
    [datePickerButton setImageContentVerticalAlignment:KDIButtonContentVerticalAlignmentCenter];
    [datePickerButton setImageContentHorizontalAlignment:KDIButtonContentHorizontalAlignmentLeft];
    [datePickerButton setRounded:YES];
    [datePickerButton setInverted:YES];
    
    [self.stackView addArrangedSubview:datePickerButton];
    
    KDIButton *centerButton = [KDIButton buttonWithType:UIButtonTypeSystem];
    
    [centerButton setTranslatesAutoresizingMaskIntoConstraints:NO];
    [centerButton setTintColor:KDIColorRandomRGB()];
    [centerButton setBackgroundColor:[centerButton.tintColor KDI_inverseColor]];
    [centerButton setContentEdgeInsets:UIEdgeInsetsMake(16, 16, 16, 16)];
    [centerButton setTitleEdgeInsets:UIEdgeInsetsMake(0, 0, 8, 0)];
    [centerButton setTitle:@"Alert" forState:UIControlStateNormal];
    [centerButton setImage:[UIImage imageNamed:@"ghost"] forState:UIControlStateNormal];
    [centerButton KDI_addBlock:^(__kindof UIControl * _Nonnull control, UIControlEvents controlEvents) {
        [centerButton setTintColor:KDIColorRandomRGB()];
        [centerButton setBackgroundColor:[centerButton.tintColor KDI_inverseColor]];
        
        [UIAlertController KDI_presentAlertControllerWithOptions:@{KDIUIAlertControllerOptionsKeyTitle: @"Title", KDIUIAlertControllerOptionsKeyMessage: @"This is an alert message", KDIUIAlertControllerOptionsKeyActions: @[@{KDIUIAlertControllerOptionsActionKeyTitle: @"Cancel", KDIUIAlertControllerOptionsActionKeyStyle: @(UIAlertActionStyleCancel)},@{KDIUIAlertControllerOptionsActionKeyTitle: @"Destroy!",KDIUIAlertControllerOptionsActionKeyStyle: @(UIAlertActionStyleDestructive)},@{KDIUIAlertControllerOptionsActionKeyTitle: @"Action",KDIUIAlertControllerOptionsActionKeyPreferred: @YES}], KDIUIAlertControllerOptionsKeyTextFieldConfigurationBlocks: @[^(UITextField *textField){textField.placeholder = @"All the #hashtags"; textField.keyboardType = UIKeyboardTypeTwitter;}]} completion:^(__kindof UIAlertController *alertController, NSInteger buttonIndex) {
            NSLog(@"%@ %@",@(buttonIndex),alertController.textFields.firstObject.text);
        }];
    } forControlEvents:UIControlEventTouchUpInside];
    [centerButton setTitleContentVerticalAlignment:KDIButtonContentVerticalAlignmentTop];
    [centerButton setTitleContentHorizontalAlignment:KDIButtonContentHorizontalAlignmentCenter];
    [centerButton setImageContentVerticalAlignment:KDIButtonContentVerticalAlignmentBottom];
    [centerButton setImageContentHorizontalAlignment:KDIButtonContentHorizontalAlignmentCenter];
    [centerButton setKDI_cornerRadius:5.0];
    
    [self.stackView addArrangedSubview:centerButton];
    
    KDIBadgeButton *badgeButton = [[KDIBadgeButton alloc] initWithFrame:CGRectZero];
    
    [badgeButton.button setImage:[UIImage KSO_fontAwesomeImageWithIcon:(KSOFontAwesomeIcon)arc4random_uniform((uint32_t)KSO_FONT_AWESOME_ICON_TOTAL_ICONS) size:CGSizeMake(25, 25)] forState:UIControlStateNormal];
    [badgeButton.badgeView setBadge:@"1"];
    [badgeButton.badgeView setBadgeBackgroundColor:KDIColorRandomRGB()];
    [badgeButton.badgeView setBadgeForegroundColor:[badgeButton.badgeView.badgeBackgroundColor KDI_contrastingColor]];
    [badgeButton sizeToFit];
    
    __block NSUInteger badgeButtonValue = 1;
    
    [badgeButton.button KDI_addBlock:^(__kindof UIControl * _Nonnull control, UIControlEvents controlEvents) {
        [badgeButton.button setImage:[UIImage KSO_fontAwesomeImageWithIcon:(KSOFontAwesomeIcon)arc4random_uniform((uint32_t)KSO_FONT_AWESOME_ICON_TOTAL_ICONS) size:CGSizeMake(25, 25)] forState:UIControlStateNormal];
        [badgeButton.badgeView setBadge:[NSNumberFormatter localizedStringFromNumber:@(++badgeButtonValue) numberStyle:NSNumberFormatterDecimalStyle]];
        [badgeButton.badgeView setBadgeBackgroundColor:KDIColorRandomRGB()];
        [badgeButton.badgeView setBadgeForegroundColor:[badgeButton.badgeView.badgeBackgroundColor KDI_contrastingColor]];
        [badgeButton sizeToFit];
    } forControlEvents:UIControlEventTouchUpInside];
    
    [self.navigationItem setRightBarButtonItems:@[[[UIBarButtonItem alloc] initWithCustomView:badgeButton]]];
    
    KDIButton *toggleButton = [KDIButton buttonWithType:UIButtonTypeSystem];
    
    [toggleButton setTranslatesAutoresizingMaskIntoConstraints:NO];
    [toggleButton setBackgroundColor:backgroundColor];
    [toggleButton setContentEdgeInsets:UIEdgeInsetsMake(8, 16, 8, 16)];
    [toggleButton setRounded:YES];
    [toggleButton setTitle:@"Show Progress" forState:UIControlStateNormal];
    [toggleButton KDI_addBlock:^(__kindof UIControl * _Nonnull control, UIControlEvents controlEvents) {
        BOOL progressHidden = !self.navigationController.KDI_progressNavigationBar.isProgressHidden;
        
        [self.navigationController.KDI_progressNavigationBar setProgressHidden:progressHidden animated:YES];
        
        [toggleButton setTitle:progressHidden ? @"Show Progress" : @"Hide Progress" forState:UIControlStateNormal];
    } forControlEvents:UIControlEventTouchUpInside];
    
    [self.stackView addArrangedSubview:toggleButton];
    
    UIStepper *stepper = [[UIStepper alloc] initWithFrame:CGRectZero];
    
    [stepper setTranslatesAutoresizingMaskIntoConstraints:NO];
    [stepper setStepValue:0.1];
    [stepper KDI_addBlock:^(__kindof UIControl * _Nonnull control, UIControlEvents controlEvents) {
        [self.navigationController.KDI_progressNavigationBar setProgress:stepper.value animated:YES];
    } forControlEvents:UIControlEventValueChanged];
    
    [self.stackView addArrangedSubview:stepper];
    
    KDIButton *pushViewControllerButton = [KDIButton buttonWithType:UIButtonTypeSystem];
    
    [pushViewControllerButton setTranslatesAutoresizingMaskIntoConstraints:NO];
    [pushViewControllerButton setBackgroundColor:backgroundColor];
    [pushViewControllerButton setTitle:@"Push VC" forState:UIControlStateNormal];
    [pushViewControllerButton setContentEdgeInsets:UIEdgeInsetsMake(8, 16, 8, 16)];
    [pushViewControllerButton setRounded:YES];
    [pushViewControllerButton KDI_addBlock:^(__kindof UIControl * _Nonnull control, UIControlEvents controlEvents) {
        [self.navigationController pushViewController:[[PushViewController alloc] init] animated:YES];
    } forControlEvents:UIControlEventTouchUpInside];
    
    [self.stackView addArrangedSubview:pushViewControllerButton];
    
    KDIBadgeButton *centerBadgeButton = [[KDIBadgeButton alloc] initWithFrame:CGRectZero];
    
    [centerBadgeButton setTranslatesAutoresizingMaskIntoConstraints:NO];
    [centerBadgeButton setBadgePosition:KDIBadgeButtonBadgePositionRelativeToImage];
    [centerBadgeButton setBadgePositionOffset:UIOffsetMake(1.0, 0.5)];
    [centerBadgeButton setBadgeSizeOffset:UIOffsetMake(-0.25, -0.5)];
    [centerBadgeButton.button setKDI_cornerRadius:5.0];
    [centerBadgeButton.button setContentEdgeInsets:UIEdgeInsetsMake(8, 16, 8, 16)];
    [centerBadgeButton.button setTitleEdgeInsets:UIEdgeInsetsMake(8, 0, 0, 0)];
    [centerBadgeButton.button setBackgroundColor:backgroundColor];
    [centerBadgeButton.button setTitleContentVerticalAlignment:KDIButtonContentVerticalAlignmentBottom];
    [centerBadgeButton.button setTitleContentHorizontalAlignment:KDIButtonContentHorizontalAlignmentCenter];
    [centerBadgeButton.button setImageContentVerticalAlignment:KDIButtonContentVerticalAlignmentTop];
    [centerBadgeButton.button setImageContentHorizontalAlignment:KDIButtonContentHorizontalAlignmentCenter];
    [centerBadgeButton.button setTitle:@"Center Badge" forState:UIControlStateNormal];
    [centerBadgeButton.button setImage:[[UIImage KSO_fontAwesomeImageWithString:@"\uf1d9" size:CGSizeMake(32, 32)] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate] forState:UIControlStateNormal];
    [centerBadgeButton.badgeView setBadge:[NSNumberFormatter localizedStringFromNumber:@123 numberStyle:NSNumberFormatterDecimalStyle]];
    [centerBadgeButton.button KDI_addBlock:^(__kindof UIControl * _Nonnull control, UIControlEvents controlEvents) {
        [centerBadgeButton.badgeView setBadge:[NSNumberFormatter localizedStringFromNumber:@(arc4random_uniform(1001)) numberStyle:NSNumberFormatterDecimalStyle]];
    } forControlEvents:UIControlEventTouchUpInside];
    
    [self.stackView addArrangedSubview:centerBadgeButton];
    
    KDILabel *label = [[KDILabel alloc] initWithFrame:CGRectZero];
    
    [label setTranslatesAutoresizingMaskIntoConstraints:NO];
    [label setCopyable:YES];
    [label setBorderWidthRespectsScreenScale:YES];
    [label setBorderOptions:KDIBorderOptionsBottom];
    [label setBorderColor:KDIColorRandomRGB()];
    [label setEdgeInsets:UIEdgeInsetsMake(0, 0, 4, 0)];
    [label setText:@"Long press to copy!"];
    
    [self.stackView addArrangedSubview:label];
    
    KDIButton *cameraButton = [KDIButton buttonWithType:UIButtonTypeSystem];
    
    [cameraButton setTranslatesAutoresizingMaskIntoConstraints:NO];
    [cameraButton setBackgroundColor:backgroundColor];
    [cameraButton setRounded:YES];
    [cameraButton setImage:[UIImage KSO_fontAwesomeImageWithString:@"\uf030" size:CGSizeMake(25, 25)].KDI_templateImage forState:UIControlStateNormal];
    [cameraButton setTitle:@"Camera" forState:UIControlStateNormal];
    [cameraButton setContentEdgeInsets:UIEdgeInsetsMake(8, 16, 8, 16)];
    [cameraButton setTitleEdgeInsets:UIEdgeInsetsMake(0, 8, 0, 0)];
    [cameraButton KDI_addBlock:^(__kindof UIControl * _Nonnull control, UIControlEvents controlEvents) {
        kstStrongify(self);
        if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
            return;
        }
        
        UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
        
        [imagePickerController setSourceType:UIImagePickerControllerSourceTypeCamera];
        [imagePickerController setMediaTypes:[UIImagePickerController availableMediaTypesForSourceType:UIImagePickerControllerSourceTypeCamera]];
        
        [self KDI_presentImagePickerController:imagePickerController barButtonItem:nil sourceView:control sourceRect:CGRectZero permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES completion:^(NSDictionary<NSString *,id> * _Nullable info) {
            KSTLogObject(info);
        }];
    } forControlEvents:UIControlEventTouchUpInside];
    
    [self.stackView addArrangedSubview:cameraButton];
    
    KDIButton *photosButton = [KDIButton buttonWithType:UIButtonTypeSystem];
    
    [photosButton setTranslatesAutoresizingMaskIntoConstraints:NO];
    [photosButton setBackgroundColor:backgroundColor];
    [photosButton setRounded:YES];
    [photosButton setImage:[UIImage KSO_fontAwesomeImageWithString:@"\uf03e" size:CGSizeMake(25, 25)].KDI_templateImage forState:UIControlStateNormal];
    [photosButton setTitle:@"Photos" forState:UIControlStateNormal];
    [photosButton setContentEdgeInsets:UIEdgeInsetsMake(8, 16, 8, 16)];
    [photosButton setTitleEdgeInsets:UIEdgeInsetsMake(0, 8, 0, 0)];
    [photosButton KDI_addBlock:^(__kindof UIControl * _Nonnull control, UIControlEvents controlEvents) {
        kstStrongify(self);
        if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
            return;
        }
        
        UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
        
        [imagePickerController setSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
        
        [self KDI_presentImagePickerController:imagePickerController barButtonItem:nil sourceView:control sourceRect:CGRectZero permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES completion:^(NSDictionary<NSString *,id> * _Nullable info) {
            KSTLogObject(info);
        }];
    } forControlEvents:UIControlEventTouchUpInside];
    
    [self.stackView addArrangedSubview:photosButton];
    
    [self KDI_registerForNextPreviousNotificationsWithResponders:@[pickerViewButton,datePickerButton]];
    
    [NSObject KDI_registerDynamicTypeObjectsForTextStyles:@{UIFontTextStyleCaption2: @[centerBadgeButton.badgeView],
                                                            UIFontTextStyleCallout: @[badgeView,blockButton.titleLabel,pickerViewButton.titleLabel,datePickerButton.titleLabel,centerBadgeButton.button.titleLabel,cameraButton.titleLabel],
                                                            UIFontTextStyleBody: @[label]}];
    
    [self.navigationItem setBackBarButtonItem:[UIBarButtonItem iosd_backBarButtonItemWithViewController:self]];
    
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:nil action:NULL];
    
    [tapGestureRecognizer setNumberOfTapsRequired:3];
    [tapGestureRecognizer setNumberOfTouchesRequired:1];
    [tapGestureRecognizer KDI_addBlock:^(__kindof UIGestureRecognizer * _Nonnull gestureRecognizer) {
        [self.view.window setTintColor:KDIColorRandomRGB()];
    }];
    [self.view addGestureRecognizer:tapGestureRecognizer];
}

- (NSInteger)numberOfComponentsInPickerViewButton:(KDIPickerViewButton *)pickerViewButton {
    return kPickerViewButtonComponentsAndRows.count;
}
- (NSInteger)pickerViewButton:(KDIPickerViewButton *)pickerViewButton numberOfRowsInComponent:(NSInteger)component {
    return kPickerViewButtonComponentsAndRows[component].count;
}
- (NSString *)pickerViewButton:(KDIPickerViewButton *)pickerViewButton titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    return kPickerViewButtonComponentsAndRows[component][row];
}

@end
