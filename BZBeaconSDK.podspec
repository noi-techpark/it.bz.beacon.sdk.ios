Pod::Spec.new do |s|

  s.name         = "BZBeaconSDK.podspec"
  s.version      = "0.0.1"
  s.summary      = "SDK for the Beacon Suedtirol - Alto Adige Project"

  s.description  = "Find nearby beacons of the Beacon Suedtirol - Alto Adige Project, and get all relevant information about them"

  s.homepage     = "https://github.com/idm-suedtirol/beacon-suedtirol-mobile-sdk-ios"

  s.license      = "MPL 2.0"

  s.author       = { "Konverto AG" => "development@konverto.eu" }

  s.platform     = :ios
  s.platform     = :ios, "11.0"

  s.source       = { :git => "git@github.com:idm-suedtirol/beacon-suedtirol-api.git", :tag => "#{s.version}" }

  s.source_files  = "Classes", "Classes/**/*.{h,m}"
  s.exclude_files = "Classes/Exclude"

  s.dependency 'KontaktSDK', '~> 2.0'
  s.dependency 'Alamofire', '~> 4.3'

end
