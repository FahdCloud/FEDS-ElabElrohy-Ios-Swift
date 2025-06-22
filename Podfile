# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

platform :ios, '16.0'

target 'FEDS-ElabElrohy' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  # Pods for FEDS-Mrwan-Hassan

  pod 'Alamofire'
  pod 'SDWebImage'
  pod 'SDWebImageVideoCoder'
  pod 'SDWebImageSVGCoder'
  pod 'SDWebImagePDFCoder'
  pod 'libPhoneNumber-iOS'
  pod 'FSCalendar'
  pod 'AZDialogView'
  pod 'BottomSheetSwiftUI'
  pod 'Firebase/Core'
  pod 'Firebase/Messaging'

  end
  post_install do |installer|
  installer.generated_projects.each do |project|
        project.targets.each do |target|
            target.build_configurations.each do |config|
                config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '16.0'
             end
        end
  end
end

