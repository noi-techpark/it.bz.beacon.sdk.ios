# Uncomment this line to define a global platform for your project
platform :ios, '11.0'
# Uncomment this line if you're using Swift
use_frameworks!

target 'SDK iOS' do

	pod 'KontaktSDK', '~> 2.0'
	
end

post_install do |installer|
    installer.pods_project.build_configurations.each do |config|
        config.build_settings.delete('CODE_SIGNING_ALLOWED')
        config.build_settings.delete('CODE_SIGNING_REQUIRED')
    end
end
