//
//  RoundedImageViewController.m
//  Demo-iOS
//
//  Created by William Towe on 8/28/18.
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

#import "RoundedImageViewController.h"
#import "UIViewController+Extensions.h"

#import <Ditko/Ditko.h>

@interface RoundedImageViewController ()
@property (strong,nonatomic) KDIRoundedImageView *roundedImageView;
@end

@implementation RoundedImageViewController

- (NSString *)title {
    return [self.class detailViewTitle];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = UIColor.whiteColor;
    
    [self KSO_addNavigationBarTitleView];
    
    self.roundedImageView = [[KDIRoundedImageView alloc] initWithFrame:CGRectZero];
    self.roundedImageView.translatesAutoresizingMaskIntoConstraints = NO;
    self.roundedImageView.rounded = YES;
    [self.view addSubview:self.roundedImageView];
    
    [NSLayoutConstraint activateConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[top]-[view]" options:0 metrics:nil views:@{@"top": self.view.safeAreaLayoutGuide, @"view": self.roundedImageView}]];
    [NSLayoutConstraint activateConstraints:@[[self.roundedImageView.centerXAnchor constraintEqualToAnchor:self.view.centerXAnchor]]];
    
    NSURLSessionTask *task = [NSURLSession.sharedSession dataTaskWithURL:[NSURL URLWithString:@"https://picsum.photos/200"] completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        UIImage *image = [[UIImage alloc] initWithData:data];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            self.roundedImageView.image = image;
        });
    }];
    
    [task resume];
}

+ (NSString *)detailViewTitle {
    return @"KDIRoundedImageView";
}
+ (NSString *)detailViewSubtitle {
    return @"Rounded UIImageView subclass";
}

@end
