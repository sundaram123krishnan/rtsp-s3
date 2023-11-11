#!/bin/bash

time=`date '+%Y_%m_%d__%H_%M_%S'`;

# Specific for each camera
CameraName=ur-camera-name #camera name can be anything, just for the folder name
CameraIP='ur-camera-ip'

CameraUsername='cam-user-name'
CameraPassword='ur-cam-password'

# Shouldn't need to be changed!
StorageDirectory=enter-path
StorageFilename=$CameraName-$time.png

mkdir -p $StorageDirectory/$CameraName;

ffmpeg -rtsp_transport tcp -i rtsp://$CameraUsername:$CameraPassword@$CameraIP:554/ur-streaming-channel -ss 00:00:01.50 -vframes 1 $StorageDirectory/$CameraName/$StorageFilename -nostats -hide_banner -v 0 -loglevel quiet

aws s3 mv $StorageDirectory/$CameraName/$StorageFilename s3://ur-bucket-name

