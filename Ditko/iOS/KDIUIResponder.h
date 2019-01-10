//
//  KDIUIResponder.h
//  Ditko
//
//  Created by William Towe on 9/2/17.
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

#import <Foundation/Foundation.h>

/**
 Notification posted when an object becomes first responder. The object of the notification should be the object that just became first responder.
 */
FOUNDATION_EXTERN NSNotificationName const KDIUIResponderNotificationDidBecomeFirstResponder;
/**
 Notification posted when an object resigns first responder. The object of the notification should be the object that just resigned first responder.
 */
FOUNDATION_EXTERN NSNotificationName const KDIUIResponderNotificationDidResignFirstResponder;

@protocol KDIUIResponder <NSObject>
@required
/**
 Method is called when the first responder status of the receiver changes.
 */
- (void)firstResponderDidChange;
@end
