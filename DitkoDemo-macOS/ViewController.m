//
//  ViewController.m
//  DitkoDemo-macOS
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

@implementation ViewController

- (void)loadView {
    KDIView *view = [[KDIView alloc] initWithFrame:CGRectZero];
    
    [view setBackgroundColor:KDIColorRandomRGB()];
    [view setBorderColor:KDIColorRandomRGB()];
    [view setBorderWidth:4.0];
    [view setBorderOptions:KDIViewBorderOptionsAll];
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
    
    [badgeView setBadge:@"1234"];
    [badgeView setTranslatesAutoresizingMaskIntoConstraints:NO];
    
    [gradientView addSubview:badgeView];
    [gradientView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[view]" options:0 metrics:nil views:@{@"view": badgeView}]];
    [gradientView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-[view]" options:0 metrics:nil views:@{@"view": badgeView}]];
    
    NSButton *button = [NSButton KDI_buttonWithTitle:@"Block button" bezelStyle:NSBezelStyleRounded];
    
    [button setTranslatesAutoresizingMaskIntoConstraints:NO];
    [button setTitle:@"Block button"];
    [button setKDI_block:^(__kindof NSControl *control){
        NSLog(@"the button %@ was clicked!",control);
    }];
    
    [gradientView addSubview:button];
    
    [gradientView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[subview]-[view]" options:0 metrics:nil views:@{@"view": button, @"subview": badgeView}]];
    [gradientView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-[view]" options:0 metrics:nil views:@{@"view": button}]];
    
    NSTextField *label = [NSTextField KDI_labelWithText:@"Label"];
    
    [label setTranslatesAutoresizingMaskIntoConstraints:NO];
    
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
