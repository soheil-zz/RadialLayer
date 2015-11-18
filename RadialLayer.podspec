#
# Be sure to run `pod lib lint RadialLayer.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = "RadialLayer"
  s.version          = "0.1.0"
  s.summary          = "Animation for clickable elements"

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!  
  s.description      = <<-DESC
With minimal configuration add an animation to all clickable elements. Animations are performed on GPU for maximum performance.
                       DESC

  s.homepage         = "https://github.com/soheil/RadialLayer"
  s.screenshots      = "http://i.imgur.com/qIBtblE.gif"
  s.license          = 'MIT'
  s.author           = { "Soheil" => "ysoheil@gmail.com" }
  s.source           = { :git => "https://github.com/soheil/RadialLayer.git", :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/soheil'

  s.platform     = :ios, '8.0'
  s.requires_arc = true

  s.source_files = 'Pod/Classes/**/*'
  s.resource_bundles = {
    'RadialLayer' => ['Pod/Assets/*.png']
  }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
