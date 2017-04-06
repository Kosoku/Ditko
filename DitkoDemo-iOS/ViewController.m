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
    
    [gradientView setColors:@[KDIColorRandomRGB(),KDIColorRandomRGB()]];
    [gradientView setTranslatesAutoresizingMaskIntoConstraints:NO];
    
    [self.view addSubview:gradientView];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-margin-[view]-margin-|" options:0 metrics:@{@"margin": @16.0} views:@{@"view": gradientView}]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-margin-[view]-margin-|" options:0 metrics:@{@"margin": @16.0} views:@{@"view": gradientView}]];
    
    KDIBadgeView *badgeView = [[KDIBadgeView alloc] initWithFrame:CGRectZero];
    
    [badgeView setBadge:@"1234"];
    [badgeView setTranslatesAutoresizingMaskIntoConstraints:NO];
    
    [gradientView addSubview:badgeView];
    [gradientView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[view]" options:0 metrics:nil views:@{@"view": badgeView}]];
    [gradientView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-[view]" options:0 metrics:nil views:@{@"view": badgeView}]];
    
    KDIButton *button = [[KDIButton alloc] initWithFrame:CGRectZero];
    
    [button setTranslatesAutoresizingMaskIntoConstraints:NO];
    [button setBackgroundColor:KDIColorRandomRGB()];
    [button setContentEdgeInsets:UIEdgeInsetsMake(8, 8, 8, 8)];
    [button setImageEdgeInsets:UIEdgeInsetsMake(0, 8, 0, 0)];
    [button setTitleColor:KDIColorRandomRGB() forState:UIControlStateNormal];
    [button setTitle:@"Title" forState:UIControlStateNormal];
    [button setImage:[[UIImage imageNamed:@"globe"] KLO_imageByTintingWithColor:KDIColorRandomRGB()] forState:UIControlStateNormal];
    [button setTitleAlignment:KDIButtonAlignmentLeft|KDIButtonAlignmentCenter];
    [button setImageAlignment:KDIButtonAlignmentRight|KDIButtonAlignmentCenter];
    [button setStyle:KDIButtonStyleRounded];
    
    [gradientView addSubview:button];
    [gradientView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[subview]-[view]" options:0 metrics:nil views:@{@"view": button, @"subview": badgeView}]];
    [gradientView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-[view]" options:0 metrics:nil views:@{@"view": button}]];
    
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
    [gradientView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[subview]-[view]" options:0 metrics:nil views:@{@"view": pickerViewButton, @"subview": button}]];
    [gradientView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-[view]" options:0 metrics:nil views:@{@"view": pickerViewButton}]];
    
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
    [gradientView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[subview]-[view]" options:0 metrics:nil views:@{@"view": datePickerButton, @"subview": button}]];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(_nextPreviousNotification:) name:KDINextPreviousInputAccessoryViewNotificationNext object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(_nextPreviousNotification:) name:KDINextPreviousInputAccessoryViewNotificationPrevious object:nil];
    
    [self setFirstResponderControls:@[pickerViewButton,datePickerButton]];
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
