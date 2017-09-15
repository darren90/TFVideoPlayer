#
# Be sure to run `pod lib lint TFVideoPlayer.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'TFVideoPlayer'
  s.version          = '0.0.1'
  s.summary          = 'iOS video player.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
       iOS video player,good to use
                       DESC

  s.homepage         = 'https://github.com/darren90/TFVideoPlayer'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Tonny' => '1005052145@qq.com' }
  s.source           = { :git => 'https://github.com/darren90/TFVideoPlayer.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  # s.ios.deployment_target = '8.0'
  s.platform     = :ios, "8.0"

  s.source_files = 'TFVideoPlayer/Classes/**/*.{h,m}','TFVideoPlayer/Classes/TFPlayer/**/*.{h,m}', 'TFVideoPlayer/Classes/Vitamio-online/include/Vitamio/*.{h}'
  
  # s.resource_bundles = {
  #   'TFVideoPlayer' => ['TFVideoPlayer/Assets/*.png']
  # }
  s.resource     = 'TFVideoPlayer/Assets/*.png'
  s.public_header_files = "TFVideoPlayer/Classes/Vitamio-online/include/Vitamio/*.h"
  # s.public_header_files = 'Pod/Classes/**/*.h'
  #s.library = 'z'
  #s.libraries = 'libbz2', 'libz','libstdc++','libiconv','z'
  s.vendored_libraries  = 'TFVideoPlayer/Classes/Vitamio-online/*.{a}'
  #s.vendored_libraries  = 'TFVideoPlayer/Classes/Vitamio-online/libffmpeg.a','TFVideoPlayer/Classes/Vitamio-online/libopenssl.a','TFVideoPlayer/Classes/Vitamio-online/libVitamio.a'
  #s.libraries  =  "bz2", "z","stdc++","iconv" #'iconv','stdc++','z', 'bz2'
  s.frameworks = 'Foundation','UIKit','AVFoundation','AudioToolbox','CoreGraphics','CoreMedia','CoreVideo','MediaPlayer','OpenGLES','QuartzCore'

  #s.frameworks = 'AVFoundation', 'AudioToolbox','CoreGraphics','CoreMedia','CoreVideo','Foundation','MediaPlayer','OpenGLES','QuartzCore','UIKit'
  #s.dependency "Masonry", "~>  1.0.2"
  s.pod_target_xcconfig = { 'OTHER_LDFLAGS' => '-lObjC' }
  #s.pod_target_xcconfig = { 'OTHER_LDFLAGS' => '-lObjC' }
  # ,'OTHER_LDFLAGS' => '$(inherited)'
  #s.xcconfig = { "HEADER_SEARCH_PATHS" => "$(SDKROOT)/usr/include/libz" }
  s.requires_arc = true 

end
