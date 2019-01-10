//
//  Ditko.h
//  Ditko
//
//  Created by William Towe on 3/8/17.
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

#import <TargetConditionals.h>

#if (TARGET_OS_IPHONE)
#import <UIKit/UIKit.h>
#else
#import <AppKit/AppKit.h>
#endif

//! Project version number for Ditko.
FOUNDATION_EXPORT double DitkoVersionNumber;

//! Project version string for Ditko.
FOUNDATION_EXPORT const unsigned char DitkoVersionString[];

// In this header, you should import all the public headers of your framework using statements like #import <Ditko/PublicHeader.h>

#import <Ditko/KDIColorMacros.h>

#import <Ditko/KDIFunctions.h>

#import <Ditko/NSURL+KDIExtensions.h>
#import <Ditko/NSParagraphStyle+KDIExtensions.h>
#if (TARGET_OS_IOS || TARGET_OS_TV || TARGET_OS_OSX)
#import <Ditko/NSObject+KDIExtensions.h>
#endif
#if (TARGET_OS_IOS || TARGET_OS_TV || TARGET_OS_WATCH)
#import <Ditko/UIBezierPath+KDIExtensions.h>
#import <Ditko/UIImage+KDIExtensions.h>
#endif
#if (TARGET_OS_IOS || TARGET_OS_TV)
#import <Ditko/UIBarButtonItem+KDIExtensions.h>
#import <Ditko/UIControl+KDIExtensions.h>
#import <Ditko/UIDevice+KDIExtensions.h>
#import <Ditko/UINavigationController+KDIExtensions.h>
#import <Ditko/UIView+KDIExtensions.h>
#import <Ditko/UIViewController+KDIExtensions.h>
#import <Ditko/UIAlertController+KDIExtensions.h>
#import <Ditko/UIGestureRecognizer+KDIExtensions.h>
#import <Ditko/UIFont+KDIDynamicTypeExtensions.h>
#import <Ditko/UIScrollView+KDIExtensions.h>
#import <Ditko/UIFont+KDIExtensions.h>
#import <Ditko/UITableView+KDIExtensions.h>
#import <Ditko/UITextField+KDIExtensions.h>
#import <Ditko/UIImageView+KDIExtensions.h>
#endif
#if (TARGET_OS_OSX)
#import <Ditko/NSView+KDIExtensions.h>
#import <Ditko/NSViewController+KDIExtensions.h>
#import <Ditko/NSWindow+KDIExtensions.h>
#import <Ditko/NSBezierPath+KDIExtensions.h>
#import <Ditko/NSAlert+KDIExtensions.h>
#import <Ditko/NSSavePanel+KDIExtensions.h>
#import <Ditko/NSControl+KDIExtensions.h>
#import <Ditko/NSTextField+KDIExtensions.h>
#import <Ditko/NSButton+KDIExtensions.h>
#import <Ditko/NSPopUpButton+KDIExtensions.h>
#import <Ditko/NSGestureRecognizer+KDIExtensions.h>
#import <Ditko/NSImage+KDIExtensions.h>
#import <Ditko/NSFont+KDIExtensions.h>
#endif
#if (TARGET_OS_IOS)
#import <Ditko/KDIPickerViewButton+KDIExtensions.h>
#import <Ditko/UIViewController+KDIUIImagePickerControllerExtensions.h>
#import <Ditko/UIViewController+KDIMFMailComposeViewControllerExtensions.h>
#import <Ditko/UIViewController+KDIQLPreviewControllerExtensions.h>
#endif
#if (TARGET_OS_WATCH)
#import <Ditko/WKInterfaceController+KDIExtensions.h>
#endif

#if (TARGET_OS_IOS || TARGET_OS_TV || TARGET_OS_OSX)
#import <Ditko/KDIView.h>
#import <Ditko/KDIGradientView.h>
#import <Ditko/KDIBadgeView.h>
#endif
#if (TARGET_OS_IOS || TARGET_OS_TV)
#import <Ditko/KDILabel.h>
#import <Ditko/KDITextView.h>
#import <Ditko/KDIProgressNavigationBar.h>
#import <Ditko/KDIButton.h>
#import <Ditko/KDIBadgeButton.h>
#import <Ditko/KDITextField.h>
#import <Ditko/KDIEmptyView.h>
#import <Ditko/KDINavigationBarTitleView.h>
#import <Ditko/KDITableViewCell.h>
#import <Ditko/KDIRoundedImageView.h>
#endif
#if (TARGET_OS_IOS)
#import <Ditko/KDIWindow.h>
#import <Ditko/KDIScrollView.h>
#import <Ditko/KDIProgressSlider.h>
#import <Ditko/KDIPickerViewButton.h>
#import <Ditko/KDIDatePickerButton.h>
#import <Ditko/KDINextPreviousInputAccessoryView.h>
#endif
#if (TARGET_OS_OSX)
#import <Ditko/KDIRolloverButton.h>
#import <Ditko/KDIClickableLabel.h>
#endif
