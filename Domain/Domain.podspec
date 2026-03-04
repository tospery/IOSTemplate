Pod::Spec.new do |s|
  s.name             = 'Domain'
  s.version          = '1.0.0'
  s.summary          = 'Domain layer.'
  s.description      = <<-DESC
						Domain layer for project.
                       DESC
  s.homepage         = 'https://github.com/tospery/Domain'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'YangJianxiang' => 'tospery@gmail.com' }
  s.source           = { :git => 'https://github.com/tospery/Domain.git', :tag => s.version.to_s }

  s.requires_arc = true
  s.swift_version = '5.3'
  s.ios.deployment_target = '16.0'
  s.frameworks = 'Foundation'
  
  s.source_files = 'Domain/**/*'
  s.dependency 'HiBase', '~> 1.0'
end
