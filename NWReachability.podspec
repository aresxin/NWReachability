#
#  Be sure to run `pod spec lint NWReachability.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see https://guides.cocoapods.org/syntax/podspec.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

Pod::Spec.new do |s|

  s.name         = "NWReachability"
  s.version      = "1.0.0"
  s.summary      = "Monitoring Network"

  s.description  = <<-DESC 
                                 Monitoring iOS device's network connectivity using Apple's Network framework.
                                 DESC

  s.homepage     = "https://github.com/aresxin/NWReachability"

  s.license      = "MIT"

  s.author             = { "owen" => "653992778@qq.com" }
  s.social_media_url   = "https://github.com/aresxin"

  s.swift_versions = ['5.0']
  
  s.ios.deployment_target = "13.0"
  
  s.source       = { :git => "https://github.com/aresxin/NWReachability.git", :tag => 'v'+s.version.to_s }
  s.source_files  = 'Connectivity/*.swift'

  s.frameworks = "Network", "Combine"
  
end
