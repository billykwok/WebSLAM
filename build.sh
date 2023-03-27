#!/bin/sh
EMSCRIPTEN_DIR=~/Development/emsdk/upstream/emscripten
EMSCRIPTEN_CMAKE_DIR=$EMSCRIPTEN_DIR/cmake/Modules/Platform/Emscripten.cmake

PROJECT_ROOT=$PWD
LIB_ROOT=$PROJECT_ROOT/libs
BUILD_FLAGS_COMMON="-s USE_PTHREADS=1 -s PTHREAD_POOL_SIZE=navigator.hardwareConcurrency -s PROXY_TO_PTHREAD=1 -s ALLOW_BLOCKING_ON_MAIN_THREAD=0 -msimd128";
BUILD_FLAGS_CXX="-O3 -std=c++17 ${BUILD_FLAGS_COMMON}";
BUILD_FLAGS_C="-O3 ${BUILD_FLAGS_COMMON}";

build_BOOST() {
  rm -rf $LIB_ROOT/boost/build
  mkdir $LIB_ROOT/boost/build

  cd $LIB_ROOT/boost
  ./bootstrap.sh --prefix=$LIB_ROOT/boost/build --with-libraries=system,serialization
  ./b2 install toolset=emscripten link=static variant=release threading=multi runtime-link=static system serialization

  cd $PROJECT_ROOT
}

build_FMT() {
  rm -rf $LIB_ROOT/fmt/build
  mkdir $LIB_ROOT/fmt/build

  cd $LIB_ROOT/fmt/build
  emcmake cmake .. \
    -DCMAKE_BUILD_TYPE=Release \
    -DCMAKE_CXX_STANDARD=17 \
    -DCMAKE_TOOLCHAIN_FILE=$EMSCRIPTEN_CMAKE_DIR \
    -DCMAKE_CXX_FLAGS="${BUILD_FLAGS_CXX}" \
    -DCMAKE_C_FLAGS="${BUILD_FLAGS_C}" \
    -DCMAKE_INSTALL_PREFIX=$LIB_ROOT/fmt/build \
    -DBUILD_SHARED_LIBS=OFF
  emmake make -j4 install

  cd $PROJECT_ROOT
}

build_DBOW2() {
  rm -rf $LIB_ROOT/DBoW2/build
  mkdir $LIB_ROOT/DBoW2/build

  cd $LIB_ROOT/DBoW2/build
  emcmake cmake .. \
    -DCMAKE_BUILD_TYPE=Release \
    -DCMAKE_CXX_STANDARD=17 \
    -DCMAKE_TOOLCHAIN_FILE=$EMSCRIPTEN_CMAKE_DIR \
    -DCMAKE_CXX_FLAGS="${BUILD_FLAGS_CXX}" \
    -DCMAKE_C_FLAGS="${BUILD_FLAGS_C}" \
    -DCMAKE_INSTALL_PREFIX=$LIB_ROOT/DBoW2/build \
    -DBUILD_SHARED_LIBS=OFF \
    -DOpenCV_DIR=$LIB_ROOT/opencv/build \
    -DOpenCV_INCLUDE_DIRS=$LIB_ROOT/opencv/build/include \
    -DOpenCV_LIBS=OpenCV
  emmake make -j4 install

  cd $PROJECT_ROOT
}

build_G2O() {
  rm -rf $LIB_ROOT/g2o/build
  mkdir $LIB_ROOT/g2o/build

  cd $LIB_ROOT/g2o/build
  emcmake cmake .. \
    -DCMAKE_BUILD_TYPE=Release \
    -DCMAKE_CXX_STANDARD=17 \
    -DCMAKE_TOOLCHAIN_FILE=$EMSCRIPTEN_CMAKE_DIR \
    -DCMAKE_CXX_FLAGS="${BUILD_FLAGS_CXX}" \
    -DCMAKE_C_FLAGS="${BUILD_FLAGS_C}" \
    -DCMAKE_INSTALL_PREFIX=$LIB_ROOT/g2o/build \
    -DBUILD_SHARED_LIBS=OFF
  emmake make -j4 install

  cd $PROJECT_ROOT
}

