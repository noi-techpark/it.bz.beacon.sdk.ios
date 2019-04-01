Pod::Spec.new do |spec|

  spec.name         = "beaconSuedtirolSDK.podspec"
  spec.version      = "0.0.1"
  spec.summary      = "SDK for Beacon Suedtirol Project"

  spec.description  = "Find nearby beacons of the Beacon Suedtirol Project, and get all relevant information about them"

  spec.homepage     = "https://github.com/idm-suedtirol/beacon-suedtirol-mobile-sdk-ios"

  spec.license      = "MPL 2.0"

  spec.author             = { "Konverto AG" => "development@konverto.eu" }

  spec.platform     = :ios
  spec.platform     = :ios, "11.0"

  spec.source       = { :git => "git@github.com:idm-suedtirol/beacon-suedtirol-api.git", :tag => "#{spec.version}" }

  spec.source_files  = "Classes", "Classes/**/*.{h,m}"
  spec.exclude_files = "Classes/Exclude"

end
