#
# Be sure to run `pod lib lint ISSUtil.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'ISSUtil'
  s.version          = '0.1.1'
  s.summary          = 'The iOS framework for isoftstone.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
TODO: Add long description of the pod here.
                       DESC

  s.homepage         = 'https://github.com/troyz/ISSUtil'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Troy Zhang' => 'java.koma@gmail.com' }
  s.source           = { :git => 'https://github.com/troyz/ISSUtil.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '8.0'

  # s.source_files = 'ISSUtil/Classes/**/*'
  s.source_files = 'ISSUtil/Classes/*.h'

  s.subspec 'Utils' do |ss|
    ss.subspec 'Date' do |sss|
      sss.source_files = 'ISSUtil/Classes/Utils/NSDate/*.{h,m}'
      sss.public_header_files = 'ISSUtil/Classes/Utils/NSDate/*.h'
    end
    ss.subspec 'String' do |sss|
      sss.source_files = 'ISSUtil/Classes/Utils/NSString/*.{h,m}'
      sss.public_header_files = 'ISSUtil/Classes/Utils/NSString/*.h'
    end
    ss.subspec 'Sys' do |sss|
      sss.source_files = 'ISSUtil/Classes/Utils/Sys/*.{h,m}'
      sss.public_header_files = 'ISSUtil/Classes/Utils/Sys/*.h'
    end
    ss.subspec 'Network' do |sss|
      sss.source_files = 'ISSUtil/Classes/Utils/Network/*.{h,m}'
      sss.public_header_files = 'ISSUtil/Classes/Utils/Network/*.h'
      sss.dependency 'ISSUtil/Utils/Date'
      sss.dependency 'ISSUtil/Utils/String'
      sss.dependency 'ISSUtil/Utils/Sys'
    end
  end
  s.subspec 'Views' do |ss|
    ss.subspec 'Cells' do |sss|
      sss.source_files = 'ISSUtil/Classes/Views/Cells/*.{h,m}'
      sss.public_header_files = 'ISSUtil/Classes/Views/Cells/*.h'
    end
    ss.subspec 'Input' do |sss|
      sss.source_files = 'ISSUtil/Classes/Views/Input/*.{h,m}'
      sss.public_header_files = 'ISSUtil/Classes/Views/Input/*.h'
      sss.dependency 'ISSUtil/Utils/Sys'
    end
    ss.subspec 'Button' do |sss|
      sss.source_files = 'ISSUtil/Classes/Views/UIButton/*.{h,m}'
      sss.public_header_files = 'ISSUtil/Classes/Views/UIButton/*.h'
      sss.dependency 'ISSUtil/Utils/Sys'
    end
    ss.subspec 'Image' do |sss|
      sss.source_files = 'ISSUtil/Classes/Views/UIImage/*.{h,m}'
      sss.public_header_files = 'ISSUtil/Classes/Views/UIImage/*.h'
    end
    ss.subspec 'ImageView' do |sss|
      sss.source_files = 'ISSUtil/Classes/Views/UIImageView/*.{h,m}'
      sss.public_header_files = 'ISSUtil/Classes/Views/UIImageView/*.h'
      sss.dependency 'ISSUtil/Utils/Sys'
    end
  end
  s.subspec 'Models' do |ss|
    ss.source_files = 'ISSUtil/Classes/Models/*.{h,m}'
    ss.public_header_files = 'ISSUtil/Classes/Models/*.h'
  end
  # s.resource_bundles = {
  #   'ISSUtil' => ['ISSUtil/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  s.dependency 'AFNetworking', '~> 3.1.0'
  s.dependency 'JSONModel', '~> 1.2.0'
  s.dependency 'MBProgressHUD', '~> 0.9.2'
end
