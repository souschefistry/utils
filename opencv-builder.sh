#!/bin/bash -e

mkdir -p build
cd build

# Download and unzip archive
url="https://github.com/opencv/opencv/archive/3.2.0.zip"
wget -q "${url}" -O temp.zip
unzip -q temp.zip
rm temp.zip

# Build static library (selected modules only)
mkdir -p build
cd build
cmake \
    -DBUILD_SHARED_LIBS=OFF \
    -DBUILD_opencv_core=ON \
    -DBUILD_opencv_imgproc=ON \
    -DBUILD_opencv_imgcodecs=ON \
    -DBUILD_opencv_gpu=OFF \
    -DBUILD_opencv_calib3d=OFF \
    -DBUILD_opencv_contrib=OFF \
    -DBUILD_opencv_features2D=OFF \
    -DBUILD_opencv_flann=OFF \
    -DBUILD_opencv_highgui=OFF \
    -DBUILD_opencv_legacy=OFF \
    -DBUILD_opencv_ml=OFF \
    -DBUILD_opencv_nonfree=OFF \
    -DBUILD_opencv_objdetect=OFF \
    -DBUILD_opencv_photo=OFF \
    -DBUILD_opencv_stitching=OFF \
    -DBUILD_opencv_video=OFF \
    -DBUILD_opencv_videoio=OFF \
    -DBUILD_opencv_videostab=OFF \
    -DBUILD_opencv_world=OFF \
    -DCMAKE_BUILD_TYPE=Release \
    -DCPACK_GENERATOR="DEB;TGZ" \
    ../opencv-3.2.0
make -j4

# Build debian packages.
# This seems hackish but I have not found a better way to set
# CPACK_PACKAGE_VERSION so that I can generate the correct package name
sed -i 's/\bunknown\b/3.2.0/g' CPackConfig.cmake
make -j4 package
