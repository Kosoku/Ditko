//
//  NSParagraphStyle+KDIExtensions.m
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

#import "NSParagraphStyle+KDIExtensions.h"

@implementation NSParagraphStyle (KDIExtensions)

+ (NSParagraphStyle *)KDI_paragraphStyleWithCenterTextAlignment; {
    return [self KDI_paragraphStyleWithTextAlignment:NSTextAlignmentCenter];
}
+ (NSParagraphStyle *)KDI_paragraphStyleWithRightTextAlignment; {
    return [self KDI_paragraphStyleWithTextAlignment:NSTextAlignmentRight];
}
+ (NSParagraphStyle *)KDI_paragraphStyleWithTextAlignment:(NSTextAlignment)textAlignment; {
    NSMutableParagraphStyle *retval = [[NSParagraphStyle defaultParagraphStyle] mutableCopy];
    
    [retval setAlignment:textAlignment];
    
    return [retval copy];
}

@end
