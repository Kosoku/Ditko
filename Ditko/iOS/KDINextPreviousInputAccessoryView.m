//
//  KDINextPreviousInputAccessoryView.m
//  Ditko
//
//  Created by William Towe on 3/13/17.
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

#import "KDINextPreviousInputAccessoryView.h"
#import "UIBarButtonItem+KDIExtensions.h"
#import "NSBundle+KDIPrivateExtensions.h"
#import "UIImage+KDIExtensions.h"
#import "UIView+KDIExtensions.h"

#import <KSOFontAwesomeExtensions/KSOFontAwesomeExtensions.h>

#import <objc/runtime.h>

NSNotificationName const KDINextPreviousInputAccessoryViewNotificationNext = @"KDINextPreviousInputAccessoryViewNotificationNext";
NSNotificationName const KDINextPreviousInputAccessoryViewNotificationPrevious = @"KDINextPreviousInputAccessoryViewNotificationPrevious";
NSNotificationName const KDINextPreviousInputAccessoryViewNotificationDone = @"KDINextPreviousInputAccessoryViewNotificationDone";

CGSize const kImageSize = {.width=25.0, .height=25.0};

static CGFloat kDefaultFrameHeight;

@interface KDINextPreviousInputAccessoryView ()
@property (readwrite,weak,nonatomic) UIResponder *responder;

@property (strong,nonatomic) UIToolbar *toolbar;

- (void)_updateToolbarItems;
@end

@implementation KDINextPreviousInputAccessoryView

+ (void)initialize {
    if (self == [KDINextPreviousInputAccessoryView class]) {
        kDefaultFrameHeight = [[[UIToolbar alloc] initWithFrame:CGRectZero] sizeThatFits:CGSizeZero].height;
    }
}

