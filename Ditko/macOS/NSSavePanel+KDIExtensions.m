//
//  NSSavePanel+KDIExtensions.m
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

#import "NSSavePanel+KDIExtensions.h"
#import "NSWindow+KDIExtensions.h"

#import <Stanley/KSTScopeMacros.h>

#import <objc/runtime.h>

@interface KDINSSavePanelDelegate : NSObject <NSOpenSavePanelDelegate>
@property (weak,nonatomic) NSSavePanel *savePanel;
@property (copy,nonatomic) KDINSSavePanelValidateURLBlock validateURL;
@property (copy,nonatomic) KDINSSavePanelCompletionBlock completion;

- (instancetype)initWithSavePanel:(NSSavePanel *)savePanel validateURL:(KDINSSavePanelValidateURLBlock)validateURL completion:(KDINSSavePanelCompletionBlock)completion;
- (void)presentSavePanelModally;
- (void)presentSavePanelAsSheet;
@end

@implementation KDINSSavePanelDelegate

- (BOOL)panel:(id)sender validateURL:(NSURL *)url error:(NSError * _Nullable __autoreleasing *)outError {
    if (self.validateURL != nil) {
        return self.validateURL(self.savePanel,url,outError);
    }
    return YES;
}
- (void)panel:(id)sender didChangeToDirectoryURL:(NSURL *)url {
    
}
- (NSString *)panel:(id)sender userEnteredFilename:(NSString *)filename confirmed:(BOOL)okFlag {
    return filename;
}
- (void)panelSelectionDidChange:(id)sender {
    
}

- (instancetype)initWithSavePanel:(NSSavePanel *)savePanel validateURL:(KDINSSavePanelValidateURLBlock)validateURL completion:(KDINSSavePanelCompletionBlock)completion; {
    if (!(self = [super init]))
        return nil;
    
    _savePanel = savePanel;
    _validateURL = [validateURL copy];
    _completion = [completion copy];
    
    if (_savePanel.delegate == nil) {
        [_savePanel setDelegate:self];
    }
    
    return self;
}

- (void)presentSavePanelModally; {
    kstWeakify(self);
    [self.savePanel beginWithCompletionHandler:^(NSInteger result) {
        kstStrongify(self);
        
        self.completion(self.savePanel, result == NSModalResponseOK ? self.savePanel.URL : nil);
    }];
}
- (void)presentSavePanelAsSheet {
    kstWeakify(self);
    [self.savePanel beginSheetModalForWindow:[NSWindow KDI_windowForPresenting] completionHandler:^(NSInteger result) {
        kstStrongify(self);
        [self.savePanel orderOut:nil];
        
        self.completion(self.savePanel, result == NSModalResponseOK ? self.savePanel.URL : nil);
    }];
}

@end

@interface NSSavePanel (KDIPrivateExtensions)
@property (strong,nonatomic) KDINSSavePanelDelegate *KDI_savePanelDelegate;
@end

@implementation NSSavePanel (KDIExtensions)

- (void)KDI_presentModallyWithValidateURLBlock:(KDINSSavePanelValidateURLBlock)validateURLBlock completion:(KDINSSavePanelCompletionBlock)completion; {
    KDINSSavePanelDelegate *delegate = [[KDINSSavePanelDelegate alloc] initWithSavePanel:self validateURL:validateURLBlock completion:completion];
    
    [self setKDI_savePanelDelegate:delegate];
    
    [delegate presentSavePanelModally];
}
- (void)KDI_presentAsSheetWithValidateURLBlock:(KDINSSavePanelValidateURLBlock)validateURLBlock completion:(KDINSSavePanelCompletionBlock)completion; {
    KDINSSavePanelDelegate *delegate = [[KDINSSavePanelDelegate alloc] initWithSavePanel:self validateURL:validateURLBlock completion:completion];
    
    [self setKDI_savePanelDelegate:delegate];
    
    [delegate presentSavePanelAsSheet];
}

@end

static void const *kKDI_savePanelDelegateKey = &kKDI_savePanelDelegateKey;

@implementation NSSavePanel (KDIPrivateExtensions)

@dynamic KDI_savePanelDelegate;
- (KDINSSavePanelDelegate *)KDI_savePanelDelegate {
    return objc_getAssociatedObject(self, kKDI_savePanelDelegateKey);
}
- (void)setKDI_savePanelDelegate:(KDINSSavePanelDelegate *)KDI_savePanelDelegate {
    objc_setAssociatedObject(self, kKDI_savePanelDelegateKey, KDI_savePanelDelegate, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end
