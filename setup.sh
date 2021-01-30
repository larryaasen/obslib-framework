#!/bin/bash

rm -dfr libobs-files
rm -dfr obslib.framework

# Pull down artifact from larryaasen/obs-studio
curl -L https://github.com/larryaasen/obs-studio/releases/download/26.0-framework-1/obs-studio_artifacts.zip --output libobs-files.zip
 
# Unzip files
unzip -q libobs-files.zip -d libobs-files
mv libobs-files/libobs libobs-files/Headers

# Build framework
# When signing, use: -allowProvisioningUpdates
cd src; xcodebuild -project obslib-framework.xcodeproj -scheme obslib -configuration Debug CODE_SIGNING_REQUIRED="NO" CODE_SIGN_IDENTITY= -sdk macosx clean build

cd ..
pwd
ls -al

# Zip the framework folder so the symbolic links are maintained
zip --recurse-paths --symlinks obslib.framework.zip obslib.framework

ls -al obslib.framework.zip

# Validate the Pod using the files in the working directory
pod lib lint obslib.podspec
