#!/usr/bin/python

import struct
import sys

fileName = "/home/horo/cpm/disks/disksort.ydsk"

for fileName in sys.argv[1:]:

#    dp->spt = buf[32]+(buf[33]<<8);
#    dp->bsh = buf[34];
#    dp->exm = buf[36];
#    dp->dsm = buf[37]+(buf[38]<<8);
#    dp->drm = buf[39]+(buf[40]<<8);
#    dp->off = buf[45]+(buf[46]<<8);
#    al01 = (buf[41]<<8)+buf[42];

    secSize = 2
    with open(fileName, mode='rb') as file: # b is important -> binary
        fileContent = file.read( 32 + 15 )
        spt, bsh, exm, dsm, drm, al01, off = struct.unpack( "=HBxBHHHxxH", fileContent[32:] )

    print( f"{fileName} - disk size: {2 * (dsm+1)}K, block size: {128 << bsh}, tracks: {(dsm+1) // 128} * {secSize * spt}K, directory entries: {drm+1}" )
