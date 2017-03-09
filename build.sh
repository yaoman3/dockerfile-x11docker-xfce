#!/bin/sh

# Get your current host nvidia driver version, e.g. 340.24
nvidia_version=$(cat /proc/driver/nvidia/version | head -n 1 | awk '{ print $8 }')
echo $nvidia_version
# We must use the same driver in the image as on the host
if test ! -f nvidia-driver.run; then
  echo here
  nvidia_driver_uri=http://us.download.nvidia.com/XFree86/Linux-x86_64/${nvidia_version}/NVIDIA-Linux-x86_64-${nvidia_version}.run
  wget -O nvidia-driver.run $nvidia_driver_uri
fi

sudo docker build -t xfce:${nvidia_version} .
sudo docker tag xfce:${nvidia_version} xfce:latest
