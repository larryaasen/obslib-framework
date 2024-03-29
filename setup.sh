#!/bin/bash

# This shell script will pull down the build artifacts from larryaasen/obs-studio,
# build and code-sign a framework, and create a zip file.

rm -dfr libobs-files
rm -dfr obslib.framework
rm -dfr src/archives
rm -dfr src/build
rm -df obslib.framework.zip

# Pull down artifact from larryaasen/obs-studio
curl -L https://github.com/larryaasen/obs-studio/releases/download/26.0-framework-1/obs-studio_artifacts.zip --output libobs-files.zip
 
# Unzip files
unzip -q libobs-files.zip -d libobs-files
mv libobs-files/libobs libobs-files/Headers

# Build framework
cd src; xcodebuild -project obslib-framework.xcodeproj -scheme obslib -configuration Debug CODE_SIGNING_REQUIRED="NO" CODE_SIGN_IDENTITY= -sdk macosx clean build

cd ..
pwd
ls -al

# Code sign the framework
codesign --force --deep --sign - obslib.framework

# Display basic information about the result of the signing process
codesign --display --verbose -r- obslib.framework

# Verify your signature
codesign --verify --verbose obslib.framework

# mkdir frameworks
# mv obslib.framework frameworks
# mv frameworks obslib.framework

ls -al .
ls -al obslib.framework

# Zip the framework folder so the symbolic links are maintained
zip -q --recurse-paths --symlinks obslib.framework.zip obslib.framework

ls -al obslib.framework.zip

# Validate the Pod using the files in the working directory
pod lib lint obslib.podspec

exit

### New Commands (Not ready yet)

# Bulid the framework for OSX devices.
cd src; xcodebuild archive \
    -scheme obslib \
    -sdk macosx \
    -archivePath "archives/macosx_devices.xcarchive" \
    BUILD_LIBRARY_FOR_DISTRIBUTION=YES \
    SKIP_INSTALL=NO

# Code sign the framework
codesign --force --deep --sign - archives/macosx_devices.xcarchive/Products/Library/Frameworks/obslib.framework

# Build the XCFramework.
cd src; xcodebuild -create-xcframework \
    -framework archives/macosx_devices.xcarchive/Products/Library/Frameworks/obslib.framework \
  -output build/obslib.xcframework
