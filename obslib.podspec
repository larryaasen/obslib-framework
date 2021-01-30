# pod lib lint obslib.podspec
Pod::Spec.new do |s|
  s.name             = 'obslib'
  s.version          = '26.1.2'
  s.summary          = 'OBS libobs Framework'
  s.description      = 'The OBS Studio libobs as a framework'
  s.homepage         = 'https://github.com/larryaasen/obslib-framework'
  s.license          = { :type => 'GNU General Public License v3.0', :file => './LICENSE' }
  s.authors          = { 'Jim' => 'obs.jim@gmail.com' }
  s.source           = { :http => 'file:///Users/larry/Projects/obs-studio' }
  # s.source_files     = "obslib.framework/Headers/**/*.{h,hpp}"
  # s.public_header_files = "obslib.framework/Headers/**/*.{h,hpp}"
  s.header_mappings_dir = "obslib.framework/Headers"
  s.vendored_frameworks = "obslib.framework"
  s.platforms        = { :osx => '10.11' }

  # Silence GL deprecation warnings
  s.pod_target_xcconfig = { "SWIFT_ACTIVE_COMPILATION_CONDITIONS" => "GLES_SILENCE_DEPRECATION" }
end
