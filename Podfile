source 'https://github.com/CocoaPods/Specs.git'
source 'https://github.com/aliyun/aliyun-specs.git'

platform :ios, '16.0'
use_frameworks!
inhibit_all_warnings!

target 'IOSTemplate' do
  
  # pod 'HiBase', :path => '../HiBase'
  # pod 'HiCore', :path => '../HiCore'
  # pod 'HiNav/Combine', :path => '../HiNav'
  # pod 'HiNet/Combine', :path => '../HiNet'
  # pod 'HiResource', :path => '../HiResource'
  # pod 'HiSwiftUI', :path => '../HiSwiftUI'
  # pod 'HiStats/Console', :path => '../HiStats'
  # pod 'HiLog/SwiftyBeaver', :path => '../HiLog'
  
  pod 'HiSwiftUI', '1.2.0'
  pod 'HiLog/SwiftyBeaver', '~> 1.0'
  pod 'HiStats/Console', '~> 1.0'

  pod 'Domain', :path => './Domain'
  pod 'NetworkPlatform', :path => './NetworkPlatform'
  pod 'DatabasePlatform', :path => './DatabasePlatform'
  
  pod 'R.swift', '~> 7.0'
  pod 'AlertToast-Hi', '~> 1.3.9'
  pod 'ExytePopupView', '~> 3.1'
  pod 'Parchment', '~> 4.0'
  pod 'SwiftUIFlowLayout', '~> 1.0'
  pod 'SVGView', '~> 1.0'
  pod 'SwiftUI-WebView-Hi', '~> 0.3.0'
  
  # pod 'FancyScrollView-Hi', '0.1.4-v1'
  # pod 'DateToolsSwift-Hi', '5.0.0-v6'
  # pod 'CodeEditor-Hi', '~> 1.2.6'
  # pod 'PDFViewer-Hi', '~> 1.0.2'
  # pod 'SwiftSoup', '~> 2.0'
  
  # Test
  pod 'FLEX', '~> 5.0'
  pod 'GDPerformanceView-Swift', '~> 2.0'
  pod 'FBRetainCycleDetector', :git => "https://github.com/facebook/FBRetainCycleDetector.git", :commit => 'd1951bf'
  # 阿里云
  # pod 'AlicloudAPM', '~> 1.1.0'
  # pod 'AlicloudCrash', '~> 1.2.0'
  # pod 'AlicloudTLog', '~> 1.0.0'
  # pod 'AlicloudFeedback', '~> 3.0'
  # pod 'AlicloudMANLight', '~> 1.0'
  # pod 'AlicloudUT', '~> 5.2.0'
  # pod 'AliyunOSSiOS', :source => 'https://github.com/aliyun/aliyun-specs.git'
  # 友盟
  pod 'UMCommon', '~> 7.5.0'
  pod 'UMDevice', '~> 3.4.0'
  # Mob
  # pod 'MOBFoundation', '~> 20241207'
  # pod 'mob_sharesdk', '~> 4.4.0'
  # pod 'mob_sharesdk/ShareSDKExtension', '~> 4.4.0'
  # pod 'mob_sharesdk/ShareSDKPlatforms/SMS', '~> 4.4.0'
  # pod 'mob_sharesdk/ShareSDKPlatforms/Mail', '~> 4.4.0'
  # pod 'mob_sharesdk/ShareSDKPlatforms/WeChat', '~> 4.4.0'
  # pod 'mob_sharesdk/ShareSDKPlatforms/Twitter', '~> 4.4.0'
end

post_install do |installer|
  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
      config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '16.0'
    end
  end
end