Pod::Spec.new do |s|
  s.name             = 'NetworkPlatform'
  s.version          = '1.0.0'
  s.summary          = 'Data Access Layer.'
  s.description      = <<-DESC
						Data Access Layer for Network.
                       DESC
  s.homepage         = 'https://github.com/tospery/NetworkPlatform'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'YangJianxiang' => 'tospery@gmail.com' }
  s.source           = { :git => 'https://github.com/tospery/NetworkPlatform.git', :tag => s.version.to_s }

  s.requires_arc = true
  s.swift_version = '5.3'
  s.ios.deployment_target = '16.0'
  s.frameworks = 'Foundation'
  
  s.source_files = 'NetworkPlatform/**/*'
  s.dependency 'Domain'
  s.dependency 'HiCore', '~> 1.0'
  s.dependency 'HiNet/Combine', '~> 1.0'
  
end
