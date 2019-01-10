//
//  NSSavePanel+KDIExtensions.m
//  Ditko
//
//  Created by William Towe on 4/19/17.
//  Copyright © 2019 Kosoku Interactive, LLC. All rights reserved.
//
//  Redistribution and use in source and binary forms, with or without modification, are permitted provided that the following conditions are met:
//
//  1. Redistributions of source code must retain the above copyright notice, this list of conditions and the following disclaimer.
//
//  2. Redistributions in binary form must reproduce the above copyright notice, this list of conditions and the following disclaimer in the documentation and/or other materials provided with the distribution.
//
//  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

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
        
        self.completion(self.savePanel, result == NSFileHandlingPanelOKButton ? self.savePanel.URL : nil);
    }];
}
- (void)presentSavePanelAsSheet {
    kstWeakify(self);
    [self.savePanel beginSheetModalForWindow:[NSWindow KDI_windowForPresenting] completionHandler:^(NSInteger result) {
        kstStrongify(self);
        [self.savePanel orderOut:nil];
        
        self.completion(self.savePanel, result == NSFileHandlingPanelOKButton ? self.savePanel.URL : nil);
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
