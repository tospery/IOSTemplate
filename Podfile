source 'https://github.com/CocoaPods/Specs.git'
source 'https://github.com/aliyun/aliyun-specs.git'

platform :ios, '13.0'
use_frameworks!
inhibit_all_warnings!

target 'IOSTemplate' do

  # pod 'HiIOS', :path => '../HiIOS'
  pod 'HiIOS', '1.2.9' # 第一位针对架构、第二位针对项目、第三位针对故障

  # Base
  pod 'SwiftLint', '0.54.0'
  pod 'Umbrella/Core', '0.12.0'
  pod 'IQKeyboardManagerSwift', '6.5.11'
  pod 'RxGesture', '4.0.4'
  pod 'ReusableKit-Hi/RxSwift', '3.0.0-v4'
  pod 'R.swift', '6.1.0'
  pod 'SnapKit', '5.6.0'
  pod 'DefaultsKit', '0.2.0'
  
  # Debug
  pod 'FLEX', '5.22.10', :configurations => ['Debug']
  
  # Advanced
  pod 'TTTAttributedLabel', '2.0.0'
  pod 'Toast-Swift-Hi', '5.0.1-v3'
  pod 'SwiftEntryKit', '2.0.0'
  
  # Platform

end

post_install do |installer|
  installer.pods_project.build_configurations.each do |config|
    config.build_settings["EXCLUDED_ARCHS[sdk=iphonesimulator*]"] = "arm64"
  end
  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
      config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '13.0'
	  if config.base_configuration_reference.is_a? Xcodeproj::Project::Object::PBXFileReference
	    xcconfig_path = config.base_configuration_reference.real_path
	    IO.write(xcconfig_path, IO.read(xcconfig_path).gsub("DT_TOOLCHAIN_DIR", "TOOLCHAIN_DIR"))
	  end
    end
  end
  installer.aggregate_targets.each do |target|
    target.xcconfigs.each do |variant, xcconfig|
      xcconfig_path = target.client_root + target.xcconfig_relative_path(variant)
      IO.write(xcconfig_path, IO.read(xcconfig_path).gsub("DT_TOOLCHAIN_DIR", "TOOLCHAIN_DIR"))
    end
  end
  find_and_replace("Pods/FBRetainCycleDetector/FBRetainCycleDetector/Layout/Classes/FBClassStrongLayout.mm",
        "layoutCache[currentClass] = ivars;", "layoutCache[(id<NSCopying>)currentClass] = ivars;")
end

def find_and_replace(dir, findstr, replacestr)
  Dir[dir].each do |name|
      FileUtils.chmod("+w", name)
      text = File.read(name)
      replace = text.gsub(findstr,replacestr)
      if text != replace
          puts "Fix: " + name
          File.open(name, "w") { |file| file.puts replace }
          STDOUT.flush
      end
  end
  Dir[dir + '*/'].each(&method(:find_and_replace))
end
