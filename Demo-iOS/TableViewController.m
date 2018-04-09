//
//  TableViewController.m
//  Demo-iOS
//
//  Created by William Towe on 4/9/18.
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
#import "Constants.h"
#import "UIViewController+Extensions.h"

#import <KSOFontAwesomeExtensions/KSOFontAwesomeExtensions.h>
#import <Ditko/Ditko.h>

@interface TableRowModel : NSObject
@property (copy,nonatomic) NSString *title;
@property (copy,nonatomic) NSString *subtitle;
@property (copy,nonatomic) NSString *info;
@property (strong,nonatomic) UIImage *image;

- (instancetype)initWithTitle:(NSString *)title subtitle:(NSString *)subtitle info:(NSString *)info image:(UIImage *)image;
@end

@implementation TableRowModel
- (instancetype)initWithTitle:(NSString *)title subtitle:(NSString *)subtitle info:(NSString *)info image:(UIImage *)image; {
    if (!(self = [super init]))
        return nil;
    
    self.title = title;
    self.subtitle = subtitle;
    self.info = info;
    self.image = image;
    
    return self;
}
@end

@interface TableViewController ()
@property (copy,nonatomic) NSArray<TableRowModel *> *tableRowModels;
@end

@implementation TableViewController

- (NSString *)title {
    return [self.class detailViewTitle];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self KSO_addNavigationBarTitleView];
    
    self.tableRowModels = @[[[TableRowModel alloc] initWithTitle:@"Title" subtitle:nil info:nil image:nil],
                            [[TableRowModel alloc] initWithTitle:@"Title" subtitle:nil info:nil image:[UIImage KSO_fontAwesomeSolidImageWithString:@"\uf2b9" size:kBarButtonItemImageSize].KDI_templateImage],
                            [[TableRowModel alloc] initWithTitle:@"Title" subtitle:@"Subtitle" info:nil image:nil],
                            [[TableRowModel alloc] initWithTitle:@"Title" subtitle:@"Subtitle" info:nil image:[UIImage KSO_fontAwesomeSolidImageWithString:@"\uf2b9" size:kBarButtonItemImageSize].KDI_templateImage],
                            [[TableRowModel alloc] initWithTitle:@"Title" subtitle:nil info:@"Info" image:nil],
                            [[TableRowModel alloc] initWithTitle:@"Title" subtitle:nil info:@"Info" image:[UIImage KSO_fontAwesomeSolidImageWithString:@"\uf2b9" size:kBarButtonItemImageSize].KDI_templateImage],
                            [[TableRowModel alloc] initWithTitle:@"Title" subtitle:@"Subtitle" info:@"Info" image:nil],
                            [[TableRowModel alloc] initWithTitle:@"Title" subtitle:@"Subtitle" info:@"Info" image:[UIImage KSO_fontAwesomeSolidImageWithString:@"\uf2b9" size:kBarButtonItemImageSize].KDI_templateImage]];
    
    self.tableView.estimatedRowHeight = 44.0;
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    [self.tableView registerClass:KDITableViewCell.class forCellReuseIdentifier:NSStringFromClass(KDITableViewCell.class)];
}

+ (NSString *)detailViewTitle {
    return @"KDITableViewCell";
}
+ (NSString *)detailViewSubtitle {
    return @"Configurable UITableViewCell subclass";
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.tableRowModels.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    KDITableViewCell *retval = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(KDITableViewCell.class) forIndexPath:indexPath];
    TableRowModel *model = self.tableRowModels[indexPath.row];
    
    retval.title = model.title;
    retval.subtitle = model.subtitle;
    retval.info = model.info;
    retval.icon = model.image;
    
    return retval;
}

@end
