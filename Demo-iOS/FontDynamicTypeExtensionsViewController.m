//
//  FontDynamicTypeExtensionsViewController.m
//  Demo-iOS
//
//  Created by William Towe on 4/11/18.
//  Copyright © 2018 Kosoku Interactive, LLC. All rights reserved.
//
//  Redistribution and use in source and binary forms, with or without modification, are permitted provided that the following conditions are met:
//
//  1. Redistributions of source code must retain the above copyright notice, this list of conditions and the following disclaimer.
//
//  2. Redistributions in binary form must reproduce the above copyright notice, this list of conditions and the following disclaimer in the documentation and/or other materials provided with the distribution.
//
//  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

#import "FontDynamicTypeExtensionsViewController.h"
#import "UIViewController+Extensions.h"

#import <Ditko/Ditko.h>

@interface FontDynamicTypeExtensionsViewController ()
@property (weak,nonatomic) IBOutlet UILabel *label;
@property (weak,nonatomic) IBOutlet UIButton *button;
@property (weak,nonatomic) IBOutlet UISegmentedControl *segmentedControl;
@property (weak,nonatomic) IBOutlet UITextField *textField;
@property (weak,nonatomic) IBOutlet KDITextView *textView;
@property (weak,nonatomic) IBOutlet KDIBadgeView *badgeView;
@end

@implementation FontDynamicTypeExtensionsViewController

- (NSString *)title {
    return [self.class detailViewTitle];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self KSO_addNavigationBarTitleView];
    
    self.textView.placeholder = @"Text View";
    
    self.badgeView.badge = @"Badge View";
    
    [NSObject KDI_registerDynamicTypeObjectsForTextStyles:@{UIFontTextStyleBody: @[self.textField,self.textView],
                                                            UIFontTextStyleCallout: @[self.button.titleLabel,self.segmentedControl],
                                                            UIFontTextStyleHeadline: @[self.label],
                                                            UIFontTextStyleCaption1: @[self.badgeView]
                                                            }];
}

+ (NSString *)detailViewTitle {
    return @"UIFont+KDIDynamicTypeExtensions";
}
+ (NSString *)detailViewSubtitle {
    return @"Dynamic type support for custom objects";
}

@end
