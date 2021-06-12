//
//  KDINavigationBarTitleView.h
//  Ditko-iOS
//
//  Created by William Towe on 11/7/17.
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

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

/**
 KDINavigationBarTitleView is intended to be set as the titleView property of a UINavigationItem instance. It provides title and subtitle properties, by just setting the title alone, the appearance will match the standard UINavigationBar title. The title and subtitle are stacked vertically and centered horizontally with standard system spacing on the leading and trailing edges.
 */
@interface KDINavigationBarTitleView : UIView

/**
 Set and get the title. Appearance matches the standard UINavigationBar title appearance.
 
 The default is nil.
 */
@property (copy,nonatomic,nullable) NSString *title;
/**
 Set and get the subtitle.
 
 The default is nil.
 */
@property (copy,nonatomic,nullable) NSString *subtitle;

/**
 Set and get the title font.
 
 The default matches the UINavigationBar title font.
 */
@property (strong,nonatomic,null_resettable) UIFont *titleFont UI_APPEARANCE_SELECTOR;
/**
 Set and get the subtitle font.
 
 The default is [UIFont systemFontOfSize:13.0].
 */
@property (strong,nonatomic,null_resettable) UIFont *subtitleFont UI_APPEARANCE_SELECTOR;

/**
 Set and get the title text color.
 
 The default matches the UINavigationBar title text color.
 */
@property (strong,nonatomic,null_resettable) UIColor *titleTextColor UI_APPEARANCE_SELECTOR;
/**
 Set and get the subtitle text color.
 
 The default is UIColor.darkGrayColor.
 */
@property (strong,nonatomic,null_resettable) UIColor *subtitleTextColor UI_APPEARANCE_SELECTOR;

@end

NS_ASSUME_NONNULL_END