build_OPENCV() {
  rm -rf $LIB_ROOT/opencv/build
  mkdir $LIB_ROOT/opencv/build

  cd $LIB_ROOT/opencv/build
  emcmake cmake .. \
    -DCMAKE_BUILD_TYPE=Release \
    -DCMAKE_CXX_STANDARD=17 \
    -DCMAKE_TOOLCHAIN_FILE=$EMSCRIPTEN_CMAKE_DIR \
    -DCMAKE_CXX_FLAGS="${BUILD_FLAGS_CXX}" \
    -DCMAKE_C_FLAGS="${BUILD_FLAGS_C}" \
    -DCMAKE_INSTALL_PREFIX=$LIB_ROOT/opencv/build \
    -DBUILD_SHARED_LIBS=OFF \
    -DENABLE_PIC=FALSE \
    -DCPU_BASELINE='' \
    -DCPU_DISPATCH='' \
    -DCV_TRACE=OFF \
    -DWITH_1394=OFF \
    -DWITH_ADE=OFF \
    -DWITH_VTK=OFF \
    -DWITH_EIGEN=OFF \
    -DWITH_FFMPEG=OFF \
    -DWITH_GSTREAMER=OFF \
    -DWITH_GTK=OFF \
    -DWITH_GTK_2_X=OFF \
    -DWITH_IPP=OFF \
    -DWITH_JASPER=OFF \
    -DWITH_JPEG=OFF \
    -DWITH_WEBP=OFF \
    -DWITH_OPENEXR=OFF \
    -DWITH_OPENGL=OFF \
    -DWITH_OPENVX=OFF \
    -DWITH_OPENNI=OFF \
    -DWITH_OPENNI2=OFF \
    -DWITH_PNG=OFF \
    -DWITH_TBB=OFF \
    -DWITH_TIFF=OFF \
    -DWITH_V4L=OFF \
    -DWITH_OPENCL=OFF \
    -DWITH_OPENCL_SVM=OFF \
    -DWITH_OPENCLAMDFFT=OFF \
    -DWITH_OPENCLAMDBLAS=OFF \
    -DWITH_GPHOTO2=OFF \
    -DWITH_LAPACK=OFF \
    -DWITH_ITT=OFF \
    -DWITH_QUIRC=ON \
    -DBUILD_ZLIB=ON \
    -DBUILD_opencv_apps=OFF \
    -DBUILD_opencv_calib3d=ON \
    -DBUILD_opencv_dnn=ON \
    -DBUILD_opencv_features2d=ON \
    -DBUILD_opencv_flann=ON \
    -DBUILD_opencv_gapi=OFF \
    -DBUILD_opencv_ml=OFF \
    -DBUILD_opencv_photo=ON \
    -DBUILD_opencv_imgcodecs=OFF \
    -DBUILD_opencv_shape=OFF \
    -DBUILD_opencv_videoio=OFF \
    -DBUILD_opencv_videostab=OFF \
    -DBUILD_opencv_highgui=OFF \
    -DBUILD_opencv_superres=OFF \
    -DBUILD_opencv_stitching=OFF \
    -DBUILD_opencv_java=OFF \
    -DBUILD_opencv_js=ON \
    -DBUILD_opencv_python2=OFF \
    -DBUILD_opencv_python3=OFF \
    -DBUILD_EXAMPLES=OFF \
    -DBUILD_PACKAGE=OFF \
    -DBUILD_TESTS=OFF \
    -DBUILD_PERF_TESTS=OFF

  cd $PROJECT_ROOT
}

build_EIGEN() {
  rm -rf $LIB_ROOT/eigen/build
  mkdir $LIB_ROOT/eigen/build

  cd $LIB_ROOT/eigen/build
  emcmake cmake .. \
    -DCMAKE_BUILD_TYPE=Release \
    -DCMAKE_CXX_STANDARD=17 \
    -DCMAKE_TOOLCHAIN_FILE=$EMSCRIPTEN_CMAKE_DIR \
    -DCMAKE_CXX_FLAGS="${BUILD_FLAGS_CXX}" \
    -DCMAKE_C_FLAGS="${BUILD_FLAGS_C}" \
    -DCMAKE_INSTALL_PREFIX=$LIB_ROOT/eigen/build \
    -DBUILD_SHARED_LIBS=OFF
  emmake make -j4 install

  cd $PROJECT_ROOT
}

build_OPENBLAS() {
  rm -rf $LIB_ROOT/openblas/build
  mkdir $LIB_ROOT/openblas/build

  cd $LIB_ROOT/openblas/build
  emcmake cmake .. \
    -DCMAKE_BUILD_TYPE=Release \
    -DCMAKE_CXX_STANDARD=17 \
    -DCMAKE_TOOLCHAIN_FILE=$EMSCRIPTEN_CMAKE_DIR \
    -DCMAKE_CXX_FLAGS="${BUILD_FLAGS_CXX}" \
    -DCMAKE_C_FLAGS="${BUILD_FLAGS_C}" \
    -DCMAKE_INSTALL_PREFIX=$LIB_ROOT/openblas/build \
    -DBUILD_WITHOUT_LAPACK=ON \
    -DBUILD_WITHOUT_CBLAS=ON \
    -DTARGET=GENERIC \
    -DBUILD_TESTING=OFF \
    -DBUILD_SHARED_LIBS=OFF
  emmake make -j4 install

  cd $PROJECT_ROOT
}

