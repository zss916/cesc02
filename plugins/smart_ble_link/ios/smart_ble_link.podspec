Pod::Spec.new do |s|
  s.name             = 'smart_ble_link'
  s.version          = '1.0.0'
  s.summary          = 'BLE smart config link plugin wrapping JY_BlueSDK and Hiflying BLELink.'
  s.description      = 'Flutter plugin wrapping the hiflying BLE link SDK (Android) and JY_BlueSDK (iOS) for BLE device provisioning.'
  s.homepage         = 'https://example.com'
  s.license          = { :type => 'MIT' }
  s.author           = { 'Ble Team' => 'dev@example.com' }
  s.source           = { :path => '.' }
  s.source_files     = 'Classes/**/*.{h,m,c}'
  s.public_header_files = 'Classes/SmartBleLinkPlugin.h'
  s.dependency 'Flutter'
  s.platform         = :ios, '15.0'
  s.frameworks       = 'CoreBluetooth', 'SystemConfiguration', 'CoreLocation'
  s.pod_target_xcconfig = {
    'DEFINES_MODULE' => 'YES',
    'HEADER_SEARCH_PATHS' => '"$(inherited)" "$(PODS_TARGET_SRCROOT)/Classes" "$(PODS_TARGET_SRCROOT)/Classes/cocoaSecurity" "$(PODS_TARGET_SRCROOT)/Classes/dynamic_crypt" "$(PODS_TARGET_SRCROOT)/Classes/GCD"'
  }
end
