//
//  NSSavePanel+KDIExtensions.h
//  Ditko
//
//  Created by William Towe on 4/19/17.
//  Copyright © 2018 Kosoku Interactive, LLC. All rights reserved.
//
//  Redistribution and use in source and binary forms, with or without modification, are permitted provided that the following conditions are met:
//
//  1. Redistributions of source code must retain the above copyright notice, this list of conditions and the following disclaimer.
//
//  2. Redistributions in binary form must reproduce the above copyright notice, this list of conditions and the following disclaimer in the documentation and/or other materials provided with the distribution.
//
//  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

#import <AppKit/AppKit.h>

NS_ASSUME_NONNULL_BEGIN

/**
 Block that is invoked when panel:validateURL:error: NSOpenSavePanelDelegate method would be called. The block should return YES if the URL is valid, otherwise NO. Optionally an NSError can be returned by reference if the block returns NO. The block will be invoked once when the user clicks the save button.
 
 @param savePanel The save panel instance
 @param URL The URL for validate
 @param outError A pointer to an NSError that can be used to return additional information when returning NO
 @return YES if the URL is valid, otherwise NO
 */
typedef BOOL(^KDINSSavePanelValidateURLBlock)(NSSavePanel *savePanel, NSURL *URL, NSError **outError);
/**
 Block that is invoked when the save pabel is dismissed by the user. The URL will be nil if the user clicked the cancel button, otherwise it will point to where the file should be saved.
 
 @param savePanel The save panel instance
 @param URL The URL where to save the file
 */
typedef void(^KDINSSavePanelCompletionBlock)(NSSavePanel *savePanel, NSURL * _Nullable URL);

@interface NSSavePanel (KDIExtensions)

/**
 Present the save panel modally invoking the provided *completion* block when the user dismisses the panel. The *validateURLBlock* will be invoked before the panel is dismissed if non-nil.
 
 @param validateURLBlock The block that is invoked to validate the URL
 @param completion The block that is invoked when the panel is dismissed
 */
- (void)KDI_presentModallyWithValidateURLBlock:(nullable KDINSSavePanelValidateURLBlock)validateURLBlock completion:(KDINSSavePanelCompletionBlock)completion;
/**
 Present the save panel as a sheet on the key/main window invoking the provided *completion* block when the user dismisses the panel. The *validateURLBlock* will be invoked before the panel is dismissed if non-nil.
 
 @param validateURLBlock The block that is invoked to validate the URL
 @param completion The block that is invoked when the panel is dismissed
 */
- (void)KDI_presentAsSheetWithValidateURLBlock:(nullable KDINSSavePanelValidateURLBlock)validateURLBlock completion:(KDINSSavePanelCompletionBlock)completion;

@end

NS_ASSUME_NONNULL_END
