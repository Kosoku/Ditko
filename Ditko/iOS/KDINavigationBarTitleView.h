//
//  KDINavigationBarTitleView.h
//  Ditko-iOS
//
//  Created by William Towe on 11/7/17.
//  Copyright © 2018 Kosoku Interactive, LLC. All rights reserved.
//
//  Redistribution and use in source and binary forms, with or without modification, are permitted provided that the following conditions are met:
//
//  1. Redistributions of source code must retain the above copyright notice, this list of conditions and the following disclaimer.
//
//  2. Redistributions in binary form must reproduce the above copyright notice, this list of conditions and the following disclaimer in the documentation and/or other materials provided with the distribution.
//
//  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

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
