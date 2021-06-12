//
//  AppDelegate.m
//  DitkoDemo-iOS
//
//  Created by William Towe on 3/8/17.
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

#import "AppDelegate.h"
#import "RootTableViewController.h"
#import "RootNavigationController.h"

#import <Ditko/Ditko.h>

@interface AppDelegate ()

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [self setWindow:[[KDIWindow alloc] initWithFrame:UIScreen.mainScreen.bounds]];
    
    UINavigationController *navigationController = [[RootNavigationController alloc] initWithNavigationBarClass:KDIProgressNavigationBar.class toolbarClass:Nil];
    
    navigationController.viewControllers = @[[[RootTableViewController alloc] initWithStyle:UITableViewStylePlain]];
    
    UITabBarController *tabBarController = [[UITabBarController alloc] initWithNibName:nil bundle:nil];
    
    tabBarController.viewControllers = @[navigationController];
    
    [self.window setRootViewController:tabBarController];
    [self.window makeKeyAndVisible];
    
    return YES;
}

@end
