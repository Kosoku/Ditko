//
//  UIBarButtonItem+DemoExtensions.m
//  Ditko
//
//  Created by William Towe on 8/23/17.
//  Copyright © 2017 Kosoku Interactive, LLC. All rights reserved.
//
//  Redistribution and use in source and binary forms, with or without modification, are permitted provided that the following conditions are met:
//
//  1. Redistributions of source code must retain the above copyright notice, this list of conditions and the following disclaimer.
//
//  2. Redistributions in binary form must reproduce the above copyright notice, this list of conditions and the following disclaimer in the documentation and/or other materials provided with the distribution.
//
//  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

#import "UIBarButtonItem+DemoExtensions.h"
#import "AccessoryView.h"

#import <Ditko/Ditko.h>
#import <Stanley/Stanley.h>
#import <KSOFontAwesomeExtensions/KSOFontAwesomeExtensions.h>

NSNotificationName const IOSDNotificationNameBadgeDidChange = @"IOSDNotificationNameBadgeDidChange";
NSString *const IOSDUserInfoKeyBadge = @"IOSDUserInfoKeyBadge";

NSString *kLastBadge = nil;

@interface BadgeBarButtonItem : UIBarButtonItem
@property (weak,nonatomic) UIViewController *viewController;

- (instancetype)initWithViewController:(UIViewController *)viewController;

- (void)_updateWithBadge:(NSString *)badge;
@end

@implementation BadgeBarButtonItem

- (instancetype)initWithViewController:(UIViewController *)viewController {
    if (!(self = [super init]))
        return nil;
    
    _viewController = viewController;
    
    [self _updateWithBadge:kLastBadge];
    
    [NSNotificationCenter.defaultCenter addObserver:self selector:@selector(_badgeDidChange:) name:IOSDNotificationNameBadgeDidChange object:nil];
    
    return self;
}

- (void)_updateWithBadge:(NSString *)badge; {
    if (badge.length == 0) {
        [self setImage:nil];
        [self setTitle:@""];
        return;
    }
    
    UIFont *font = [UIFont boldSystemFontOfSize:11.0];
    CGSize size = [badge sizeWithAttributes:@{NSFontAttributeName: font}];
    CGRect rect = CGRectMake(0, 0, size.width + 8.0, size.height + 8.0);
    
    UIGraphicsBeginImageContextWithOptions(rect.size, NO, 0.0);
    
    UIColor *backgroundColor = self.viewController.view.backgroundColor ?: UIColor.redColor;
    
    [backgroundColor setFill];
    [[UIBezierPath bezierPathWithRoundedRect:rect cornerRadius:MIN(size.width, size.height) / 2.0] fill];
    
    [badge drawInRect:KSTCGRectCenterInRect(CGRectMake(0, 0, size.width, size.height), rect) withAttributes:@{NSFontAttributeName: font, NSForegroundColorAttributeName: [backgroundColor KDI_contrastingColor]}];
    
    UIImage *image = [UIGraphicsGetImageFromCurrentImageContext() imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    UIGraphicsEndImageContext();
    
    [self setImage:image];
    
    [self.viewController.navigationController.navigationBar setNeedsLayout];
}

- (void)_badgeDidChange:(NSNotification *)note {
    NSString *badge = note.userInfo[IOSDUserInfoKeyBadge];
    
    kLastBadge = badge;
    
    [self _updateWithBadge:badge];
}

@end

@implementation UIBarButtonItem (DemoExtensions)

+ (UIBarButtonItem *)iosd_backBarButtonItemWithViewController:(UIViewController *)viewController {
    BadgeBarButtonItem *retval = [[BadgeBarButtonItem alloc] initWithViewController:viewController];
    
    return retval;
}

+ (UIBarButtonItem *)iosd_toggleWindowAccessoryViewBarButtonItem; {
    return [UIBarButtonItem KDI_barButtonItemWithImage:[UIImage KSO_fontAwesomeSolidImageWithString:@"\uf095" size:CGSizeMake(25, 25)].KDI_templateImage style:UIBarButtonItemStylePlain block:^(__kindof UIBarButtonItem * _Nonnull barButtonItem) {
        KDIWindow *window = (KDIWindow *)UIApplication.sharedApplication.delegate.window;
        
        if (window.accessoryView == nil) {
            [window setAccessoryView:[[AccessoryView alloc] initWithFrame:CGRectZero]];
        }
        else {
            [window setAccessoryView:nil];
        }
    }];
}

@end
