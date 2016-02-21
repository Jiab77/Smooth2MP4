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

VIDEO_ENC=libx264
AUDIO_ENC=libfdk_aac
FOLDER=$1
MOVIE=$2
AUDIO=$3
LANG=$4

for LAYER in 699 814 949 1105 1288 1500 2500
do
	# Creating the MP4 File
	./TheSpliter.sh -o ${FOLDER}/${MOVIE}_${LAYER}000.mp4 ${FOLDER}/${MOVIE}_${LAYER}000.ismv --track_type=video \
	--track_language=${LANG} ${FOLDER}/${AUDIO} --track_type=audio --track_language=${LANG}

	# Joining the audio and video track MP4 container
	MP4Box -lang ${LANG} -brand mp42 -no-iod -mpeg4 ${FOLDER}/${MOVIE}_${LAYER}000.mp4

	# Renaming the file with the right name
	mv -v ${FOLDER}/${MOVIE}_${LAYER}000.mp4 ${FOLDER}/${MOVIE}_${LAYER}.mp4
done
