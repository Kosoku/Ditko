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
 Options mask describing the items that can be displayed in the input accessory view.
 */
typedef NS_OPTIONS(NSUInteger, KDINextPreviousInputAccessoryViewItemOptions) {
    /**
     No items are displayed.
     */
    KDINextPreviousInputAccessoryViewItemOptionsNone = 0,
    /**
     The next item (right facing arrow) is displayed.
     */
    KDINextPreviousInputAccessoryViewItemOptionsNext = 1 << 0,
    /**
     The previous item (left facing arrow) is displayed.
     */
    KDINextPreviousInputAccessoryViewItemOptionsPrevious = 1 << 1,
    /**
     The done item is displayed.
     */
    KDINextPreviousInputAccessoryViewItemOptionsDone = 1 << 2,
    /**
     All items are displayed.
     */
    KDINextPreviousInputAccessoryViewItemOptionsAll = KDINextPreviousInputAccessoryViewItemOptionsNext|KDINextPreviousInputAccessoryViewItemOptionsPrevious|KDINextPreviousInputAccessoryViewItemOptionsDone
};

/**
 Notification posted when the next item is tapped. The object of the notification is the instance of KDINextPreviousInputAccessoryView that posted the notification.
 */
UIKIT_EXTERN NSNotificationName const KDINextPreviousInputAccessoryViewNotificationNext;
/**
 Notification posted when the previous item is tapped. The object of the notification is the instance of KDINextPreviousInputAccessoryView that posted the notification.
 */
UIKIT_EXTERN NSNotificationName const KDINextPreviousInputAccessoryViewNotificationPrevious;
/**
 Notification posted when the done item is tapped. The object of the notification is the instance of KDINextPreviousInputAccessoryView that posted the notification.
 */
UIKIT_EXTERN NSNotificationName const KDINextPreviousInputAccessoryViewNotificationDone;

/**
 KDINextPreviousInputAccessoryView is a UIView subclass that manages a UIToolbar containing next, previous, and done bar button items. It posts appropriate notifications when any of the items are tapped. It automatically calls resignFirstResponder on its owning responder when the done item is tapped.
 */
@interface KDINextPreviousInputAccessoryView : UIView

/**
 Set and get the next item image. Set this to non-nil if you wish to use a custom image for the next item. A default image is used if this is nil.
 */
@property (class,strong,nonatomic,nullable) UIImage *nextItemImage;
/**
 Set and get the previous item image. Set this to non-nil if you wish to use a custom image for the previous item. A default image is used if this is nil.
 */
@property (class,strong,nonatomic,nullable) UIImage *previousItemImage;
/**
 Set and get the done item image. Set this to non-nil if you wish to use a custom image for the done item. The default UIBarButtonItemStyleDone style is used if this is nil.
 */
@property (class,strong,nonatomic,nullable) UIImage *doneItemImage;

/**
 Get the owning UIResponder of the receiver.
 */
@property (readonly,weak,nonatomic) UIResponder *responder;
/**
 Set and get the item options of the receiver, which affect the toolbar items shown.
 
 The default is KDINextPreviousInputAccessoryViewItemOptionsAll.
 
 @see KDINextPreviousInputAccessoryViewItemOptions
 */
@property (assign,nonatomic) KDINextPreviousInputAccessoryViewItemOptions itemOptions;

/**
 Get the next bar button item that corresponds to the KDINextPreviousInputAccessoryViewItemOptionsNext option.
 */
@property (readonly,strong,nonatomic) UIBarButtonItem *nextItem;
/**
 Get the previous bar button item that corresponds to the KDINextPreviousInputAccessoryViewItemOptionsPrevious option.
 */
@property (readonly,strong,nonatomic) UIBarButtonItem *previousItem;
/**
 Get the done bar button item that corresponds to the KDINextPreviousInputAccessoryViewItemOptionsDone option.
 */
@property (readonly,strong,nonatomic) UIBarButtonItem *doneItem;

/**
 Set and get the toolbar items of the receiver. Setting this will override setting itemOptions above. Setting itemOptions will update this property.
 
 The default are items corresponding to KDINextPreviousInputAccessoryViewItemOptionsAll.
 */
@property (copy,nonatomic,nullable) NSArray<UIBarButtonItem *> *toolbarItems;

/**
 The designated initializer. An instance of UIResponder must be provided in order for the Done button functionality to work properly.
 
 @param frame The frame of the receiver, safe to pass CGRectZero
 @param responder The UIResponder instance tied to the receiver
 @return An initialized instance
 */
- (instancetype)initWithFrame:(CGRect)frame responder:(UIResponder *)responder NS_DESIGNATED_INITIALIZER;

- (instancetype)initWithFrame:(CGRect)frame NS_UNAVAILABLE;
- (nullable instancetype)initWithCoder:(NSCoder *)aDecoder NS_UNAVAILABLE;
- (instancetype)init NS_UNAVAILABLE;
+ (instancetype)new NS_UNAVAILABLE;

@end

@interface NSObject (KDINextPreviousInputAccessoryViewExtensions)

/**
 Registers the receiver to handle next/previous notifications for the array of *responders*. This method will automatically handle moving to the next/previous responder based on the order in the provided array.
 
 @param responders The array of responders to consider for next/previous notifications
 */
- (void)KDI_registerForNextPreviousNotificationsWithResponders:(NSArray<UIResponder *> *)responders;
/**
 Unregister the receiver for next/previous notifications. You are not required to call this method, it exists if you want to manually stop next/previous observation for the previously passed list of responders.
 */
- (void)KDI_unregisterForNextPreviousNotifications;

@end

NS_ASSUME_NONNULL_END
