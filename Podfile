platform :ios, '9.0'

target 'KodingSehatQ' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  # Pods for KodingSehatQ

  pod 'Firebase/Analytics'
  pod 'Firebase/Auth'
  pod 'Alamofire'
  pod 'Kingfisher'
  pod 'IQKeyboardManagerSwift'
  pod 'RealmSwift'
  
  
  target 'KodingSehatQTests' do
    inherit! :search_paths
    # Pods for testing
  end

  target 'KodingSehatQUITests' do
    # Pods for testing
  end

end

post_install do |installer|
  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
      config.build_settings['SWIFT_VERSION'] = '5.1'
    end
  end
end
