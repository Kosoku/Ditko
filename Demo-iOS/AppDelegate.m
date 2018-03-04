//
//  AppDelegate.m
//  DitkoDemo-iOS
//
//  Created by William Towe on 3/8/17.
//  Copyright © 2017 Kosoku Interactive, LLC. All rights reserved.
//
//  Redistribution and use in source and binary forms, with or without modification, are permitted provided that the following conditions are met:
//
//  1. Redistributions of source code must retain the above copyright notice, this list of conditions and the following disclaimer.
//
//  2. Redistributions in binary form must reproduce the above copyright notice, this list of conditions and the following disclaimer in the documentation and/or other materials provided with the distribution.
//
//  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

#import "AppDelegate.h"
#import "ViewController.h"
#import "EmptyViewController.h"
#import "DominantTestViewController.h"
#import "TextViewController.h"
#import "ButtonViewController.h"
#import "TableViewController.h"

#import <Ditko/Ditko.h>

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    UIColor *barTintColor = KDIColorRandomRGB();
    
    [UINavigationBar.appearance setBarTintColor:barTintColor];
    [UITabBar.appearance setBarTintColor:barTintColor];
    
    [self setWindow:[[KDIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds]];
    
    [self.window setTintColor:[barTintColor KDI_contrastingColor]];
    
    UITabBarController *controller = [[UITabBarController alloc] init];
    UINavigationController *navigationController = [[UINavigationController alloc] initWithNavigationBarClass:[KDIProgressNavigationBar class] toolbarClass:Nil];
    
    [navigationController setViewControllers:@[[[ViewController alloc] init]]];
    
    [controller setViewControllers:@[navigationController,
                                     [[UINavigationController alloc] initWithRootViewController:[[TableViewController alloc] initWithStyle:UITableViewStylePlain]],
                                     [[UINavigationController alloc] initWithRootViewController:[[EmptyViewController alloc] init]],
                                     [[UINavigationController alloc] initWithRootViewController:[[DominantTestViewController alloc] init]],
                                     [[UINavigationController alloc] initWithRootViewController:[[TextViewController alloc] init]],
                                     [[UINavigationController alloc] initWithRootViewController:[[ButtonViewController alloc] init]]]];
    
    [controller setSelectedIndex:1];
    
    [self.window setRootViewController:controller];
    [self.window makeKeyAndVisible];
    
    return YES;
}

@end
