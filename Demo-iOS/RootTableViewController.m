//
//  RootTableViewController.m
//  Demo-iOS
//
//  Created by William Towe on 4/9/18.
//  Copyright © 2019 Kosoku Interactive, LLC. All rights reserved.
//
//  Redistribution and use in source and binary forms, with or without modification, are permitted provided that the following conditions are met:
//
//  1. Redistributions of source code must retain the above copyright notice, this list of conditions and the following disclaimer.
//
//  2. Redistributions in binary form must reproduce the above copyright notice, this list of conditions and the following disclaimer in the documentation and/or other materials provided with the distribution.
//
//  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.s

#import "RootTableViewController.h"
#import "TableViewController.h"
#import "AccessoryViewController.h"
#import "ViewController.h"
#import "GradientViewController.h"
#import "BadgeViewController.h"
#import "LabelViewController.h"
#import "BadgeButtonViewController.h"
#import "TextViewController.h"
#import "ProgressSliderViewController.h"
#import "ButtonViewController.h"
#import "PickerViewController.h"
#import "DatePickerViewController.h"
#import "ProgressNavigationBarViewController.h"
#import "EmptyViewController.h"
#import "ViewControllerExtensionsViewController.h"
#import "TextFieldViewController.h"
#import "ColorExtensionsViewController.h"
#import "ImageExtensionsViewController.h"
#import "FontDynamicTypeExtensionsViewController.h"
#import "RoundedImageViewController.h"
#import "PreviewViewController.h"

#import <Ditko/Ditko.h>
#import <KSOFontAwesomeExtensions/KSOFontAwesomeExtensions.h>
#import <Loki/Loki.h>

@interface RootTableViewController ()
@property (copy,nonatomic) NSArray<Class<DetailViewController>> *detailViewClasses;
@end

@implementation RootTableViewController

- (NSString *)title {
    return @"Ditko";
}

- (instancetype)initWithStyle:(UITableViewStyle)style {
    if (!(self = [super initWithStyle:style]))
        return nil;
    
    self.tabBarItem = [[UITabBarItem alloc] initWithTitle:self.title image:[UIImage KLO_imageWithPDFAtURL:[NSBundle.mainBundle URLForResource:@"kosoku-logo" withExtension:@"pdf" subdirectory:@"Media"] size:CGSizeMake(25, 25)].KDI_templateImage selectedImage:nil];
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.detailViewClasses = @[FontDynamicTypeExtensionsViewController.class,
                               ImageExtensionsViewController.class,
                               ColorExtensionsViewController.class,
                               TextFieldViewController.class,
                               ViewControllerExtensionsViewController.class,
                               EmptyViewController.class,
                               ProgressNavigationBarViewController.class,
                               DatePickerViewController.class,
                               PickerViewController.class,
                               TableViewController.class,
                               AccessoryViewController.class,
                               ViewController.class,
                               GradientViewController.class,
                               BadgeViewController.class,
                               LabelViewController.class,
                               BadgeButtonViewController.class,
                               TextViewController.class,
                               ProgressSliderViewController.class,
                               ButtonViewController.class,
                               RoundedImageViewController.class,
                               PreviewViewController.class];
    
    self.tableView.estimatedRowHeight = 44.0;
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    [self.tableView registerClass:KDITableViewCell.class forCellReuseIdentifier:NSStringFromClass(KDITableViewCell.class)];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.detailViewClasses.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    KDITableViewCell *retval = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(KDITableViewCell.class) forIndexPath:indexPath];
    Class<DetailViewController> detailViewClass = self.detailViewClasses[indexPath.row];
    
    retval.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    retval.title = [detailViewClass detailViewTitle];
    if ([detailViewClass respondsToSelector:@selector(detailViewSubtitle)]) {
        retval.subtitle = [detailViewClass detailViewSubtitle];
    }
    else {
        retval.subtitle = nil;
    }
    
    return retval;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self.navigationController pushViewController:[[(id)self.detailViewClasses[indexPath.row] alloc] initWithNibName:nil bundle:nil] animated:YES];
}

@end
