//
//  KDILocalizedStrings.h
//  Ditko
//
//  Created by William Towe on 9/17/17.
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

#ifndef __KDI_LOCALIZED_STRINGS__
#define __KDI_LOCALIZED_STRINGS__

#import <Foundation/Foundation.h>
#import "NSBundle+KDIPrivateExtensions.h"

#define KDILocalizedStringErrorAlertDefaultSingleCancelButtonTitle() NSLocalizedStringWithDefaultValue(@"error.alert.cancel-button-title.single", nil, [NSBundle KDI_frameworkBundle], @"Ok", @"default error alert single cancel button title")
#define KDILocalizedStringErrorAlertDefaultMultipleCancelButtonTitle() NSLocalizedStringWithDefaultValue(@"error.alert.cancel-button-title.multiple", nil, [NSBundle KDI_frameworkBundle], @"Cancel", @"default error alert multiple cancel button title")

#endif
