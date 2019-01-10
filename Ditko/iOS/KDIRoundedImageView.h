//
//  KDIRoundedImageView.h
//  Ditko
//
//  Created by William Towe on 8/17/18.
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

/**
 KDIRoundedImageView is a UIImageView subclass with an optional circular mask, managed through the CALayer mask property. If you instead want a UIImageView with rounded corners, use cornerRadius and masksToBounds properties on CALayer instead.
 */
@interface KDIRoundedImageView : UIImageView

/**
 Whether the receiver is rounded.
 
 The default is NO.
 */
@property (assign,nonatomic,getter=isRounded) BOOL rounded;

@end
