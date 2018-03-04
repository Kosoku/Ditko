//
//  TableViewController.m
//  Demo-iOS
//
//  Created by William Towe on 3/4/18.
//  Copyright © 2018 Kosoku Interactive, LLC. All rights reserved.
//
//  Redistribution and use in source and binary forms, with or without modification, are permitted provided that the following conditions are met:
//
//  1. Redistributions of source code must retain the above copyright notice, this list of conditions and the following disclaimer.
//
//  2. Redistributions in binary form must reproduce the above copyright notice, this list of conditions and the following disclaimer in the documentation and/or other materials provided with the distribution.
//
//  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

#import "TableViewController.h"

#import <Ditko/Ditko.h>
#import <KSOFontAwesomeExtensions/KSOFontAwesomeExtensions.h>

@interface TableViewController ()

@end

@implementation TableViewController

- (NSString *)title {
    return @"Table View";
}

- (instancetype)initWithStyle:(UITableViewStyle)style {
    if (!(self = [super initWithStyle:style]))
        return nil;
    
    [self setTabBarItem:[[UITabBarItem alloc] initWithTitle:self.title image:[[UIImage KSO_fontAwesomeImageWithIcon:(KSOFontAwesomeIcon)arc4random_uniform((uint32_t)KSO_FONT_AWESOME_ICON_TOTAL_ICONS) size:CGSizeMake(25, 25)] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate] tag:0]];
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.estimatedRowHeight = 44.0;
    [self.tableView registerClass:KDITableViewCell.class forCellReuseIdentifier:NSStringFromClass(KDITableViewCell.class)];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 25;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    KDITableViewCell *retval = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(KDITableViewCell.class) forIndexPath:indexPath];
    
    retval.icon = [UIImage KSO_fontAwesomeImageWithIcon:arc4random_uniform((uint32_t)KSO_FONT_AWESOME_ICON_TOTAL_ICONS) size:CGSizeMake(25.0, 25.0)].KDI_templateImage;
    retval.iconColor = KDIColorRandomRGB();
    retval.title = @"This is the title that will wrap to multiple lines if the screen width isn't enough";
    retval.subtitle = @"This is the subtitle that will wrap to multiple lines if the screen width isn't enough";
    retval.info = [NSNumberFormatter localizedStringFromNumber:@(indexPath.row) numberStyle:NSNumberFormatterDecimalStyle];
    
    return retval;
}


@end
