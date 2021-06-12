//
//  UIDevice+KDIExtensions.m
//  Ditko
//
//  Created by William Towe on 3/10/17.
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

#import "UIDevice+KDIExtensions.h"

#import <sys/sysctl.h>

@interface UIDevice (KDIPrivateExtensions)
+ (NSString *)_KDI_sysInfoForName:(const char *)name;
@end

@implementation UIDevice (KDIExtensions)

+ (NSString *)KDI_hardwareMachineName; {
    return [self _KDI_sysInfoForName:"hw.machine"];
}
+ (NSString *)KDI_hardwareModelName; {
    return [self _KDI_sysInfoForName:"hw.model"];
}

@end

@implementation UIDevice (KDIPrivateExtensions)

+ (NSString *)_KDI_sysInfoForName:(const char *)name; {
    size_t size;
    sysctlbyname(name, NULL, &size, NULL, 0);
    
    char *retval = malloc(size);
    sysctlbyname(name, retval, &size, NULL, 0);
    
    NSString *results = [NSString stringWithCString:retval encoding:NSUTF8StringEncoding];
    
    free(retval);
    
    return results;
}

@end
