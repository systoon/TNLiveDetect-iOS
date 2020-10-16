#
# Be sure to run `pod lib lint TNLiveDetect.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'TNLiveDetect'
  s.version          = '1.0.2'
  s.summary          = 'a live detect sdk on iOS platform of sysw1n.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
a live detect sdk on iOS platform of sysw1n.
                       DESC

  s.homepage         = 'https://github.com/systoon/TNLiveDetect'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'systoon' => 'fanhuibo@syswin.com' }
  s.source           = { :git => 'https://github.com/systoon/TNLiveDetect-iOS.git', :tag => s.version.to_s }

  s.ios.deployment_target = '8.0'

  s.resources = ['Frameworks/TNLiveDetect.framework/*.png','Frameworks/TNLiveDetect.framework/*.bundle']
  s.ios.vendored_frameworks = 'Frameworks/*.framework'
  
  s.frameworks = 'UIKit', 'Foundation', 'CoreFoundation', 'WebKit', 'AVFoundation'
  s.libraries = 'stdc++'
  
  s.dependency 'AFNetworking'

end
