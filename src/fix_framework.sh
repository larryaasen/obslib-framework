#!/bin/sh

echo 'fix_framework.sh: Fixing framework files'

# Copy Header files
cp -Rf ${PROJECT_DIR}/../libobs-files/Headers/ ${BUILT_PRODUCTS_DIR}/${CONTENTS_FOLDER_PATH}/Headers

# Fix the load paths of frameworks
FRAMEWORKS=${BUILT_PRODUCTS_DIR}/obslib.framework/Versions/A/Frameworks
LIBRARIES=${BUILT_PRODUCTS_DIR}/obslib.framework/Versions/A/Libraries
PLUGINS=${BUILT_PRODUCTS_DIR}/obslib.framework/Versions/A/PlugIns
TMP_BIN=/tmp/obsdeps/bin
TMP_LIB=/tmp/obsdeps/lib

fix_tmp_paths()
{
    lib_path=$1
    shift;
    for lib in $@
    do
        install_name_tool -change $TMP_LIB/$lib @rpath/$lib $lib_path
    done

    # List the dependent libraries to be loaded from the lib
    otool -L $lib_path
}

fix_tmp_paths $LIBRARIES/libobs.0.dylib libavcodec.58.dylib libjansson.4.dylib libavformat.58.dylib libavutil.56.dylib libswscale.5.dylib libswresample.3.dylib
fix_tmp_paths $FRAMEWORKS/libavcodec.58.dylib libavcodec.58.dylib libswresample.3.dylib libavutil.56.dylib libx264.161.dylib
fix_tmp_paths $FRAMEWORKS/libavfilter.7.dylib libavfilter.7.dylib libswscale.5.dylib libpostproc.55.dylib libavformat.58.dylib libavcodec.58.dylib libswresample.3.dylib libavutil.56.dylib libmbedtls.2.24.0.dylib libmbedx509.2.24.0.dylib libmbedcrypto.2.24.0.dylib libx264.161.dylib
fix_tmp_paths $FRAMEWORKS/libswresample.3.dylib libswresample.3.dylib libavutil.56.dylib
fix_tmp_paths $FRAMEWORKS/libavformat.58.dylib libavformat.58.dylib libavcodec.58.dylib libswresample.3.dylib libavutil.56.dylib libmbedtls.2.24.0.dylib libmbedx509.2.24.0.dylib libmbedcrypto.2.24.0.dylib libx264.161.dylib
fix_tmp_paths $FRAMEWORKS/libmbedtls.2.24.0.dylib libmbedtls.2.24.0.dylib libmbedx509.1.dylib libmbedcrypto.5.dylib
fix_tmp_paths $FRAMEWORKS/libswscale.5.dylib libswscale.5.dylib libavutil.56.dylib
fix_tmp_paths $FRAMEWORKS/libpostproc.55.dylib libpostproc.55.dylib libavutil.56.dylib
fix_tmp_paths $FRAMEWORKS/libavdevice.58.dylib libavdevice.58.dylib libavfilter.7.dylib libswscale.5.dylib libpostproc.55.dylib libavformat.58.dylib libavcodec.58.dylib libswresample.3.dylib libavutil.56.dylib libmbedtls.2.24.0.dylib libmbedx509.2.24.0.dylib libmbedcrypto.2.24.0.dylib libx264.161.dylib
fix_tmp_paths $FRAMEWORKS/libmbedx509.2.24.0.dylib libmbedx509.2.24.0.dylib libmbedcrypto.5.dylib
    
fix_tmp_paths $PLUGINS/obs-ffmpeg.so libavcodec.58.dylib libavfilter.7.dylib libavdevice.58.dylib libavutil.56.dylib libswscale.5.dylib libavformat.58.dylib libswresample.3.dylib
fix_tmp_paths $PLUGINS/obs-filters.so libspeexdsp.1.dylib librnnoise.0.dylib
fix_tmp_paths $PLUGINS/obs-outputs.so libmbedtls.2.24.0.dylib libmbedcrypto.2.24.0.dylib libmbedx509.2.24.0.dylib libjansson.4.dylib
fix_tmp_paths $PLUGINS/obs-x264.so libx264.161.dylib
fix_tmp_paths $PLUGINS/rtmp-services.so libjansson.4.dylib
fix_tmp_paths $PLUGINS/text-freetype2.so libfreetype.6.dylib

# Setup symbolic links
cd $FRAMEWORKS; ln -fsv libmbedx509.2.24.0.dylib libmbedx509.1.dylib;
cd $FRAMEWORKS; ln -fsv libmbedcrypto.2.24.0.dylib libmbedcrypto.5.dylib;
 
# Remove framework folder so the end result is clean
rm -R ${PROJECT_DIR}/../obslib.framework

#mkdir -p ${PROJECT_DIR}/../build

cp -Rf ${BUILT_PRODUCTS_DIR}/obslib.framework ${PROJECT_DIR}/..

echo 'fix_framework.sh: Completed'