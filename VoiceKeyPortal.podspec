Pod::Spec.new do |s|
  s.name         = "VoiceKeyPortal"
  s.version      = "0.0.1"
  s.summary      = "Multimodal Biometric Authentication Software System"
  s.homepage     = "https://vkplatform.speechpro.com/"
  s.license      = "MIT"
  s.author       = { "alexandrasoloshcheva" => "soloshcheva@speechpro.com" }
  s.platform     = :ios, "12.0"
  s.source   = { :git => 'https://github.com/STC-VoiceKey/voicekey-platform-api-ios.git', :tag => s.version, :submodules => true }
  s.requires_arc = true
  s.source_files = 'VoiceKeyPortal/**/*.{h,m,c,*.swift}'
  s.swift_version = '5.0'    
end
