//
//  KDITableViewCell.h
//  Ditko
//
//  Created by William Towe on 3/4/18.
//  Copyright © 2019 Kosoku Interactive, LLC. All rights reserved.
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
 KDITableViewCell is a UITableViewCell subclass that can display generic properties that can be used in a variety of situations. The layout is similar to Settings type cells, image aligned to the leading edge, title and subtitle after it stacked vertically and info aligned to the trailing edge. Internally the layout uses multiple stack views, so setting any of the value properties to nil will hide the corresponding subviews.
 */
@interface KDITableViewCell : UITableViewCell

/**
 Set and get whether the receiver should show its selected state using its accessoryType property. If YES, it will set its selectionStyle to UITableViewCellSelectionStyleNone and its accessoryType to UITableViewCellAccessoryCheckmark when selected or UITableViewCellAccessoryNone otherwise.
 
 The default is NO.
 */
@property (assign,nonatomic) BOOL showsSelectionUsingAccessoryType;

/**
 Set and get the arbitrary context data associated with the receiver. Useful for a subclass to pass additional data if needed to update its properties.
 
 The default is nil.
 */
@property (strong,nonatomic,nullable) id context;

/**
 Set and get the icon of the receiver. Aligned against the leading edge of the receiver.
 
 The default is nil.
 */
@property (strong,nonatomic,nullable) UIImage *icon;
/**
 Set and get the title of the receiver. Aligned against the trailing edge of the icon. This supports multiline text.
 
 The default is nil.
 */
@property (copy,nonatomic,nullable) NSString *title;
/**
 Set and get the maximum number of lines for the title text. This controls whether the title text wraps.
 
 The default is 0.
 */
@property (assign,nonatomic) NSInteger titleNumberOfLines;
/**
 Set and get the subtitle of the receiver. Aligned against the trailing edge of the icon and bottom edge of the title. This supports multiline text.
 
 The default is nil.
 */
@property (copy,nonatomic,nullable) NSString *subtitle;
/**
 Set and get the maximum number of lines for the subtitle text. This controls whether the subtitle text wraps.
 
 The default is 0.
 */
@property (assign,nonatomic) NSInteger subtitleNumberOfLines;
/**
 Set and get the info of the receiver. Aligned against the trailing edge of the receiver.
 
 The default is nil.
 */
@property (copy,nonatomic,nullable) NSString *info;

/**
 Set and get the custom info view for the receiver. It is laid out in the same way as the info label is and replaces it.
 
 The default is nil.
 */
@property (strong,nonatomic,nullable) __kindof UIView *infoView;

/**
 The tintColor to apply to the icon. Ensure your images are template images for them to render correctly. The defaults to the system returned value for tintColor.
 
 The default is nil.
 */
@property (strong,nonatomic,nullable) UIColor *iconColor UI_APPEARANCE_SELECTOR;
/**
 The title text color.
 
 The default is UIColor.blackColor.
 */
@property (strong,nonatomic,null_resettable) UIColor *titleColor UI_APPEARANCE_SELECTOR;
/**
 The subtitle text color.
 
 The default is UIColor.darkGrayColor.
 */
@property (strong,nonatomic,null_resettable) UIColor *subtitleColor UI_APPEARANCE_SELECTOR;
/**
 The info text color.
 
 The default is UIColor.lightGrayColor.
 */
@property (strong,nonatomic,null_resettable) UIColor *infoColor UI_APPEARANCE_SELECTOR;

/**
 The title text style to use when determining the title font.
 
 The default is UIFontTextStyleBody.
 */
@property (copy,nonatomic,null_resettable) UIFontTextStyle titleTextStyle UI_APPEARANCE_SELECTOR;
/**
 The subtitle text style to use when determining the subtitle font.
 
 The default is UIFontTextStyleFootnote.
 */
@property (copy,nonatomic,null_resettable) UIFontTextStyle subtitleTextStyle UI_APPEARANCE_SELECTOR;
/**
 The info text style to use when determining the info font.
 
 The default is UIFontTextStyleFootnote.
 */
@property (copy,nonatomic,null_resettable) UIFontTextStyle infoTextStyle UI_APPEARANCE_SELECTOR;

/**
 The name of the class that should be used for the selectedBackgroundView of the receiver. It must be a subclass of UIView.
 
 The default is nil;
 */
@property (copy,nonatomic,nullable) NSString *selectedBackgroundViewClassName UI_APPEARANCE_SELECTOR;

/**
 Set and get the horizontal margin between subviews.
 
 The default is 8.0.
 */
@property (assign,nonatomic) CGFloat horizontalMargin UI_APPEARANCE_SELECTOR;
/**
 Set and get the vertical margin between subviews.
 
 The default is 4.0.
 */
@property (assign,nonatomic) CGFloat verticalMargin UI_APPEARANCE_SELECTOR;
/**
 Set and get the minimum icon size.
 
 The default is CGSizeZero, which means no minimum.
 */
@property (assign,nonatomic) CGSize minimumIconSize UI_APPEARANCE_SELECTOR;
/**
 Set and get the maximum icon size.
 
 The default is CGSizeZero, which means no maximum.
 */
@property (assign,nonatomic) CGSize maximumIconSize UI_APPEARANCE_SELECTOR;

/**
 Set and get the icon accessibility label. If this is nil, the icon will be hidden from the accessibility client.

 The default is nil.
 */
@property (copy,nonatomic,nullable) NSString *iconAccessibilityLabel;

@end

NS_ASSUME_NONNULL_END
