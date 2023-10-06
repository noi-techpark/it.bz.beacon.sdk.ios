Pod::Spec.new do |s|

  s.name         = "BZBeaconSDK"
  s.version      = "0.2.2"
  s.summary      = "SDK for the Beacon Suedtirol - Alto Adige Project"

  s.description  = "Find nearby beacons of the Beacon Suedtirol - Alto Adige Project, and get all relevant information about them"

  s.homepage     = "https://github.com/noi-techpark/it.bz.beacon.sdk.ios"

  s.license      = "MPL 2.0"

  s.author       = { "KONVERTO AG" => "development@konverto.eu" }

  s.platform     = :ios
  s.platform     = :ios, "12.0"

  s.source       = { :git => "https://github.com/noi-techpark/it.bz.beacon.sdk.ios.git", :tag => "#{s.version}" }

  s.source_files  = "Beacon SDK iOS", "Beacon SDK iOS/**/*.swift"
  s.resources = "Beacon SDK iOS/Beacon.xcdatamodeld"
  s.exclude_files = "Classes/Exclude"
  s.swift_version = "4.2"

  s.dependency 'KontaktSDK', :git => 'https://github.com/kontaktio/kontakt-ios-sdk.git', :tag => '2.0.1'
  s.dependency 'Alamofire', '~> 4.3'
  
  s.user_target_xcconfig = { 'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'arm64' }
  s.pod_target_xcconfig = { 'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'arm64' }

end