- (instancetype)initWithFrame:(CGRect)frame responder:(UIResponder *)responder {
    if (!(self = [super initWithFrame:CGRectMake(0, 0, CGRectGetWidth([UIScreen mainScreen].bounds), kDefaultFrameHeight)]))
        return nil;
    
    [self setBackgroundColor:[UIColor clearColor]];
    
    _responder = responder;
    _itemOptions = KDINextPreviousInputAccessoryViewItemOptionsAll;
    
    _toolbar = [[UIToolbar alloc] initWithFrame:self.bounds];
    [_toolbar setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self _updateToolbarItems];
    [self addSubview:_toolbar];
    
    [NSLayoutConstraint activateConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[view]|" options:0 metrics:nil views:@{@"view": _toolbar}]];
    [NSLayoutConstraint activateConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[view]|" options:0 metrics:nil views:@{@"view": _toolbar}]];
    
    return self;
}

- (void)setItemOptions:(KDINextPreviousInputAccessoryViewItemOptions)itemOptions {
    if (_itemOptions == itemOptions) {
        return;
    }
    
    _itemOptions = itemOptions;
    
    [self _updateToolbarItems];
}

- (UIBarButtonItem *)nextItem {
    UIImage *image = [self.class nextItemImage] ?: [UIImage KSO_fontAwesomeSolidImageWithString:@"\uf054" size:kImageSize].KDI_templateImage;
    UIBarButtonItem *retval = [[UIBarButtonItem alloc] initWithImage:image style:UIBarButtonItemStylePlain target:self action:@selector(_nextItemAction:)];
    
    retval.accessibilityLabel = NSLocalizedStringWithDefaultValue(@"accessibility.label.next", nil, NSBundle.KDI_frameworkBundle, @"Next", @"accessibility label next");
    
    return retval;
}
- (UIBarButtonItem *)previousItem {
    UIImage *image = [self.class previousItemImage] ?: [UIImage KSO_fontAwesomeSolidImageWithString:@"\uf053" size:kImageSize].KDI_templateImage;
    UIBarButtonItem *retval = [[UIBarButtonItem alloc] initWithImage:image style:UIBarButtonItemStylePlain target:self action:@selector(_previousItemAction:)];
    
    retval.accessibilityLabel = NSLocalizedStringWithDefaultValue(@"accessibility.label.previous", nil, NSBundle.KDI_frameworkBundle, @"Previous", @"accessibility label previous");
    
    return retval;
}
- (UIBarButtonItem *)doneItem {
    if ([self.class doneItemImage] == nil) {
        return [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(_doneItemAction:)];
    }
    else {
        UIBarButtonItem *retval = [[UIBarButtonItem alloc] initWithImage:[self.class doneItemImage] style:UIBarButtonItemStyleDone target:self action:@selector(_doneItemAction:)];
     
        retval.accessibilityLabel = NSLocalizedStringWithDefaultValue(@"accessibility.label.done", nil, NSBundle.KDI_frameworkBundle, @"Done", @"accessibility label done");
        
        return retval;
    }
}

- (void)setToolbarItems:(NSArray<UIBarButtonItem *> *)toolbarItems {
    [self.toolbar setItems:toolbarItems];
}

- (void)_updateToolbarItems {
    NSMutableArray *items = [[NSMutableArray alloc] init];
    
    if (self.itemOptions & KDINextPreviousInputAccessoryViewItemOptionsPrevious) {
        [items addObject:self.previousItem];
    }
    if (self.itemOptions & KDINextPreviousInputAccessoryViewItemOptionsNext) {
        [items addObject:self.nextItem];
    }
    
    [items addObject:[UIBarButtonItem KDI_flexibleSpaceBarButtonItem]];
    
    if (self.itemOptions & KDINextPreviousInputAccessoryViewItemOptionsDone) {
        [items addObject:self.doneItem];
    }
    
    [self setToolbarItems:items];
}

static void const *kNextItemImageKey = &kNextItemImageKey;
+ (UIImage *)nextItemImage {
    return objc_getAssociatedObject(self, kNextItemImageKey);
}
+ (void)setNextItemImage:(UIImage *)nextItemImage {
    objc_setAssociatedObject(self, kNextItemImageKey, nextItemImage, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
static void const *kPreviousItemImageKey = &kPreviousItemImageKey;
+ (UIImage *)previousItemImage {
    return objc_getAssociatedObject(self, kPreviousItemImageKey);
}
+ (void)setPreviousItemImage:(UIImage *)previousItemImage {
    objc_setAssociatedObject(self, kPreviousItemImageKey, previousItemImage, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
static void const *kDoneItemImageKey = &kDoneItemImageKey;
+ (UIImage *)doneItemImage {
    return objc_getAssociatedObject(self, kDoneItemImageKey);
}
+ (void)setDoneItemImage:(UIImage *)doneItemImage {
    objc_setAssociatedObject(self, kDoneItemImageKey, doneItemImage, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (IBAction)_previousItemAction:(id)sender {
    [[NSNotificationCenter defaultCenter] postNotificationName:KDINextPreviousInputAccessoryViewNotificationPrevious object:self];
}
- (IBAction)_nextItemAction:(id)sender {
    [[NSNotificationCenter defaultCenter] postNotificationName:KDINextPreviousInputAccessoryViewNotificationNext object:self];
}
- (IBAction)_doneItemAction:(id)sender {
    [self.responder resignFirstResponder];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:KDINextPreviousInputAccessoryViewNotificationDone object:self];
}

@end

@interface KDINextPreviousInputAccessoryViewNotificationWrapper : NSObject
@property (copy,nonatomic) NSArray<UIResponder *> *responders;
- (instancetype)initWithResponders:(NSArray<UIResponder *> *)responders;
@end

@interface NSObject (KDINextPreviousInputAccessoryViewExtensionsPrivate)
@property (strong,nonatomic) KDINextPreviousInputAccessoryViewNotificationWrapper *KDI_nextPreviousInputAccessoryViewNotificationWrapper;
@end

@implementation NSObject (KDINextPreviousInputAccessoryViewExtensions)
- (void)KDI_registerForNextPreviousNotificationsWithResponders:(NSArray<UIResponder *> *)responders {
    [self setKDI_nextPreviousInputAccessoryViewNotificationWrapper:[[KDINextPreviousInputAccessoryViewNotificationWrapper alloc] initWithResponders:responders]];
}
- (void)KDI_unregisterForNextPreviousNotifications; {
    [self setKDI_nextPreviousInputAccessoryViewNotificationWrapper:nil];
}
@end

@implementation KDINextPreviousInputAccessoryViewNotificationWrapper
- (void)dealloc {
    [NSNotificationCenter.defaultCenter removeObserver:self];
}

- (instancetype)initWithResponders:(NSArray<UIResponder *> *)responders {
    if (!(self = [super init]))
        return nil;
    
    _responders = [responders copy];
    
    [NSNotificationCenter.defaultCenter addObserver:self selector:@selector(_nextPreviousNotification:) name:KDINextPreviousInputAccessoryViewNotificationNext object:nil];
    [NSNotificationCenter.defaultCenter addObserver:self selector:@selector(_nextPreviousNotification:) name:KDINextPreviousInputAccessoryViewNotificationPrevious object:nil];
    
    return self;
}

- (void)_nextPreviousNotification:(NSNotification *)note {
    KDINextPreviousInputAccessoryView *accessoryView = note.object;
    __block UIResponder *view = nil;
    
    [self.responders enumerateObjectsUsingBlock:^(UIResponder * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([accessoryView.responder isEqual:obj]) {
            view = obj;
            *stop = YES;
        }
    }];
    
    NSInteger index = [self.responders indexOfObject:view];
    
    if (index == NSNotFound) {
        return;
    }
    
    if ([note.name isEqualToString:KDINextPreviousInputAccessoryViewNotificationNext]) {
        if ((++index) == self.responders.count) {
            index = 0;
        }
    }
    else {
        if ((--index) < 0) {
            index = self.responders.count - 1;
        }
    }
    
    UIResponder *nextResponder = self.responders[index];
    
    if ([nextResponder isKindOfClass:UIView.class]) {
        UIView *nextView = (UIView *)nextResponder;
        UIScrollView *scrollView = [nextView KDI_enclosingScrollView];
        
        [scrollView scrollRectToVisible:[scrollView convertRect:nextView.bounds fromView:nextView] animated:YES];
    }
    
    [nextResponder becomeFirstResponder];
}
@end

@implementation NSObject (KDINextPreviousInputAccessoryViewExtensionsPrivate)
static void const *KDI_nextPreviousInputAccessoryViewNotificationWrapperKey = &KDI_nextPreviousInputAccessoryViewNotificationWrapperKey;
- (KDINextPreviousInputAccessoryViewNotificationWrapper *)KDI_nextPreviousInputAccessoryViewNotificationWrapper {
    return objc_getAssociatedObject(self, KDI_nextPreviousInputAccessoryViewNotificationWrapperKey);
}
- (void)setKDI_nextPreviousInputAccessoryViewNotificationWrapper:(KDINextPreviousInputAccessoryViewNotificationWrapper *)KDI_nextPreviousInputAccessoryViewNotificationWrapper {
    objc_setAssociatedObject(self, KDI_nextPreviousInputAccessoryViewNotificationWrapperKey, KDI_nextPreviousInputAccessoryViewNotificationWrapper, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
@end
