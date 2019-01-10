//
//  RoundedImageViewController.m
//  Demo-iOS
//
//  Created by William Towe on 8/28/18.
//  Copyright © 2019 Kosoku Interactive, LLC. All rights reserved.
//
//  Redistribution and use in source and binary forms, with or without modification, are permitted provided that the following conditions are met:
//
//  1. Redistributions of source code must retain the above copyright notice, this list of conditions and the following disclaimer.
//
//  2. Redistributions in binary form must reproduce the above copyright notice, this list of conditions and the following disclaimer in the documentation and/or other materials provided with the distribution.
//
//  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

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
    
    [NSLayoutConstraint activateConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[top]-[view]" options:0 metrics:nil views:@{@"top": self.topLayoutGuide, @"view": self.roundedImageView}]];
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
