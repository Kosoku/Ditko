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
#import <Loki/Loki.h>
#import <KSOFontAwesomeExtensions/KSOFontAwesomeExtensions.h>

static NSArray<NSArray<NSString *> *> *kPickerViewButtonComponentsAndRows;

@interface ViewController () <KDIPickerViewButtonDataSource,KDIPickerViewButtonDelegate>
@property (copy,nonatomic) NSArray<UIResponder *> *firstResponderControls;
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
    
    [self setTabBarItem:[[UITabBarItem alloc] initWithTitle:self.title image:[[UIImage KSO_fontAwesomeImageWithString:@"\uf11b" size:CGSizeMake(30, 30)] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate] tag:0]];
    
    return self;
}

- (void)loadView {
    KDIView *view = [[KDIView alloc] initWithFrame:CGRectZero];
    
    [view setBackgroundColor:KDIColorRandomRGB()];
    [view setBorderColor:KDIColorRandomRGB()];
    [view setBorderWidth:4.0];
    [view setBorderOptions:KDIViewBorderOptionsAll];
    [view setBorderEdgeInsets:UIEdgeInsetsMake(8.0, 8.0, 8.0, 8.0)];
    
    [self setView:view];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    KDIGradientView *gradientView = [[KDIGradientView alloc] initWithFrame:CGRectZero];
    
    [gradientView setTranslatesAutoresizingMaskIntoConstraints:NO];
    [gradientView setColors:@[KDIColorRandomRGB(),KDIColorRandomRGB()]];
    
    [self.view addSubview:gradientView];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-margin-[view]-margin-|" options:0 metrics:@{@"margin": @16.0} views:@{@"view": gradientView}]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-margin-[view]-margin-|" options:0 metrics:@{@"margin": @16.0} views:@{@"view": gradientView}]];
    
    UILayoutGuide *layoutGuide = [[UILayoutGuide alloc] init];
    
    [gradientView addLayoutGuide:layoutGuide];
    [gradientView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[view]" options:0 metrics:nil views:@{@"view": layoutGuide}]];
    [gradientView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-margin-[view]" options:0 metrics:@{@"margin": @64.0} views:@{@"view": layoutGuide}]];
    
    KDIBadgeView *badgeView = [[KDIBadgeView alloc] initWithFrame:CGRectZero];
    
    [badgeView setBadge:@"1234"];
    [badgeView setBadgeForegroundColor:KDIColorRandomRGB()];
    [badgeView setBadgeBackgroundColor:[badgeView.badgeForegroundColor KDI_inverseColor]];
    [badgeView setTranslatesAutoresizingMaskIntoConstraints:NO];
    
    [gradientView addSubview:badgeView];
    [gradientView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[view]" options:0 metrics:nil views:@{@"view": badgeView}]];
    [gradientView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[subview]-[view]" options:0 metrics:nil views:@{@"view": badgeView, @"subview": layoutGuide}]];
    
    KDIButton *blockButton = [KDIButton buttonWithType:UIButtonTypeSystem];
    
    [blockButton setTranslatesAutoresizingMaskIntoConstraints:NO];
    [blockButton setBackgroundColor:KDIColorRandomRGB()];
    [blockButton setContentEdgeInsets:UIEdgeInsetsMake(8, 8, 8, 8)];
    [blockButton setImageEdgeInsets:UIEdgeInsetsMake(0, 8, 0, 0)];
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
    [blockButton setTitleAlignment:KDIButtonAlignmentLeft|KDIButtonAlignmentCenter];
    [blockButton setImageAlignment:KDIButtonAlignmentRight|KDIButtonAlignmentCenter];
    [blockButton setRounded:YES];
    
    [gradientView addSubview:blockButton];
    [gradientView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[subview]-[view]" options:0 metrics:nil views:@{@"view": blockButton, @"subview": badgeView}]];
    [gradientView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[subview]-[view]" options:0 metrics:nil views:@{@"view": blockButton, @"subview": layoutGuide}]];
    
    KDIPickerViewButton *pickerViewButton = [KDIPickerViewButton buttonWithType:UIButtonTypeSystem];
    
    [pickerViewButton setTranslatesAutoresizingMaskIntoConstraints:NO];
    [pickerViewButton setBackgroundColor:[UIColor whiteColor]];
    [pickerViewButton setContentEdgeInsets:UIEdgeInsetsMake(8, 16, 8, 16)];
    [pickerViewButton setTitleEdgeInsets:UIEdgeInsetsMake(0, 8, 0, 0)];
    [pickerViewButton setImage:[UIImage imageNamed:@"snake"] forState:UIControlStateNormal];
    [pickerViewButton setTitleAlignment:KDIButtonAlignmentRight|KDIButtonAlignmentCenter];
    [pickerViewButton setImageAlignment:KDIButtonAlignmentLeft|KDIButtonAlignmentCenter];
    [pickerViewButton setRounded:YES];
    [pickerViewButton setDataSource:self];
    [pickerViewButton setDelegate:self];
    [pickerViewButton setSelectedComponentsJoinString:@", "];
    
    [gradientView addSubview:pickerViewButton];
    [gradientView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[subview]-[view]" options:0 metrics:nil views:@{@"view": pickerViewButton, @"subview": blockButton}]];
    [gradientView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[subview]-[view]" options:0 metrics:nil views:@{@"view": pickerViewButton, @"subview": layoutGuide}]];
    
    KDIDatePickerButton *datePickerButton = [KDIDatePickerButton buttonWithType:UIButtonTypeSystem];
    
    [datePickerButton setTranslatesAutoresizingMaskIntoConstraints:NO];
    [datePickerButton setContentEdgeInsets:UIEdgeInsetsMake(8, 16, 8, 16)];
    [datePickerButton setTitleEdgeInsets:UIEdgeInsetsMake(0, 8, 0, 0)];
    [datePickerButton setImage:[[UIImage imageNamed:@"ticket"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate] forState:UIControlStateNormal];
    [datePickerButton setTitleAlignment:KDIButtonAlignmentRight|KDIButtonAlignmentCenter];
    [datePickerButton setImageAlignment:KDIButtonAlignmentLeft|KDIButtonAlignmentCenter];
    [datePickerButton setRounded:YES];
    [datePickerButton setInverted:YES];
    
    [gradientView addSubview:datePickerButton];
    [gradientView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[view]" options:0 metrics:nil views:@{@"view": datePickerButton}]];
    [gradientView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[subview]-[view]" options:0 metrics:nil views:@{@"view": datePickerButton, @"subview": blockButton}]];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(_nextPreviousNotification:) name:KDINextPreviousInputAccessoryViewNotificationNext object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(_nextPreviousNotification:) name:KDINextPreviousInputAccessoryViewNotificationPrevious object:nil];
    
    [self setFirstResponderControls:@[pickerViewButton,datePickerButton]];
    
    KDIButton *centerButton = [KDIButton buttonWithType:UIButtonTypeSystem];
    
    [centerButton setTranslatesAutoresizingMaskIntoConstraints:NO];
    [centerButton setTintColor:KDIColorRandomRGB()];
    [centerButton setBackgroundColor:[centerButton.tintColor KDI_inverseColor]];
    [centerButton setContentEdgeInsets:UIEdgeInsetsMake(8, 16, 8, 16)];
    [centerButton setTitleEdgeInsets:UIEdgeInsetsMake(4, 0, 0, 0)];
    [centerButton setTitle:@"Alert" forState:UIControlStateNormal];
    [centerButton setImage:[UIImage imageNamed:@"ghost"] forState:UIControlStateNormal];
    [centerButton KDI_addBlock:^(__kindof UIControl * _Nonnull control, UIControlEvents controlEvents) {
        [centerButton setTintColor:KDIColorRandomRGB()];
        [centerButton setBackgroundColor:[centerButton.tintColor KDI_inverseColor]];
        
        [UIAlertController KDI_presentAlertControllerWithOptions:@{KDIUIAlertControllerOptionsKeyTitle: @"Title", KDIUIAlertControllerOptionsKeyMessage: @"This is an alert message", KDIUIAlertControllerOptionsKeyActions: @[@{KDIUIAlertControllerOptionsActionKeyTitle: @"Cancel", KDIUIAlertControllerOptionsActionKeyStyle: @(UIAlertActionStyleCancel)},@{KDIUIAlertControllerOptionsActionKeyTitle: @"Destroy!",KDIUIAlertControllerOptionsActionKeyStyle: @(UIAlertActionStyleDestructive)},@{KDIUIAlertControllerOptionsActionKeyTitle: @"Action",KDIUIAlertControllerOptionsActionKeyPreferred: @YES}], KDIUIAlertControllerOptionsKeyTextFieldConfigurationBlocks: @[^(UITextField *textField){textField.placeholder = @"All the #hashtags"; textField.keyboardType = UIKeyboardTypeTwitter;}]} completion:^(__kindof UIAlertController *alertController, NSInteger buttonIndex) {
            NSLog(@"%@ %@",@(buttonIndex),alertController.textFields.firstObject.text);
        }];
    } forControlEvents:UIControlEventTouchUpInside];
    [centerButton setTitleAlignment:KDIButtonAlignmentBottom|KDIButtonAlignmentCenter];
    [centerButton setImageAlignment:KDIButtonAlignmentTop|KDIButtonAlignmentCenter];
    [centerButton setKDI_cornerRadius:5.0];
    [centerButton.layer setMasksToBounds:YES];
    
    [gradientView addSubview:centerButton];
    [gradientView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[subview]-[view]" options:0 metrics:nil views:@{@"view": centerButton, @"subview": datePickerButton}]];
    [gradientView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[subview]-[view]" options:0 metrics:nil views:@{@"view": centerButton, @"subview": blockButton}]];
    
    KDIBadgeButton *badgeButton = [[KDIBadgeButton alloc] initWithFrame:CGRectZero];
    
    [badgeButton.button setImage:[UIImage KSO_fontAwesomeImageWithString:@"\uf007" size:CGSizeMake(30, 30)] forState:UIControlStateNormal];
    [badgeButton.badgeView setBadge:@"1"];
    [badgeButton.badgeView setBadgeBackgroundColor:KDIColorRandomRGB()];
    [badgeButton.badgeView setBadgeForegroundColor:[badgeButton.badgeView.badgeBackgroundColor KDI_contrastingColor]];
    [badgeButton sizeToFit];
    
    __block NSUInteger badgeButtonValue = 1;
    
    [badgeButton.button KDI_addBlock:^(__kindof UIControl * _Nonnull control, UIControlEvents controlEvents) {
        KDIBadgeButtonBadgePosition badgePosition = badgeButton.badgePosition;
        
        if ((++badgePosition) > KDIBadgeButtonBadgePositionBottomRight) {
            badgePosition = KDIBadgeButtonBadgePositionTopLeft;
        }
        
        [badgeButton setBadgePosition:badgePosition];
        [badgeButton.badgeView setBadge:[NSNumberFormatter localizedStringFromNumber:@(++badgeButtonValue) numberStyle:NSNumberFormatterDecimalStyle]];
        [badgeButton.badgeView setBadgeBackgroundColor:KDIColorRandomRGB()];
        [badgeButton.badgeView setBadgeForegroundColor:[badgeButton.badgeView.badgeBackgroundColor KDI_contrastingColor]];
    } forControlEvents:UIControlEventTouchUpInside];
    
    [self.navigationItem setRightBarButtonItems:@[[[UIBarButtonItem alloc] initWithCustomView:badgeButton]]];
    
    [NSObject KDI_registerDynamicTypeObject:badgeButton.badgeView forTextStyle:UIFontTextStyleCaption2];
    [NSObject KDI_registerDynamicTypeObjects:@[badgeView,blockButton.titleLabel,pickerViewButton.titleLabel,datePickerButton.titleLabel] forTextStyle:UIFontTextStyleCallout];
    
    KDIButton *toggleButton = [KDIButton buttonWithType:UIButtonTypeSystem];
    
    [toggleButton setTranslatesAutoresizingMaskIntoConstraints:NO];
    [toggleButton setBackgroundColor:UIColor.whiteColor];
    [toggleButton setContentEdgeInsets:UIEdgeInsetsMake(8, 16, 8, 16)];
    [toggleButton setRounded:YES];
    [toggleButton setTitle:@"Show Progress" forState:UIControlStateNormal];
    [toggleButton KDI_addBlock:^(__kindof UIControl * _Nonnull control, UIControlEvents controlEvents) {
        BOOL progressHidden = !self.navigationController.KDI_progressNavigationBar.isProgressHidden;
        
        [self.navigationController.KDI_progressNavigationBar setProgressHidden:progressHidden animated:YES];
        
        [toggleButton setTitle:progressHidden ? @"Show Progress" : @"Hide Progress" forState:UIControlStateNormal];
    } forControlEvents:UIControlEventTouchUpInside];
    
    [gradientView addSubview:toggleButton];
    [gradientView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[view]" options:0 metrics:nil views:@{@"view": toggleButton}]];
    [gradientView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[subview]-[view]" options:0 metrics:nil views:@{@"view": toggleButton, @"subview": datePickerButton}]];
    
    UIStepper *stepper = [[UIStepper alloc] initWithFrame:CGRectZero];
    
    [stepper setTranslatesAutoresizingMaskIntoConstraints:NO];
    [stepper setStepValue:0.1];
    [stepper KDI_addBlock:^(__kindof UIControl * _Nonnull control, UIControlEvents controlEvents) {
        [self.navigationController.KDI_progressNavigationBar setProgress:stepper.value animated:YES];
    } forControlEvents:UIControlEventValueChanged];
    
    [gradientView addSubview:stepper];
    [gradientView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[subview]-[view]" options:0 metrics:nil views:@{@"view": stepper, @"subview": toggleButton}]];
    [gradientView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[subview]-[view]" options:0 metrics:nil views:@{@"view": stepper, @"subview": datePickerButton}]];
    
    KDIButton *pushViewControllerButton = [KDIButton buttonWithType:UIButtonTypeSystem];
    
    [pushViewControllerButton setTranslatesAutoresizingMaskIntoConstraints:NO];
    [pushViewControllerButton setBackgroundColor:[pushViewControllerButton.tintColor KDI_contrastingColor]];
    [pushViewControllerButton setTitle:@"Push VC" forState:UIControlStateNormal];
    [pushViewControllerButton setContentEdgeInsets:UIEdgeInsetsMake(8, 16, 8, 16)];
    [pushViewControllerButton setRounded:YES];
    [pushViewControllerButton KDI_addBlock:^(__kindof UIControl * _Nonnull control, UIControlEvents controlEvents) {
        [self.navigationController pushViewController:[[PushViewController alloc] init] animated:YES];
    } forControlEvents:UIControlEventTouchUpInside];
    
    [gradientView addSubview:pushViewControllerButton];
    [gradientView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[view]" options:0 metrics:nil views:@{@"view": pushViewControllerButton}]];
    [gradientView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[subview]-[view]" options:0 metrics:nil views:@{@"view": pushViewControllerButton, @"subview": toggleButton}]];
    
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

- (void)_nextPreviousNotification:(NSNotification *)note {
    KDINextPreviousInputAccessoryView *inputAccessoryView = note.object;
    
    if (![self.firstResponderControls containsObject:inputAccessoryView.responder]) {
        return;
    }
    
    NSInteger index = [self.firstResponderControls indexOfObject:inputAccessoryView.responder];
    
    if ([note.name isEqualToString:KDINextPreviousInputAccessoryViewNotificationNext]) {
        index++;
    }
    else {
        index--;
    }
    
    if (index < 0) {
        index = self.firstResponderControls.count - 1;
    }
    else if (index == self.firstResponderControls.count) {
        index = 0;
    }
    
    [self.firstResponderControls[index] becomeFirstResponder];
}

@end
