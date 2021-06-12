//
//  NSTextField+KDIExtensions.m
//  Ditko
//
//  Created by William Towe on 4/5/17.
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

#import "NSTextField+KDIExtensions.h"

@implementation NSTextField (KDIExtensions)

@dynamic KDI_backgroundStyle;
- (NSBackgroundStyle)KDI_backgroundStyle {
    return self.cell.backgroundStyle;
}
- (void)setKDI_backgroundStyle:(NSBackgroundStyle)KDI_backgroundStyle {
    [self.cell setBackgroundStyle:KDI_backgroundStyle];
}

+ (instancetype)KDI_labelWithText:(NSString *)text; {
    return [self KDI_labelWithText:text font:nil alignment:0 lineBreakMode:0];
}
+ (instancetype)KDI_labelWithText:(NSString *)text font:(nullable NSFont *)font; {
    return [self KDI_labelWithText:text font:font alignment:0 lineBreakMode:0];
}
+ (instancetype)KDI_labelWithText:(NSString *)text font:(nullable NSFont *)font alignment:(NSTextAlignment)alignment; {
    return [self KDI_labelWithText:text font:font alignment:alignment lineBreakMode:0];
}
+ (instancetype)KDI_labelWithText:(NSString *)text font:(NSFont *)font alignment:(NSTextAlignment)alignment lineBreakMode:(NSLineBreakMode)lineBreakMode; {
    NSTextField *retval = [[self alloc] initWithFrame:NSZeroRect];
    
    [retval setStringValue:text];
    [retval setFont:font ?: [NSFont messageFontOfSize:0.0]];
    [retval setAlignment:alignment];
    [retval.cell setLineBreakMode:lineBreakMode];
    [retval setBezeled:NO];
    [retval setBordered:NO];
    [retval setDrawsBackground:NO];
    [retval setEditable:NO];
    [retval setSelectable:NO];
    
    return retval;
}

@end
