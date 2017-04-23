//
//  KDINextPreviousInputAccessoryView.h
//  Ditko
//
//  Created by William Towe on 3/13/17.
//  Copyright © 2017 Kosoku Interactive, LLC. All rights reserved.
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
 Notification posted when the next item is tapped. The object of the notification is the instance of KDINextPreviousInputAccessoryView that posted the notification.
 */
FOUNDATION_EXPORT NSNotificationName const KDINextPreviousInputAccessoryViewNotificationNext;
/**
 Notification posted when the previous item is tapped. The object of the notification is the instance of KDINextPreviousInputAccessoryView that posted the notification.
 */
FOUNDATION_EXPORT NSNotificationName const KDINextPreviousInputAccessoryViewNotificationPrevious;
/**
 Notification posted when the done item is tapped. The object of the notification is the instance of KDINextPreviousInputAccessoryView that posted the notification.
 */
FOUNDATION_EXPORT NSNotificationName const KDINextPreviousInputAccessoryViewNotificationDone;

/**
 KDINextPreviousInputAccessoryView is a UIView subclass that manages a UIToolbar containing next, previous, and done bar button items. It posts appropriate notifications when any of the items are tapped. It automatically calls resignFirstResponder on its owning responder when the done item is tapped.
 */
@interface KDINextPreviousInputAccessoryView : UIView

/**
 Get the owning UIResponder of the receiver.
 */
@property (readonly,weak,nonatomic) UIResponder *responder;

/**
 The designated initializer. An instance of UIResponder must be provided in order for the Done button functionality to work properly.
 
 @param frame The frame of the receiver, safe to pass CGRectZero
 @param responder The UIResponder instance tied to the receiver
 @return An initialized instance
 */
- (instancetype)initWithFrame:(CGRect)frame responder:(UIResponder *)responder NS_DESIGNATED_INITIALIZER;

+ (instancetype)new NS_UNAVAILABLE;
- (instancetype)init __attribute__((unavailable("use initWithFrame:responder:")));
- (instancetype)initWithFrame:(CGRect)frame __attribute__((unavailable("use initWithResponder:frame:")));
- (nullable instancetype)initWithCoder:(NSCoder *)aDecoder __attribute__((unavailable("use initWithResponder:frame:")));

@end

NS_ASSUME_NONNULL_END
