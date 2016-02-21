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

KEY=/path/to/mp4split.key

sudo mp4split --license-key=${KEY} $*
