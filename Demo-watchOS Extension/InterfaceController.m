//
//  InterfaceController.m
//  DitkoDemo-watchOS Extension
//
//  Created by William Towe on 3/8/17.
//  Copyright © 2018 Kosoku Interactive, LLC. All rights reserved.
//
//  Redistribution and use in source and binary forms, with or without modification, are permitted provided that the following conditions are met:
//
//  1. Redistributions of source code must retain the above copyright notice, this list of conditions and the following disclaimer.
//
//  2. Redistributions in binary form must reproduce the above copyright notice, this list of conditions and the following disclaimer in the documentation and/or other materials provided with the distribution.
//
//  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

#import "InterfaceController.h"

#import <Ditko/Ditko.h>
#import <Stanley/Stanley.h>

@interface InterfaceController()
@property (weak,nonatomic) IBOutlet WKInterfaceButton *alertButton, *sideBySideButton, *actionSheetButton;

- (void)_showAlertControllerWithStyle:(WKAlertControllerStyle)style;
@end


@implementation InterfaceController

- (void)awakeWithContext:(id)context {
    [super awakeWithContext:context];

    NSArray *titles = @[@"Alert",@"Side by Side Alert",@"Action Sheet"];
    
    [@[self.alertButton,self.sideBySideButton,self.actionSheetButton] enumerateObjectsUsingBlock:^(WKInterfaceButton * _Nonnull button, NSUInteger idx, BOOL * _Nonnull stop) {
        UIColor *color = KDIColorRandomRGB();
        
        [button setBackgroundColor:color];
        [button setAttributedTitle:[[NSAttributedString alloc] initWithString:titles[idx] attributes:@{NSForegroundColorAttributeName: [color KDI_contrastingColor]}]];
    }];
}

- (IBAction)_showAlertAction:(id)sender {
    [self _showAlertControllerWithStyle:WKAlertControllerStyleAlert];
}
- (IBAction)_showSideBySideAlertAction:(id)sender {
    [self _showAlertControllerWithStyle:WKAlertControllerStyleSideBySideButtonsAlert];
}
- (IBAction)_showActionSheetAction:(id)sender {
    [self _showAlertControllerWithStyle:WKAlertControllerStyleActionSheet];
}

- (void)_showAlertControllerWithStyle:(WKAlertControllerStyle)style; {
    NSString *title = nil;
    NSString *message = nil;
    NSString *cancelTitle = nil;
    NSArray *otherTitles = nil;
    
    switch (style) {
        case WKAlertControllerStyleAlert:
            title = @"Alert";
            message = @"This is an alert";
            otherTitles = @[@"OK",@"Action"];
            break;
        case WKAlertControllerStyleSideBySideButtonsAlert:
            title = @"Side by Side";
            message = @"This is a side by side alert";
            cancelTitle = @"Nope";
            otherTitles = @[@"Yep"];
            break;
        case WKAlertControllerStyleActionSheet:
            title = @"Action Sheet";
            message = @"This is an action sheet";
            otherTitles = @[@"OK",@"Action",@"Another Action"];
            break;
        default:
            break;
    }
    
    [self KDI_presentAlertControllerWithStyle:style title:title message:message cancelButtonTitle:cancelTitle otherButtonTitles:otherTitles completion:^(WKAlertAction * _Nonnull alertAction, NSInteger buttonIndex) {
        KSTLog(@"alert action: %@ button index: %@",alertAction,@(buttonIndex));
    }];
}

@end



