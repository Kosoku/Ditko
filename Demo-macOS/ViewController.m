//
//  ViewController.m
//  DitkoDemo-macOS
//
//  Created by William Towe on 3/8/17.
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

#import "ViewController.h"

#import <Ditko/Ditko.h>
#import <Loki/Loki.h>
#import <Stanley/Stanley.h>

@interface View : KDIView

@end

@implementation View

- (instancetype)initWithFrame:(NSRect)frameRect {
    if (!(self = [super initWithFrame:frameRect]))
        return nil;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(_View_stateDidChange:) name:KDIViewNotificationDidChangeState object:self];
    
    return self;
}

- (void)_View_stateDidChange:(NSNotification *)note {
    [self setBorderColor:KDIColorRandomRGB()];
}

@end

@implementation ViewController

- (void)loadView {
    KDIView *view = [[View alloc] initWithFrame:CGRectZero];
    
    [view setBackgroundColor:KDIColorRandomRGB()];
    [view setBorderColor:KDIColorRandomRGB()];
    [view setBorderWidth:4.0];
    [view setBorderOptions:KDIBorderOptionsAll];
    [view setBorderEdgeInsets:NSEdgeInsetsMake(8.0, 8.0, 8.0, 8.0)];
    
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
    
    KDIBadgeView *badgeView = [[KDIBadgeView alloc] initWithFrame:NSZeroRect];
    
    [badgeView setBadgeBackgroundColor:KDIColorRandomRGB()];
    [badgeView setBadgeForegroundColor:[badgeView.badgeBackgroundColor KDI_inverseColor]];
    [badgeView setBadge:@"1234"];
    [badgeView setTranslatesAutoresizingMaskIntoConstraints:NO];
    
    [gradientView addSubview:badgeView];
    [gradientView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[view]" options:0 metrics:nil views:@{@"view": badgeView}]];
    [gradientView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-[view]" options:0 metrics:nil views:@{@"view": badgeView}]];
    
    NSButton *button = [NSButton KDI_buttonWithTitle:@"Block button" bezelStyle:NSBezelStyleRounded];
    
    [button setTranslatesAutoresizingMaskIntoConstraints:NO];
    [button setTitle:@"Block button"];
    [button setKDI_block:^(__kindof NSControl *control){
        KDIClickableLabel *accessoryView = [[KDIClickableLabel alloc] initWithFrame:NSZeroRect];
        
        [accessoryView setStringValue:@"Click this to show a save panel!"];
        [accessoryView setBlock:^(KDIClickableLabel *label) {
            [[NSSavePanel savePanel] KDI_presentAsSheetWithValidateURLBlock:^BOOL(NSSavePanel * _Nonnull savePanel, NSURL * _Nonnull URL, NSError * _Nullable __autoreleasing * _Nullable outError) {
                if ([URL.lastPathComponent containsString:@"a"]) {
                    if (outError != nil) {
                        *outError = [NSError errorWithDomain:[NSBundle mainBundle].KST_bundleIdentifier code:0 userInfo:@{NSLocalizedDescriptionKey: @"The filename is not valid", NSLocalizedRecoverySuggestionErrorKey: @"The filename cannot have an \"a\" in it. Pick another filename."}];
                    }
                    return NO;
                }
                return YES;
            } completion:^(NSSavePanel * _Nonnull savePanel, NSURL * _Nullable URL) {
                NSLog(@"%@ %@",savePanel,URL);
            }];
        }];
        [accessoryView sizeToFit];
        
        [[NSAlert KDI_alertWithOptions:@{KDINSAlertOptionsKeyStyle: @(NSAlertStyleCritical), KDINSAlertOptionsKeyTitle: @"Did you see that Morty?", KDINSAlertOptionsKeyMessage: @"It was terrible Rick. The operation couldn't be completed.", KDINSAlertOptionsKeyOtherButtonTitles: @[@"Do nothing",@"Do something"], KDINSAlertOptionsKeyHelpAnchor: @"help", KDINSAlertOptionsKeyShowsSuppressionButton: @YES, KDINSAlertOptionsKeyAccessoryView: accessoryView}] KDI_presentAlertAsSheetWithCompletion:^(NSModalResponse returnCode, BOOL suppressionButtonWasChecked, __kindof NSView * _Nullable accessoryView) {
            NSLog(@"%@ %@ %@",@(returnCode),@(suppressionButtonWasChecked),accessoryView);
        }];
    }];
    
    [gradientView addSubview:button];
    
    [gradientView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[subview]-[view]" options:0 metrics:nil views:@{@"view": button, @"subview": badgeView}]];
    [gradientView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-[view]" options:0 metrics:nil views:@{@"view": button}]];
    
    KDIClickableLabel *label = [KDIClickableLabel KDI_labelWithText:@"Clickable label"];
    
    [label setTranslatesAutoresizingMaskIntoConstraints:NO];
    [label setClickableTextAttributes:@{NSForegroundColorAttributeName: KDIColorRandomRGB(), NSUnderlineColorAttributeName: KDIColorRandomRGB(), NSUnderlineStyleAttributeName: @(NSUnderlineStyleSingle|NSUnderlinePatternDot)}];
    [label setClickableCursor:[NSCursor openHandCursor]];
    [label setBlock:^(KDIClickableLabel *label) {
        NSLog(@"the clickable label %@ was clicked!",label);
    }];
    
    [gradientView addSubview:label];
    
    [gradientView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[subview]-[view]" options:0 metrics:nil views:@{@"view": label, @"subview": button}]];
    [gradientView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-[view]" options:0 metrics:nil views:@{@"view": label}]];
    
    KDIRolloverButton *rolloverButton = [[KDIRolloverButton alloc] initWithFrame:NSZeroRect];
    NSImage *rolloverImage = [NSImage imageNamed:NSImageNameLockLockedTemplate];
    
    [rolloverImage setSize:NSMakeSize(24, 24)];
    
    [rolloverButton setTranslatesAutoresizingMaskIntoConstraints:NO];
    [rolloverButton setTitle:@"Rollover button"];
    [rolloverButton setImagePosition:NSImageLeft];
    [rolloverButton setImage:[rolloverImage KLO_imageByTintingWithColor:KDIColorRandomRGB()] forState:KDIRolloverButtonStateNormal];
    [rolloverButton setImage:[rolloverImage KLO_imageByTintingWithColor:KDIColorRandomRGB()] forState:KDIRolloverButtonStatePressed];
    [rolloverButton setImage:[rolloverImage KLO_imageByTintingWithColor:KDIColorRandomRGB()] forState:KDIRolloverButtonStateRollover];
    [rolloverButton setImage:[rolloverImage KLO_imageByTintingWithColor:KDIColorRandomRGB()] forState:KDIRolloverButtonStateNormalInactive];
    [rolloverButton setImage:[rolloverImage KLO_imageByTintingWithColor:KDIColorRandomRGB()] forState:KDIRolloverButtonStatePressedInactive];
    [rolloverButton setImage:[rolloverImage KLO_imageByTintingWithColor:KDIColorRandomRGB()] forState:KDIRolloverButtonStateRolloverInactive];
    
    [gradientView addSubview:rolloverButton];
    
    [gradientView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[subview]-[view]" options:0 metrics:nil views:@{@"view": rolloverButton, @"subview": label}]];
    [gradientView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-[view]" options:0 metrics:nil views:@{@"view": rolloverButton}]];
    
    NSButton *checkBox = [NSButton KDI_checkBoxWithTitle:@"Check box"];
    
    [checkBox setTranslatesAutoresizingMaskIntoConstraints:NO];
    
    [gradientView addSubview:checkBox];
    
    [gradientView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[view]" options:0 metrics:nil views:@{@"view": checkBox}]];
    [gradientView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[subview]-[view]" options:0 metrics:nil views:@{@"view": checkBox, @"subview": badgeView}]];
    
    NSPopUpButton *actionButton = [NSPopUpButton KDI_actionPopUpButtonBordered:YES];
    
    [actionButton setTranslatesAutoresizingMaskIntoConstraints:NO];
    [actionButton.menu addItemWithTitle:@"Item 1" action:NULL keyEquivalent:@""];
    [actionButton.menu addItemWithTitle:@"Item 2" action:NULL keyEquivalent:@""];
    
    [gradientView addSubview:actionButton];
    
    [gradientView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[subview]-[view]" options:0 metrics:nil views:@{@"view": actionButton, @"subview": checkBox}]];
    [gradientView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[subview]-[view]" options:0 metrics:nil views:@{@"view": actionButton, @"subview": badgeView}]];
}

@end
