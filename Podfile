source 'https://github.com/CocoaPods/Specs.git'

use_frameworks!

project 'LayoutFrameworkBenchmark.xcodeproj'

platform :ios, '10.0'

inhibit_all_warnings!

target 'LayoutFrameworkBenchmark' do
    pod 'FlexLayout'
    pod 'LayoutKit'
    pod 'NotAutoLayout'
    pod 'NKFrameLayoutKit'
    pod 'PinLayout'

    pod 'Reveal-SDK'
end


post_install do |installer|
  installer.pods_project.targets.each do |target|
      if ['LayoutKit'].include? target.name
          target.build_configurations.each do |config|
              config.build_settings['SWIFT_VERSION'] = '4.1'
          end
      end
  end
end