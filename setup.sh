#!/bin/bash

# Pull down artifact from larryaasen/obs-studio
curl -L https://github.com/larryaasen/obs-studio/releases/download/26.0-framework-1/obs-studio_artifacts.zip --output libobs-files.zip
 
# Unzip files
rm -dfr libobs-files
unzip -q libobs-files.zip -d libobs-files

# Build framework
cd src; xcodebuild -project obslib-framework.xcodeproj -scheme obslib -configuration Release -sdk macosx clean build

# Validate the Pod using the files in the working directory
pod lib lint obslib.podspec --quick
