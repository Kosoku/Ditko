//
//  InterfaceController.m
//  DitkoDemo-watchOS Extension
//
//  Created by William Towe on 3/8/17.
//  Copyright © 2019 Kosoku Interactive, LLC. All rights reserved.
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



