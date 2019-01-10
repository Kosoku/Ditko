//
//  KDIFunctions.m
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

#import "KDIFunctions.h"

CGFloat KDIMainScreenScale(void) {
    return KDIScreenScale(nil);
}
#if (TARGET_OS_WATCH)
CGFloat KDIScreenScale(WKInterfaceDevice * _Nullable screen) {
    if (screen == nil) {
        screen = WKInterfaceDevice.currentDevice;
    }
    
    return screen.screenScale;
}
#elif (TARGET_OS_IOS || TARGET_OS_TV)
CGFloat KDIScreenScale(UIScreen * _Nullable screen) {
    if (screen == nil) {
        screen = UIScreen.mainScreen;
    }
    
    return screen.scale;
}
#else
CGFloat KDIScreenScale(NSScreen * _Nullable screen) {
    if (screen == nil) {
        screen = NSScreen.mainScreen;
    }
    
    return screen.backingScaleFactor;
}
#endif

CGSize KDICGSizeAdjustedForMainScreenScale(CGSize size) {
    return KDICGSizeAdjustedForScreenScale(size, nil);
}
#if (TARGET_OS_WATCH)
CGSize KDICGSizeAdjustedForScreenScale(CGSize size, WKInterfaceDevice *screen) {
    CGFloat scale = KDIScreenScale(screen);
    
    return CGSizeMake(size.width * scale, size.height * scale);
}
#elif (TARGET_OS_IOS || TARGET_OS_TV)
CGSize KDICGSizeAdjustedForScreenScale(CGSize size, UIScreen *screen) {
    CGFloat scale = KDIScreenScale(screen);
    
    return CGSizeMake(size.width * scale, size.height * scale);
}
#else
CGSize KDICGSizeAdjustedForScreenScale(CGSize size, NSScreen *screen) {
    CGFloat scale = KDIScreenScale(screen);
    
    return CGSizeMake(size.width * scale, size.height * scale);
}
#endif

#if (TARGET_OS_IOS || TARGET_OS_TV)
NSString* _Nullable KDITextFromTextInput(id<UITextInput> textInput) {
    UITextRange *textRange = [textInput textRangeFromPosition:textInput.beginningOfDocument toPosition:textInput.endOfDocument];
    
    return [textInput textInRange:textRange];
}
NSRange KDISelectedRangeFromTextInput(id<UITextInput> textInput) {
    UITextPosition *beginning = textInput.beginningOfDocument;
    
    UITextRange *selectedRange = textInput.selectedTextRange;
    UITextPosition *selectionStart = selectedRange.start;
    UITextPosition *selectionEnd = selectedRange.end;
    
    NSInteger location = [textInput offsetFromPosition:beginning toPosition:selectionStart];
    NSInteger length = [textInput offsetFromPosition:selectionStart toPosition:selectionEnd];
    
    return NSMakeRange(location, length);
}
UITextRange* KDITextRangeFromTextInputRange(id<UITextInput> textInput, NSRange range) {
    UITextPosition *start = [textInput positionFromPosition:textInput.beginningOfDocument offset:range.location];
    UITextPosition *end = [textInput positionFromPosition:start offset:range.length];
    
    return [textInput textRangeFromPosition:start toPosition:end];
}
#endif
