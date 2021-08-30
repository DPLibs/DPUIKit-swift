Pod::Spec.new do |s|
  s.name             = 'DPUIKit'
  s.version          = '1.0.0'
  s.summary          = 'DP UIKit'
  s.description      = 'A set of useful utilities'
  s.homepage         = 'https://github.com/DPLibs/DPUIKit'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Dmitriy Polyakov' => 'dmitriyap11@gmail.com' }
  s.source           = { :git => 'https://github.com/DPLibs/DPUIKit.git', :tag => s.version.to_s }
  s.ios.deployment_target = '11.0'
  s.source_files = 'DPUIKit/**/*'
  s.swift_version = '5.0'
end
