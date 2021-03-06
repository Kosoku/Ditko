//
//  TableViewController.m
//  Demo-iOS
//
//  Created by William Towe on 4/9/18.
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
@property (strong,nonatomic) KDIBadgeView *infoView;

- (instancetype)initWithTitle:(NSString *)title subtitle:(NSString *)subtitle info:(NSString *)info image:(UIImage *)image;
- (instancetype)initWithTitle:(NSString *)title subtitle:(NSString *)subtitle info:(NSString *)info image:(UIImage *)image useInfoView:(BOOL)useInfoView;
@end

@implementation TableRowModel
- (instancetype)initWithTitle:(NSString *)title subtitle:(NSString *)subtitle info:(NSString *)info image:(UIImage *)image; {
    return [self initWithTitle:title subtitle:subtitle info:info image:image useInfoView:NO];
}
- (instancetype)initWithTitle:(NSString *)title subtitle:(NSString *)subtitle info:(NSString *)info image:(UIImage *)image useInfoView:(BOOL)useInfoView; {
    if (!(self = [super init]))
        return nil;
    
    self.title = title;
    self.subtitle = subtitle;
    self.info = info;
    self.image = image;
    self.infoView = useInfoView ? ({
        KDIBadgeView *retval = [[KDIBadgeView alloc] initWithFrame:CGRectZero];
        
        retval.translatesAutoresizingMaskIntoConstraints = NO;
        retval.badge = info;
        retval.KDI_dynamicTypeTextStyle = UIFontTextStyleFootnote;
        
        retval;
    }) : nil;
    
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
                            [[TableRowModel alloc] initWithTitle:@"Title" subtitle:nil info:@"Info" image:nil useInfoView:YES],
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
    retval.infoView = model.infoView;
    
    return retval;
}

@end
