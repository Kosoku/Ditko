//
//  KDIProgressSlider.h
//  Ditko
//
//  Created by William Towe on 3/10/17.
//  Copyright © 2019 Kosoku Interactive, LLC. All rights reserved.
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
 KDIProgressSlider is a UISlider subclass that displays a loading progress in addition to minimum and maximum track.
 */
@interface KDIProgressSlider : UISlider

/**
 Set and get the progress of the receiver.
 */
@property (assign,nonatomic) float progress;
/**
 Set and get the progress ranges of the receiver, which should be an array containing arrays of two elements, the first being the start progress and the second being the end progress.
 */
@property (copy,nonatomic) NSArray<NSArray<NSNumber *> *> *progressRanges;

/**
 Set and get the minimum track fill color.
 
 The default is self.tintColor.
 */
@property (strong,nonatomic,null_resettable) UIColor *minimumTrackFillColor UI_APPEARANCE_SELECTOR;
/**
 Set and get the maximum track fill color.
 
 The default is [UIColor lightGrayColor];
 */
@property (strong,nonatomic,null_resettable) UIColor *maximumTrackFillColor UI_APPEARANCE_SELECTOR;
/**
 Set and get the progress fill color.
 
 The default is [UIColor whiteColor];
 */
@property (strong,nonatomic,null_resettable) UIColor *progressFillColor UI_APPEARANCE_SELECTOR;

@end

NS_ASSUME_NONNULL_END
