Pod::Spec.new do |spec|
  spec.name                     = 'Leap-SDK'
  spec.version = '0.9.0'
  spec.summary                  = 'LeapSDK for iOS - On-device AI inference with Liquid models'
  spec.description              = <<-DESC
                                  LeapSDK is a powerful iOS SDK that enables running AI models locally on device using the Liquid Inference Engine. 
                                  It provides a high-level Swift API for chat functionality with real-time token streaming.
                                  DESC
  spec.homepage                 = 'https://github.com/Liquid4All/leap-ios'
  spec.license                  = { :type => 'Proprietary', :text => 'Copyright 2025 Liquid AI. All rights reserved.' }
  spec.author                   = { 'Liquid AI' => 'support@liquid.ai' }
  spec.source                   = { :http => 'https://github.com/Liquid4All/leap-ios/releases/download/v0.9.0/LeapSDK.xcframework.zip' }
  
  spec.ios.deployment_target    = '15.0'
  spec.osx.deployment_target    = '12.0'
  spec.swift_version            = '5.9'
  
  spec.vendored_frameworks      = 'LeapSDK.xcframework'
  spec.frameworks               = 'Foundation'
  
  spec.requires_arc             = true
  
  # Documentation
  spec.documentation_url        = 'https://github.com/Liquid4All/leap-ios'
  
  # Source files are not included as this is a binary distribution
  spec.source_files             = []
  
  # Platform-specific settings
  spec.pod_target_xcconfig = {
    'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'i386',
    'EXCLUDED_ARCHS[sdk=macosx*]' => 'x86_64'
  }
  
  spec.user_target_xcconfig = {
    'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'i386',
    'EXCLUDED_ARCHS[sdk=macosx*]' => 'x86_64'
  }
end