#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html.
# Run `pod lib lint qr_bar_code.podspec` to validate before publishing.
#
Pod::Spec.new do |s|
  s.name             = 'qr_bar_code'
  s.version          = '0.0.1'
  s.summary          = 'A QR (Quick Response) code is a type of two dimensional (2D) bar code that is used to provide easy access to online information through the digital camera on a smartphone.'
  s.description      = <<-DESC
A QR (Quick Response) code is a type of two dimensional (2D) bar code that is used to provide easy access to online information through the digital camera on a smartphone.
                       DESC
  s.homepage         = 'http://example.com'
  s.license          = { :file => '../LICENSE' }
  s.author           = { 'Your Company' => 'email@example.com' }
  s.source           = { :path => '.' }
  s.source_files = 'Classes/**/*'
  s.dependency 'Flutter'
  s.platform = :ios, '11.0'

  # Flutter.framework does not contain a i386 slice.
  s.pod_target_xcconfig = { 'DEFINES_MODULE' => 'YES', 'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'i386' }
  s.swift_version = '5.0'
end
