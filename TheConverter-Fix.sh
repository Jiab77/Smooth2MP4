#!/bin/bash

# Smooth2MP4 - Just a POC to convert old VC1 SmoothStreaming files to MP4
# Copyright (C) 2014 - 2016  Jiab77 <jonathan.barda@gmail.com>
# 
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
# 
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.

FFMPEG=/path/to/ffmpeg
VIDEO_ENC=libx264
AUDIO_ENC=libfdk_aac
FOLDER=$1
MOVIE=$2
AUDIO=$3
LANG=$4

#for LAYER in 6000 5027 2962 2056 1427 991 688 # Medium HD
#for LAYER in 2500 1500 1288 1105 949 814 699 # Good SD
#for LAYER in 1462 1215 1010 839 697 # Medium SD
for LAYER in 1157 994 854 734 # Bad SD
do
	# Creating the MP4 File
	./TheSpliter.sh -o ${FOLDER}/${MOVIE}_${LAYER}000.mp4 ${FOLDER}/${MOVIE}_${LAYER}000.ismv --track_type=video \
	--track_language=${LANG} ${FOLDER}/${AUDIO} --track_type=audio --track_language=${LANG}

	# Extracting the video track from the MP4
	MP4Box -new -raw 2 ${FOLDER}/${MOVIE}_${LAYER}000.mp4 -out ${FOLDER}/${MOVIE}_${LAYER}000.h264

	# Extracting the audio track from the MP4
	MP4Box -new -raw 1 ${FOLDER}/${MOVIE}_${LAYER}000.mp4 -out ${FOLDER}/${MOVIE}_${LAYER}000.aac

	# Re-Encoding the video track to H264
	$FFMPEG -y -i ${FOLDER}/${MOVIE}_${LAYER}000.h264 -r 25 -pix_fmt yuv420p -c:v ${VIDEO_ENC} \
	-x264opts threads=0:bitrate=${LAYER}:vbv-maxrate=${LAYER}:vbv-bufsize=${LAYER}:level=51:bframes=2:b-adapt=2:b-pyramid=0:ref=2:deblock=-1,-1:chroma-qp-offset=1:mvrange=511:aq-mode=1:trellis=2:me=hex:subme=7:intra-refresh=0:partitions=all:keyint=33:min-keyint=33:scenecut=-1 \
	${FOLDER}/${MOVIE}_${LAYER}000-fixed.h264

	# Joining the audio and video track MP4 container
	MP4Box -brand mp42 -no-iod -mpeg4 -add "${FOLDER}/${MOVIE}_${LAYER}000-fixed.h264:name=${MOVIE}_${LAYER}000-fixed.h264:lang=${ORG_LANG}" ${FOLDER}/${MOVIE}_${LAYER}.mp4
	MP4Box -brand mp42 -no-iod -mpeg4 -add "${FOLDER}/${MOVIE}_${LAYER}000.aac:name=${MOVIE}_${LAYER}000.aac:lang=${LANG}" ${FOLDER}/${MOVIE}_${LAYER}.mp4
done
