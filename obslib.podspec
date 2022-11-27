# pod lib lint obslib.podspec
Pod::Spec.new do |s|
  s.name             = 'obslib'
  s.version          = '26.1.2'
  s.summary          = 'OBS libobs Framework'
  s.description      = 'The OBS Studio libobs as a framework'
  s.homepage         = 'https://github.com/larryaasen/obslib-framework'
  s.license          = { :type => 'GNU General Public License v3.0', :file => './LICENSE' }
  s.authors          = { 'Jim' => 'obs.jim@gmail.com' }
  s.source           = { :http => 'https://github.com/larryaasen/obslib-framework/releases/download/framework-alpha-2/obslib.framework.zip' }
  s.vendored_frameworks = 'obslib.framework'
  s.platforms        = { :osx => '10.13' }

  # Silence GL deprecation warnings
  s.user_target_xcconfig = {
    'OTHER_LDFLAGS' => '-l"obs.0"',
    'LD_RUNPATH_SEARCH_PATHS' => '@loader_path/../Frameworks/obslib.framework/Versions/A/Frameworks @loader_path/../Frameworks/obslib.framework/Versions/A/Libraries',
    'LIBRARY_SEARCH_PATHS' => '$(FRAMEWORK_SEARCH_PATHS)/obslib.framework/Versions/A/Libraries'
  }

  s.pod_target_xcconfig = {
    'SWIFT_ACTIVE_COMPILATION_CONDITIONS' => 'GLES_SILENCE_DEPRECATION',
    'DEFINES_MODULE' => 'YES'
  }
end
