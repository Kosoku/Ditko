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

#import <Ditko/Ditko.h>
#import <Loki/Loki.h>

@interface KDIBadgeView (ViewControllerExtensions) <KDIDynamicTypeView>
@end

@implementation KDIBadgeView (ViewControllerExtensions)

@dynamic KDI_dynamicTypeFont;
- (UIFont *)KDI_dynamicTypeFont {
    return self.badgeFont;
}
- (void)setKDI_dynamicTypeFont:(UIFont *)KDI_dynamicTypeFont {
    [self setBadgeFont:KDI_dynamicTypeFont];
}

@end

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
    return @"Demo";
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
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
    [gradientView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-margin-[view]" options:0 metrics:@{@"margin": @44.0} views:@{@"view": layoutGuide}]];
    
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
    [blockButton setTitle:@"Block button" forState:UIControlStateNormal];
    [blockButton setImage:[UIImage imageNamed:@"globe"] forState:UIControlStateNormal];
    [blockButton KDI_addBlock:^(__kindof UIControl * _Nonnull control, UIControlEvents controlEvents) {
        [blockButton setBackgroundColor:KDIColorRandomRGB()];
        [blockButton setTintColor:[blockButton.backgroundColor KDI_contrastingColor]];
    } forControlEvents:UIControlEventTouchUpInside];
    [blockButton setTitleAlignment:KDIButtonAlignmentLeft|KDIButtonAlignmentCenter];
    [blockButton setImageAlignment:KDIButtonAlignmentRight|KDIButtonAlignmentCenter];
    [blockButton setStyle:KDIButtonStyleRounded];
    
    [gradientView addSubview:blockButton];
    [gradientView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[subview]-[view]" options:0 metrics:nil views:@{@"view": blockButton, @"subview": badgeView}]];
    [gradientView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[subview]-[view]" options:0 metrics:nil views:@{@"view": blockButton, @"subview": layoutGuide}]];
    
    KDIPickerViewButton *pickerViewButton = [KDIPickerViewButton buttonWithType:UIButtonTypeSystem];
    
    [pickerViewButton setTranslatesAutoresizingMaskIntoConstraints:NO];
    [pickerViewButton setBackgroundColor:[UIColor whiteColor]];
    [pickerViewButton setContentEdgeInsets:UIEdgeInsetsMake(8, 8, 8, 8)];
    [pickerViewButton setTitleEdgeInsets:UIEdgeInsetsMake(0, 8, 0, 0)];
    [pickerViewButton setImage:[UIImage imageNamed:@"snake"] forState:UIControlStateNormal];
    [pickerViewButton setTitleAlignment:KDIButtonAlignmentRight|KDIButtonAlignmentCenter];
    [pickerViewButton setImageAlignment:KDIButtonAlignmentLeft|KDIButtonAlignmentCenter];
    [pickerViewButton setStyle:KDIButtonStyleRounded];
    [pickerViewButton setDataSource:self];
    [pickerViewButton setDelegate:self];
    [pickerViewButton setSelectedComponentsJoinString:@", "];
    
    [gradientView addSubview:pickerViewButton];
    [gradientView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[subview]-[view]" options:0 metrics:nil views:@{@"view": pickerViewButton, @"subview": blockButton}]];
    [gradientView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[subview]-[view]" options:0 metrics:nil views:@{@"view": pickerViewButton, @"subview": layoutGuide}]];
    
    KDIDatePickerButton *datePickerButton = [KDIDatePickerButton buttonWithType:UIButtonTypeSystem];
    
    [datePickerButton setTranslatesAutoresizingMaskIntoConstraints:NO];
    [datePickerButton setBackgroundColor:[UIColor whiteColor]];
    [datePickerButton setContentEdgeInsets:UIEdgeInsetsMake(8, 8, 8, 8)];
    [datePickerButton setTitleEdgeInsets:UIEdgeInsetsMake(0, 8, 0, 0)];
    [datePickerButton setImage:[UIImage imageNamed:@"ticket"] forState:UIControlStateNormal];
    [datePickerButton setTitleAlignment:KDIButtonAlignmentRight|KDIButtonAlignmentCenter];
    [datePickerButton setImageAlignment:KDIButtonAlignmentLeft|KDIButtonAlignmentCenter];
    [datePickerButton setStyle:KDIButtonStyleRounded];
    
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
    [centerButton setContentEdgeInsets:UIEdgeInsetsMake(8, 8, 8, 8)];
    [centerButton setTitleEdgeInsets:UIEdgeInsetsMake(4, 0, 0, 0)];
    [centerButton setTitle:@"Ghost" forState:UIControlStateNormal];
    [centerButton setImage:[UIImage imageNamed:@"ghost"] forState:UIControlStateNormal];
    [centerButton KDI_addBlock:^(__kindof UIControl * _Nonnull control, UIControlEvents controlEvents) {
        [centerButton setTintColor:KDIColorRandomRGB()];
        [centerButton setBackgroundColor:[centerButton.tintColor KDI_inverseColor]];
    } forControlEvents:UIControlEventTouchUpInside];
    [centerButton setTitleAlignment:KDIButtonAlignmentBottom|KDIButtonAlignmentCenter];
    [centerButton setImageAlignment:KDIButtonAlignmentTop|KDIButtonAlignmentCenter];
    [centerButton setKDI_cornerRadius:5.0];
    [centerButton.layer setMasksToBounds:YES];
    
    [gradientView addSubview:centerButton];
    [gradientView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[subview]-[view]" options:0 metrics:nil views:@{@"view": centerButton, @"subview": datePickerButton}]];
    [gradientView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[subview]-[view]" options:0 metrics:nil views:@{@"view": centerButton, @"subview": blockButton}]];
    
    KDIBadgeButton *badgeButton = [[KDIBadgeButton alloc] initWithFrame:CGRectZero];
    
    [badgeButton.button setImage:[UIImage imageNamed:@"bolt"] forState:UIControlStateNormal];
    [badgeButton.badgeView setBadge:@"1"];
    [badgeButton sizeToFit];
    
    [badgeButton KDI_debugBorderWithColor:UIColor.redColor];
    
    __block NSUInteger badgeButtonValue = 1;
    
    [badgeButton.button KDI_addBlock:^(__kindof UIControl * _Nonnull control, UIControlEvents controlEvents) {
        KDIBadgeButtonBadgePosition badgePosition = badgeButton.badgePosition;
        
        if ((++badgePosition) > KDIBadgeButtonBadgePositionBottomRight) {
            badgePosition = KDIBadgeButtonBadgePositionTopLeft;
        }
        
        [badgeButton setBadgePosition:badgePosition];
        [badgeButton.badgeView setBadge:[NSNumberFormatter localizedStringFromNumber:@(++badgeButtonValue) numberStyle:NSNumberFormatterDecimalStyle]];
    } forControlEvents:UIControlEventTouchUpInside];
    
    [self.navigationItem setRightBarButtonItems:@[[[UIBarButtonItem alloc] initWithCustomView:badgeButton]]];
    
    [NSObject KDI_registerDynamicTypeViews:@[badgeView,blockButton,pickerViewButton,datePickerButton] forTextStyle:UIFontTextStyleBody];
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
