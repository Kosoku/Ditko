//
//  KDINextPreviousInputAccessoryView.m
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

#import "KDINextPreviousInputAccessoryView.h"
#import "UIBarButtonItem+KDIExtensions.h"
#import "NSBundle+KDIPrivateExtensions.h"

NSNotificationName const KDINextPreviousInputAccessoryViewNotificationNext = @"KDINextPreviousInputAccessoryViewNotificationNext";
NSNotificationName const KDINextPreviousInputAccessoryViewNotificationPrevious = @"KDINextPreviousInputAccessoryViewNotificationPrevious";
NSNotificationName const KDINextPreviousInputAccessoryViewNotificationDone = @"KDINextPreviousInputAccessoryViewNotificationDone";

static CGFloat kDefaultFrameHeight;

@interface KDINextPreviousInputAccessoryView ()
@property (readwrite,weak,nonatomic) UIResponder *responder;

@property (strong,nonatomic) UIToolbar *toolbar;
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
    
    _toolbar = [[UIToolbar alloc] initWithFrame:CGRectZero];
    [_toolbar setTranslatesAutoresizingMaskIntoConstraints:NO];
    [_toolbar setItems:@[[[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"arrow_left" inBundle:[NSBundle KDI_frameworkBundle] compatibleWithTraitCollection:nil] style:UIBarButtonItemStylePlain target:self action:@selector(_previousItemAction:)],
                         [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"arrow_right" inBundle:[NSBundle KDI_frameworkBundle] compatibleWithTraitCollection:nil] style:UIBarButtonItemStylePlain target:self action:@selector(_nextItemAction:)],
                         [UIBarButtonItem KDI_flexibleSpaceBarButtonItem],
                         [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(_doneItemAction:)]]];
    [_toolbar sizeToFit];
    [self addSubview:_toolbar];
    
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[view]|" options:0 metrics:nil views:@{@"view": _toolbar}]];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[view(==height)]|" options:0 metrics:@{@"height": @(kDefaultFrameHeight)} views:@{@"view": _toolbar}]];
    
    return self;
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
