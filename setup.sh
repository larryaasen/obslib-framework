#!/bin/bash

# Pull down artifact from larryaasen/obs-studio
curl -L https://github.com/larryaasen/obs-studio/releases/download/26.0-framework-1/obs-studio_7_artifacts.zip --output libobs-files.zip
 
# Unzip files
unzip libobs-files.zip -d libobs-files

