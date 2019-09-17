Pod::Spec.new do |s|

  s.name         = "BZBeaconSDK"
  s.version      = "0.1.7"
  s.summary      = "SDK for the Beacon Suedtirol - Alto Adige Project"

  s.description  = "Find nearby beacons of the Beacon Suedtirol - Alto Adige Project, and get all relevant information about them"

  s.homepage     = "https://github.com/noi-techpark/beacon-suedtirol-mobile-sdk-ios"

  s.license      = "MPL 2.0"

  s.author       = { "Konverto AG" => "development@konverto.eu" }

  s.platform     = :ios
  s.platform     = :ios, "11.0"

  s.source       = { :git => "https://github.com/noi-techpark/beacon-suedtirol-mobile-sdk-ios.git", :tag => "#{s.version}" }

  s.source_files  = "Beacon SDK iOS", "Beacon SDK iOS/**/*.swift"
  s.resources = "Beacon SDK iOS/Beacon.xcdatamodeld"
  s.exclude_files = "Classes/Exclude"
  s.swift_version = "4.2"

  s.dependency 'KontaktSDK', '~> 2.0'
  s.dependency 'Alamofire', '~> 4.3'

end
