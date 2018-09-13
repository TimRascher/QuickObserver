platform :ios, '9.0'
use_frameworks!
inhibit_all_warnings!
workspace 'QuickObserver'

target 'QuickObserver-Example' do
  project 'Example/QuickObserver-Example/QuickObserver-Example'
  
  pod 'QuickObserver', :path => './'
  pod 'SwiftLint'
  
  target 'QuickObserver-ExampleTests' do
        inherit! :search_paths
    end
end