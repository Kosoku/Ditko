//
//  ColorsViewController.m
//  Demo-iOS
//
//  Created by William Towe on 3/16/18.
//  Copyright © 2018 Kosoku Interactive, LLC. All rights reserved.
//
//  Redistribution and use in source and binary forms, with or without modification, are permitted provided that the following conditions are met:
//
//  1. Redistributions of source code must retain the above copyright notice, this list of conditions and the following disclaimer.
//
//  2. Redistributions in binary form must reproduce the above copyright notice, this list of conditions and the following disclaimer in the documentation and/or other materials provided with the distribution.
//
//  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

#import "ColorsViewController.h"

#import <Ditko/Ditko.h>
#import <Stanley/Stanley.h>
#import <KSOFontAwesomeExtensions/KSOFontAwesomeExtensions.h>

typedef NS_ENUM(NSInteger, ColorsViewControllerTag) {
    ColorsViewControllerTagHue = 0,
    ColorsViewControllerTagSaturation,
    ColorsViewControllerTagBrightness
};

@interface ColorsViewController ()
@property (weak,nonatomic) IBOutlet UIView *leftView;
@property (weak,nonatomic) IBOutlet UIView *rightView;
@property (weak,nonatomic) IBOutlet UITextField *textField;
@property (weak,nonatomic) IBOutlet UIStepper *stepper;
@property (weak,nonatomic) IBOutlet UILabel *label;
@property (weak,nonatomic) IBOutlet UIButton *resetButton;
@property (strong,nonatomic) UISegmentedControl *segmentedControl;

@property (copy,nonatomic) NSArray<NSNumber *> *tags;

- (void)_reloadData;
- (NSString *)_titleForTag:(ColorsViewControllerTag)tag;
@end

@implementation ColorsViewController

- (NSString *)title {
    return @"Colors";
}

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if (!(self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]))
        return nil;
    
    kstWeakify(self);
    
    self.tabBarItem = [[UITabBarItem alloc] initWithTitle:self.title image:[UIImage KSO_fontAwesomeSolidImageWithString:@"\uf466" size:CGSizeMake(25, 25)] selectedImage:nil];
    
    self.tags = @[@(ColorsViewControllerTagHue),
                  @(ColorsViewControllerTagSaturation),
                  @(ColorsViewControllerTagBrightness)];
    
    NSMutableArray *titles = [[NSMutableArray alloc] init];
    
    for (NSNumber *tag in self.tags) {
        [titles addObject:[self _titleForTag:tag.integerValue]];
    }
    
    self.segmentedControl = [[UISegmentedControl alloc] initWithItems:titles];
    self.segmentedControl.apportionsSegmentWidthsByContent = YES;
    self.segmentedControl.selectedSegmentIndex = 0;
    [self.segmentedControl KDI_addBlock:^(__kindof UIControl * _Nonnull control, UIControlEvents controlEvents) {
        kstStrongify(self);
        [self _reloadData];
    } forControlEvents:UIControlEventValueChanged];
    [self.segmentedControl sizeToFit];
    
    self.navigationItem.titleView = self.segmentedControl;
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.textField.text = [KDIColorRandomRGB() KDI_hexadecimalString];
    
    kstWeakify(self);
    [self.textField KDI_addBlock:^(__kindof UIControl * _Nonnull control, UIControlEvents controlEvents) {
        kstStrongify(self);
        [self _reloadData];
    } forControlEvents:UIControlEventEditingChanged];
    
    [self.stepper KDI_addBlock:^(__kindof UIControl * _Nonnull control, UIControlEvents controlEvents) {
        kstStrongify(self);
        [self _reloadData];
    } forControlEvents:UIControlEventValueChanged];
    
    [self.resetButton KDI_addBlock:^(__kindof UIControl * _Nonnull control, UIControlEvents controlEvents) {
        kstStrongify(self);
        self.stepper.value = 0.0;
        
        [self _reloadData];
    } forControlEvents:UIControlEventTouchUpInside];
    
    [self _reloadData];
}

- (void)_reloadData; {
    self.label.text = [NSNumberFormatter localizedStringFromNumber:@(self.stepper.value) numberStyle:NSNumberFormatterPercentStyle];
    
    UIColor *leftColor = KDIColorHexadecimal(self.textField.text);
    
    if (leftColor == nil) {
        return;
    }
    
    UIColor *contrastColor = [leftColor KDI_contrastingColor];
    
    self.stepper.tintColor = contrastColor;
    self.label.textColor = contrastColor;
    self.resetButton.tintColor = contrastColor;
    
    UIColor *rightColor;
    ColorsViewControllerTag tag = self.tags[self.segmentedControl.selectedSegmentIndex].integerValue;
    
    switch (tag) {
        case ColorsViewControllerTagSaturation:
            rightColor = [leftColor KDI_colorByAdjustingSaturationByPercent:self.stepper.value];
            break;
        case ColorsViewControllerTagBrightness:
            rightColor = [leftColor KDI_colorByAdjustingBrightnessByPercent:self.stepper.value];
            break;
        case ColorsViewControllerTagHue:
            rightColor = [leftColor KDI_colorByAdjustingHueByPercent:self.stepper.value];
            break;
        default:
            break;
    }
    
    self.leftView.backgroundColor = leftColor;
    self.rightView.backgroundColor = rightColor;
}
- (NSString *)_titleForTag:(ColorsViewControllerTag)tag; {
    switch (tag) {
        case ColorsViewControllerTagHue:
            return @"Hue";
        case ColorsViewControllerTagBrightness:
            return @"Brightness";
        case ColorsViewControllerTagSaturation:
            return @"Saturation";
    }
}

@end
