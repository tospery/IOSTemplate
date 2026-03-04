Pod::Spec.new do |s|
  s.name             = 'RealmPlatform'
  s.version          = '1.0.0'
  s.summary          = 'Realm platform module.'
  s.description      = <<-DESC
						Realm platform module for project.
                       DESC
  s.homepage         = 'https://github.com/tospery/RealmPlatform'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'YangJianxiang' => 'tospery@gmail.com' }
  s.source           = { :git => 'https://github.com/tospery/RealmPlatform.git', :tag => s.version.to_s }

  s.requires_arc = true
  s.swift_version = '5.3'
  s.ios.deployment_target = '16.0'
  s.frameworks = 'Foundation'
  
  s.source_files = 'RealmPlatform/**/*'
  s.dependency 'Domain'
  s.dependency 'HiRealm', '~> 1.0'
  s.dependency 'Combine-Realm-Hi', '2.0.1-v2'
  
end
