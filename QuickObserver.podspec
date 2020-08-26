Pod::Spec.new do |s|

  # ―――  Spec Metadata  ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  s.name              = "QuickObserver"
  s.version           = "2.1.1"
  s.summary           = "A quick way to enable observable behavior on any object."
  s.description       = <<-DESC
                          This library enable you to quickly add observers to your project.
                          With a little adoption you can make it so any object can report on changes of state, or issue  instructions to follower objects. The objects do not hold strong refrences to observing objects, and do not require the use of tokens.
                        DESC
  s.homepage          = "https://github.com/TimRascher/QuickObserver"
  s.documentation_url = 'https://github.com/TimRascher/QuickObserver/blob/master/README.md'

  # ―――  Spec License  ――――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  s.license      = { :type => "MIT", :file => "LICENSE" }

  # ――― Author Metadata  ――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  s.author             = { "Timothy Rascher" => "timrascher@gmail.com" }

  # ――― Platform Specifics ――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  s.platform       = :ios, "10.0"
  s.swift_version  = "5.0"

  # ――― Source Location ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  s.source       = { :git => "https://github.com/TimRascher/QuickObserver.git", :branch => "Cocoapods/2.1.1", :tag => "Cocoapods/2.1.1" }

  # ――― Source Code ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  s.source_files  = "Sources/**/**/*.{swift}"
  
end
