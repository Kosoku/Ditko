#
# Be sure to run `pod lib lint ${POD_NAME}.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'Ditko'
  s.version          = '0.1.0'
  s.summary          = 'Ditko is an iOS/macOS/tvOS/watchOS framework that extends the `AppKit`, `UIKit`, and `WatchKit` frameworks.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
Ditko is an iOS/macOS/tvOS/watchOS framework that extends the `AppKit`, `UIKit`, and `WatchKit` frameworks. It includes macros, functions, categories and classes that accelerate common development tasks. For example, a category on `UIColor` and `NSColor` to quickly create instances given RBBA or HSBA components.
                       DESC

  s.homepage         = 'https://github.com/Kosoku/Ditko'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'BSD', :file => 'license.txt' }
  s.author           = { 'William Towe' => 'willbur1984@gmail.com' }
  s.source           = { :git => 'https://github.com/Kosoku/Ditko.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '10.0'
  s.osx.deployment_target = '10.12'
  s.tvos.deployment_target = '10.0'
  s.watchos.deployment_target = '3.0'
  
  s.requires_arc = true

  s.source_files = 'Ditko/**/*.{h,m}'
  s.exclude_files = 'Ditko/Ditko-Info.h'
  s.ios.exclude_files = 'Ditko/macOS'
  s.osx.exclude_files = 'Ditko/iOS'
  s.tvos.exclude_files = 'Ditko/macOS'
  s.watchos.exclude_files = 'Ditko/macOS', 'Ditko/iOS/UIBarButtonItem+KDIExtensions.{h,m}', 'Ditko/iOS/UIDevice+KDIExtensions.{h,m}', 'Ditko/iOS/UINavigationController+KDIExtensions.{h,m}', 'Ditko/iOS/UIView+KDIExtensions.{h,m}', 'Ditko/iOS/UIViewController+KDIExtensions.{h,m}', 'Ditko/iOS/UIAlertController+KDIExtensions.{h,m}', 'Ditko/KDIView.{h,m}', 'Ditko/KDIGradientView.{h,m}'
  
  # s.resource_bundles = {
  #   '${POD_NAME}' => ['${POD_NAME}/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  s.ios.frameworks = 'UIKit'
  s.osx.frameworks = 'AppKit'
  s.tvos.frameworks = 'UIKit'
  s.watchos.frameworks = 'UIKit', 'WatchKit'
  
  s.dependency 'Stanley'
end
