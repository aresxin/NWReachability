#
#  Be sure to run `pod spec lint NWReachability.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see https://guides.cocoapods.org/syntax/podspec.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

Pod::Spec.new do |spec|

  spec.name         = "NWReachability"
  spec.version      = "1.0.0"
  spec.summary      = "Monitoring Network"

  spec.description  = <<-DESC 
                                 Monitoring iOS device's network connectivity using Apple's Network framework.
                                 DESC

  spec.homepage     = "https://github.com/aresxin/NWReachability"

  spec.license      = "MIT"

  spec.author             = { "owen" => "653992778@qq.com" }
  spec.social_media_url   = "https://github.com/aresxin"

  spec.swift_versions = ['5.0']
  
  spec.ios.deployment_target = "13.0"
  
  spec.source       = { :git => "https://github.com/aresxin/NWReachability.git", :tag => 'v'+s.version.to_s }
  spec.source_files  = 'NWReachability/Connectivity/*.swift'

  spec.frameworks = "Network", "Combine"
end
