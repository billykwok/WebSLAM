#!/bin/sh

echo "Downloading dependencies..."

cd libs/

curl -# -L -Z \
  https://boostorg.jfrog.io/artifactory/main/release/1.81.0/source/boost_1_81_0.tar.gz \
  https://github.com/fmtlib/fmt/releases/download/9.1.0/fmt-9.1.0.zip \
  https://github.com/xianyi/OpenBLAS/releases/download/v0.3.22/OpenBLAS-0.3.22.tar.gz \
  https://github.com/DrTimothyAldenDavis/SuiteSparse/archive/v7.0.1.tar.gz \
  https://github.com/ceres-solver/ceres-solver/archive/master.tar.gz \
  https://github.com/strasdat/Sophus/archive/1.22.10.tar.gz \
  https://gitlab.com/libeigen/eigen/-/archive/3.4.0/eigen-3.4.0.tar.gz \
  https://github.com/opencv/opencv/archive/4.7.0.tar.gz \
  https://github.com/emiliofidalgo/obindex2/archive/master.tar.gz \
  https://github.com/laurentkneip/opengv/archive/master.tar.gz \
  -o boost_1_81_0.tar.gz \
  -o fmt_9_1_0.zip \
  -o openblas_0_3_22.tar.gz \
  -o suite_sparse_7_0_1.tar.gz \
  -o ceres_solver_source.tar.gz \
  -o sophus_1_22_10.tar.gz \
  -o eigen_3_4_0.tar.gz \
  -o opencv_4_7_0.tar.gz \
  -o obindex2_source.tar.gz \
  -o opengv_source.tar.gz

mkdir boost/
tar -xf boost_1_81_0.tar.gz -C boost/ --strip=1
rm boost_1_81_0.tar.gz

mkdir fmt/
tar -xf fmt_9_1_0.tar.gz -C fmt/ --strip=1
rm fmt_9_1_0.tar.gz

mkdir boost/
tar -xf openblas_0_3_22.tar.gz -C openblas/ --strip=1
rm openblas_0_3_22.tar.gz

mkdir suite-sparse/
tar -xf suite_sparse_7_0_1.tar.gz -C suite-sparse/ --strip=1
rm suite_sparse_7_0_1.tar.gz

mkdir ceres-solver/
tar -xf ceres_solver_source.tar.gz -C ceres-solver/ --strip=1
rm ceres_solver_source.tar.gz

mkdir sophus/
tar -xf sophus_1_22_10.tar.gz -C sophus/ --strip=1
rm sophus_1_22_10.tar.gz

mkdir eigen/
tar -xf eigen_3_4_0.tar.gz -C eigen/ --strip=1
rm eigen_3_4_0.tar.gz

mkdir opencv/
tar -xf opencv_4_7_0.tar.gz -C opencv/ --strip=1
rm opencv_4_7_0.tar.gz

mkdir obindex2/
tar -xf obindex2_source.tar.gz -C obindex2/ --strip=1
rm obindex2_source.tar.gz

mkdir opengv/
tar -xf opengv_source.tar.gz -C opengv/ --strip=1
rm opengv_source.tar.gz

cd ../