build_OBINDEX2() {
  rm -rf $LIB_ROOT/obindex2/build
  mkdir $LIB_ROOT/obindex2/build

  cd $LIB_ROOT/obindex2/build
  emcmake cmake .. \
    -DCMAKE_BUILD_TYPE=Release \
    -DCMAKE_CXX_STANDARD=17 \
    -DCMAKE_TOOLCHAIN_FILE=$EMSCRIPTEN_CMAKE_DIR \
    -DCMAKE_CXX_FLAGS="${BUILD_FLAGS_CXX} -s USE_BOOST_HEADERS=1 -I $LIB_ROOT/boost/build" \
    -DCMAKE_C_FLAGS="${BUILD_FLAGS_C} -s USE_BOOST_HEADERS=1 -I $LIB_ROOT/boost/build" \
    -DCMAKE_INSTALL_PREFIX=$LIB_ROOT/obindex2/build \
    -DBUILD_SHARED_LIBS=OFF \
    -DOpenCV_DIR=$LIB_ROOT/opencv/build
  emmake make -j4 install

  cd $PROJECT_ROOT
}

build_IBOW_LCD() {
  rm -rf $LIB_ROOT/ibow_lcd/build
  mkdir $LIB_ROOT/ibow_lcd/build

  cd $LIB_ROOT/ibow_lcd/build
  emcmake cmake .. \
    -DCMAKE_BUILD_TYPE=Release \
    -DCMAKE_CXX_STANDARD=17 \
    -DCMAKE_TOOLCHAIN_FILE=$EMSCRIPTEN_CMAKE_DIR \
    -DCMAKE_CXX_FLAGS="${BUILD_FLAGS_CXX} -s USE_BOOST_HEADERS=1 -I $LIB_ROOT/boost/build" \
    -DCMAKE_C_FLAGS="${BUILD_FLAGS_C} -s USE_BOOST_HEADERS=1 -I $LIB_ROOT/boost/build" \
    -DCMAKE_INSTALL_PREFIX=$LIB_ROOT/ibow_lcd/build \
    -DBUILD_SHARED_LIBS=OFF \
    -DOpenCV_DIR=$LIB_ROOT/opencv/build
  emmake make -j4 install

  cd $PROJECT_ROOT
}

build_SOPHUS() {
  rm -rf $LIB_ROOT/sophus/build
  mkdir $LIB_ROOT/sophus/build

  cd $LIB_ROOT/sophus/build
  emcmake cmake .. \
    -DCMAKE_BUILD_TYPE=Release \
    -DCMAKE_CXX_STANDARD=17 \
    -DCMAKE_TOOLCHAIN_FILE=$EMSCRIPTEN_CMAKE_DIR \
    -DCMAKE_CXX_FLAGS="${BUILD_FLAGS_CXX}" \
    -DCMAKE_C_FLAGS="${BUILD_FLAGS_C}" \
    -DCMAKE_INSTALL_PREFIX=$LIB_ROOT/sophus/build \
    -DBUILD_SHARED_LIBS=OFF \
    -DSOPHUS_USE_BASIC_LOGGING=ON \
    -DEIGEN3_INCLUDE_DIR=$LIB_ROOT/eigen/build/include/eigen3 \
    -DBUILD_SOPHUS_TESTS=OFF \
    -DBUILD_SOPHUS_EXAMPLES=OFF
  emmake make -j4 install

  cd $PROJECT_ROOT
}

