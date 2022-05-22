
Pod::Spec.new do |s|

  s.name                  = "LEActivity"
  s.version               = "1.1.0"
  s.summary               = "Custom UIActivityIndicators with comfortable interface"
  s.homepage              = "https://github.com/Hank2354/LEActivityIndicator"

  s.license               = { :type => 'MIT', :file => 'LICENSE' }
  s.author                = { "Hank3465" => "resly34@yandex.ru" }
  s.platform              = :ios, 13.0

  s.source                = { :git => "https://github.com/Hank2354/LEActivityIndicator.git",
                              :tag => "#{s.version}" }

  s.source_files = 'Classes/**/*.swift'

  s.framework             = 'Foundation', 'UIKit'
  s.requires_arc          = true
  s.swift_version         = '5.0'

end
