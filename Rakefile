desc "Run the test suite"

task :test do
  system "pod install"

  build = "xcodebuild \
    -workspace RKNotificationHub.xcworkspace \
    -scheme RKNotificationHub \
    -sdk iphonesimulator -destination 'platform=iOS Simulator,name=iPhone 6,OS=8.1'"
  system "#{build} test | xcpretty --test --color"  
end

task :default => :test