build_SUITE_SPARSE() {
  rm -rf $LIB_ROOT/suite-sparse/SuiteSparse_config/build
  mkdir $LIB_ROOT/suite-sparse/SuiteSparse_config/build

  cd $LIB_ROOT/suite-sparse/SuiteSparse_config/build
  emcmake cmake .. \
    -DCMAKE_BUILD_TYPE=Release \
    -DCMAKE_CXX_STANDARD=17 \
    -DCMAKE_TOOLCHAIN_FILE=$EMSCRIPTEN_CMAKE_DIR \
    -DCMAKE_CXX_FLAGS="${BUILD_FLAGS_CXX}" \
    -DCMAKE_C_FLAGS="${BUILD_FLAGS_C}" \
    -DCMAKE_INSTALL_PREFIX=$LIB_ROOT/suite-sparse/SuiteSparse_config/build \
    -DBUILD_SHARED_LIBS=OFF
  emmake make -j4 install

  rm -rf $LIB_ROOT/suite-sparse/CXSparse/build
  mkdir $LIB_ROOT/suite-sparse/CXSparse/build

  cd $LIB_ROOT/suite-sparse/CXSparse/build
  emcmake cmake .. \
    -DCMAKE_BUILD_TYPE=Release \
    -DCMAKE_CXX_STANDARD=17 \
    -DCMAKE_TOOLCHAIN_FILE=$EMSCRIPTEN_CMAKE_DIR \
    -DCMAKE_CXX_FLAGS="${BUILD_FLAGS_CXX}" \
    -DCMAKE_C_FLAGS="${BUILD_FLAGS_C}" \
    -DCMAKE_INSTALL_PREFIX=$LIB_ROOT/suite-sparse/CXSparse/build \
    -DBUILD_SHARED_LIBS=OFF
  emmake make -j4 install

  cd $PROJECT_ROOT
}

build_CERES_SOLVER() {
  rm -rf $LIB_ROOT/ceres-solver/build
  mkdir $LIB_ROOT/ceres-solver/build

  cd $LIB_ROOT/ceres-solver/build
  emcmake cmake .. \
    -DCMAKE_BUILD_TYPE=Release \
    -DCMAKE_CXX_STANDARD=17 \
    -DCMAKE_TOOLCHAIN_FILE=$EMSCRIPTEN_CMAKE_DIR \
    -DCMAKE_CXX_FLAGS="${BUILD_FLAGS_CXX} -march=native" \
    -DCMAKE_C_FLAGS="${BUILD_FLAGS_C} -march=native" \
    -DCMAKE_INSTALL_PREFIX=$LIB_ROOT/ceres-solver/build \
    -DBUILD_SHARED_LIBS=OFF \
    -DBUILD_EXAMPLES:BOOL=0 \
    -DBUILD_TESTING:BOOL=0 \
    -DEIGENSPARSE:BOOL=1 \
    -DMINIGLOG:BOOL=1 \
    -DEigen3_DIR=$LIB_ROOT/eigen/build/include/eigen3 \
    -DBUILD_TESTING=OFF \
    -DBUILD_EXAMPLES=OFF \
    -DBUILD_BENCHMARKS=OFF
  emmake make -j4 install

  cd $PROJECT_ROOT
}

build_OPENGV() {
  rm -rf $LIB_ROOT/opengv/build
  mkdir $LIB_ROOT/opengv/build

  cd $LIB_ROOT/opengv/build
  emcmake cmake .. \
    -DCMAKE_BUILD_TYPE=Release \
    -DCMAKE_CXX_STANDARD=17 \
    -DCMAKE_TOOLCHAIN_FILE=$EMSCRIPTEN_CMAKE_DIR \
    -DCMAKE_CXX_FLAGS="${BUILD_FLAGS_CXX}" \
    -DCMAKE_C_FLAGS="${BUILD_FLAGS_C}" \
    -DCMAKE_INSTALL_PREFIX=$LIB_ROOT/opengv/build \
    -DBUILD_SHARED_LIBS=OFF \
    -DEIGEN_INCLUDE_DIR=$LIB_ROOT/eigen/build/include/eigen3
  emmake make -j4 install

  cd $PROJECT_ROOT
}

build_WEBSLAM() {
  echo "Uncompress vocabulary ..."

  cd $PROJECT_ROOT/Vocabulary
  tar -xf ORBvoc.txt.tar.gz

  echo "Configuring and building WEB_SLAM ..."

  cd $PROJECT_ROOT
  mkdir build
  cd build
  cmake .. -DCMAKE_BUILD_TYPE=Release
  make -j4
}

if [ "$#" -eq 0 ]; then
  array=( "BOOST" "FMT" "EIGEN" "OPENBLAS" "SUITE_SPARSE" "OPENCV" "OBINDEX2" "IBOW_LCD" "SOPHUS_SOLVER" "DBoW2" "G2O" "CERES" "OPENGV" "WEBSLAM" )
else
  array=( "$@" )
fi

length=${#array[@]}
for (( i = 0; i < length; ++i )); do
  echo "Step $(($i+1))/$length -------------------------------- Start building: ${array[$i]}\n"
  build_${array[$i]}
  echo "\nStep $(($i+1))/$length -------------------------------- Complete\n"
done
