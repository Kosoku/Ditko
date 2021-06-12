//
//  NSSavePanel+KDIExtensions.h
//  Ditko
//
//  Created by William Towe on 4/19/17.
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
