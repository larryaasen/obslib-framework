# obslib-framework

[![Codemagic](https://api.codemagic.io/apps/600d732c627f2f877727d718/macos-workflow/status_badge.svg)](https://codemagic.io/app/600d732c627f2f877727d718)
[![GitHub Stars](https://img.shields.io/github/stars/larryaasen/obslib-framework.svg)](https://github.com/larryaasen/obslib-framework/stargazers)


## Introduction

This project creates a framework of the [OBS Studio](https://github.com/obsproject/obs-studio/) core library called [libobs](https://github.com/obsproject/obs-studio/tree/master/libobs) by
packaging it into a macOS framework. It also creates a Cocoapod called obslib.

This framework contains the pre-built *.dylib files, *.so files, data files,
and header files, that are normally part of libobs.

The advantage of using a framework is that Xcode automatically knows how to find
the included header and resource files, and link with the binary. The user of the
framework does not need to do any extra configuration other than 
dropping the framework into the project.

When this framework is used in a macOS app, it needs to link with the framework,
but also with those included dylibs. I can get the framework to link in an app,
but I cannot get the dylibs to link. I am not able to get Xcode to automatically
configure the included dylibs to be linked.

## One Big Question
How do I configure Xcode during the building of the framework
to include the dylibs so that they are automatically linked?
