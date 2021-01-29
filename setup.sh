#!/bin/bash

# Pull down artifact from larryaasen/obs-studio
curl -L https://github.com/larryaasen/obs-studio/releases/download/26.0-framework-1/obs-studio_artifacts.zip --output libobs-files.zip
 
# Unzip files
rm -dfr libobs-files
unzip -q libobs-files.zip -d libobs-files
mv libobs-files/libobs libobs-files/Headers

# Build framework
# When signing, use: -allowProvisioningUpdates
cd src; xcodebuild -project obslib-framework.xcodeproj -scheme obslib -configuration Debug CODE_SIGNING_REQUIRED="NO" CODE_SIGN_IDENTITY= -sdk macosx clean build

# Validate the Pod using the files in the working directory
cd ..
pwd
ls -al
pod lib lint obslib.podspec
