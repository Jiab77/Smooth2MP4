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

FILE=$1
FFMPEG=/path/to/ffmpeg
CROP=`${FFMPEG} -ss 00:05:00 -i ${FILE} -t 1 -vf cropdetect -f null - 2>&1 | awk '/crop/ { print $NF }' | tail -1`

echo -e "\nFound crop value:\n\t-${CROP}\n"