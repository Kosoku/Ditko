//
//  KDIView.h
//  Ditko
//
//  Created by William Towe on 3/8/17.
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

#import <Ditko/KDIBorderedView.h>

NS_ASSUME_NONNULL_BEGIN

#if (TARGET_OS_OSX)
/**
 Options mask describing the state of the receiver.
 */
typedef NS_OPTIONS(NSUInteger, KDIViewState) {
    /**
     The view has no state.
     */
    KDIViewStateNone = 0,
    /**
     The app is active.
     */
    KDIViewStateActive = 1 << 0,
    /**
     The view's window is the main window.
     */
    KDIViewStateMain = 1 << 1,
    /**
     The view's window is the key window.
     */
    KDIViewStateKey = 1 << 2,
    /**
     The view is the current first responder.
     */
    KDIViewStateFirstResponder = 1 << 3
};

/**
 Notification that is posted when the state of the receiver changes.
 */
APPKIT_EXTERN NSNotificationName const KDIViewNotificationDidChangeState;
#endif

/**
 KDIView is a UIView/NSView subclass that provides state change methods on macOS. It also conforms to KDIBorderedView, allowing it to display borders.
 */
@interface KDIView : KDIViewClass <KDIBorderedView>

/**
 Set and get the background color of the receiver.
 
 Equivalent to backgroundColor on UIView.
 */
#if (TARGET_OS_OSX)
@property (readonly,assign,nonatomic) KDIViewState state;

@property (strong,nonatomic,nullable) NSColor *backgroundColor;
#endif

#if (TARGET_OS_IPHONE)
- (void)layoutSubviews NS_REQUIRES_SUPER;
#else
- (BOOL)becomeFirstResponder NS_REQUIRES_SUPER;
- (BOOL)resignFirstResponder NS_REQUIRES_SUPER;
- (void)drawRect:(NSRect)dirtyRect NS_REQUIRES_SUPER;
#endif

@end

NS_ASSUME_NONNULL_END
