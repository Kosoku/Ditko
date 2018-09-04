Pod::Spec.new do |s|
  s.name             = 'Ditko'
  s.version          = '3.33.1'
  s.summary          = 'Ditko is an iOS/macOS/tvOS/watchOS framework that extends the AppKit, UIKit, and WatchKit frameworks.'
  s.description      = <<-DESC
Ditko is an iOS/macOS/tvOS/watchOS framework that extends the `AppKit`, `UIKit`, and `WatchKit` frameworks. It includes macros, functions, categories and classes that accelerate common development tasks. For example, a category on `UIColor` and `NSColor` to quickly create instances given RBBA or HSBA components.
                       DESC

  s.homepage         = 'https://github.com/Kosoku/Ditko'
  s.screenshots      = ['https://github.com/Kosoku/Ditko/raw/master/screenshots/iOS-1.png','https://github.com/Kosoku/Ditko/raw/master/screenshots/iOS-2.png','https://github.com/Kosoku/Ditko/raw/master/screenshots/iOS-3.png']
  s.license          = { :type => 'BSD', :file => 'license.txt' }
  s.author           = { 'William Towe' => 'willbur1984@gmail.com' }
  s.source           = { :git => 'https://github.com/Kosoku/Ditko.git', :tag => s.version.to_s }

  s.ios.deployment_target = '10.0'
  s.osx.deployment_target = '10.12'
  s.tvos.deployment_target = '10.0'
  s.watchos.deployment_target = '3.0'
  
  s.requires_arc = true

  s.source_files = 'Ditko/**/*.{h,m}'
  s.exclude_files = 'Ditko/Ditko-Info.h'
  s.ios.exclude_files = 'Ditko/macOS', 'Ditko/watchOS'
  s.osx.exclude_files = 'Ditko/iOS', 'Ditko/watchOS'
  s.tvos.exclude_files = 'Ditko/macOS', 'Ditko/watchOS', 'Ditko/iOS/UIViewController+KDIUIImagePickerControllerExtensions.{h,m}', 'Ditko/iOS/KDIProgressSlider.{h,m}', 'Ditko/iOS/KDIPickerViewButton.{h,m}', 'Ditko/iOS/KDIDatePickerButton.{h,m}', 'Ditko/iOS/KDINextPreviousInputAccessoryView.{h,m}', 'Ditko/iOS/KDIWindow.{h,m}', 'Ditko/iOS/KDIScrollView.{h,m}'
  s.watchos.exclude_files = 'Ditko/macOS', 'Ditko/iOS/UIBarButtonItem+KDIExtensions.{h,m}', 'Ditko/iOS/UIControl+KDIExtensions.{h,m}', 'Ditko/iOS/UIDevice+KDIExtensions.{h,m}', 'Ditko/iOS/UINavigationController+KDIExtensions.{h,m}', 'Ditko/iOS/UIView+KDIExtensions.{h,m}', 'Ditko/iOS/UIViewController+KDIExtensions.{h,m}', 'Ditko/iOS/UIAlertController+KDIExtensions.{h,m}', 'Ditko/iOS/UIFont+KDIDynamicTypeExtensions.{h,m}', 'Ditko/iOS/UIGestureRecognizer+KDIExtensions.{h,m}', 'Ditko/iOS/UIViewController+KDIUIImagePickerControllerExtensions.{h,m}', 'Ditko/KDIView.{h,m}', 'Ditko/KDIGradientView.{h,m}', 'Ditko/KDIBadgeView.{h,m}', 'Ditko/iOS/KDILabel.{h,m}', 'Ditko/iOS/KDITextField.{h,m}', 'Ditko/iOS/KDITextView.{h,m}', 'Ditko/iOS/KDIProgressSlider.{h,m}', 'Ditko/iOS/KDIProgressNavigationBar.{h,m}', 'Ditko/iOS/KDIButton.{h,m}', 'Ditko/iOS/KDIBadgeButton.{h,m}', 'Ditko/iOS/KDIPickerViewButton.{h,m}', 'Ditko/iOS/KDIDatePickerButton.{h,m}', 'Ditko/iOS/KDINextPreviousInputAccessoryView.{h,m}', 'Ditko/iOS/KDIEmptyView.{h,m}', 'Ditko/Private/KDIBorderedViewImpl.{h,m}', 'Ditko/KDIBorderedView.{h,m}', 'Ditko/iOS/KDIWindow.{h,m}', 'Ditko/iOS/KDINavigationBarTitleView.{h,m}', 'Ditko/iOS/KDIScrollView.{h,m}', 'Ditko/NSObject+KDIExtensions.{h,m}', 'Ditko/iOS/KDITableViewCell.{h,m}', 'Ditko/iOS/UIScrollView+KDIExtensions.{h,m}', 'Ditko/iOS/UIFont+KDIExtensions.h', 'Ditko/UIFont-NSFont+KDIExtensions.m', 'Ditko/iOS/UITableView+KDIExtensions.{h,m}', 'Ditko/iOS/KDIRoundedImageView.{h,m}'
  s.private_header_files = 'Ditko/Private/*.h'
  
  s.resource_bundles = {
    'Ditko' => ['Ditko/**/*.{lproj}']
  }

  s.ios.frameworks = 'UIKit'
  s.osx.frameworks = 'AppKit'
  s.tvos.frameworks = 'UIKit'
  s.watchos.frameworks = 'UIKit', 'WatchKit'
  
  s.dependency 'Stanley'
  s.dependency 'Loki'
  s.ios.dependency 'KSOFontAwesomeExtensions'
end
