//
//  TextViewController.m
//  Demo-iOS
//
//  Created by William Towe on 4/10/18.
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

#import "TextViewController.h"
#import "Constants.h"
#import "UIViewController+Extensions.h"

#import <Ditko/Ditko.h>

@interface TextViewController ()
@property (weak,nonatomic) IBOutlet KDITextView *textView;
@end

@implementation TextViewController

- (NSString *)title {
    return [self.class detailViewTitle];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self KSO_addNavigationBarTitleView];
    
    self.textView.textContainerInset = UIEdgeInsetsMake(kSubviewMargin, kSubviewMargin, 0, kSubviewMargin);
    self.textView.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"This is a placeholder that will wrap to multiple lines because it is so long" attributes:@{NSFontAttributeName: [UIFont italicSystemFontOfSize:17.0], NSForegroundColorAttributeName: KDIColorRandomRGB()}];
}

+ (NSString *)detailViewTitle {
    return @"KDITextView";
}
+ (NSString *)detailViewSubtitle {
    return @"UITextView with placeholder";
}

@end
