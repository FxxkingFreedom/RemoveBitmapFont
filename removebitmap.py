#!/usr/bin/env python
# -*- coding: utf-8 -*-
#
# Usage: python %s font-file-name
#    argv[1] ... font file name
# eg. python removebitmap.py meiryo.ttc
#

import sys
import glob
import fontforge
import tempfile
import os
import shutil
import subprocess

fontforge.setPrefs('CoverageFormatsAllowed', 1)

# TTF flags
flags = ('opentype', 'round')

#
# antialias: Hints are not applied, use grayscale smoothing.
# gridfit: Use hinting in Windows.
# gridfit+smoothing: ClearType GridFitting.
# symmetric-smoothing: ClearType Antialiasing.
#
# gridfit is hinting on Windows. So gridfit is unnecessary for me.
#
def gasp():
    return (
        (65535, ('antialias', 'symmetric-smoothing')),
    )

def main(argvs):
    #
    # Set work directory and save director.
    # Please apply these to your environment.
    #
    workDir = "Downloads/fonts"
    saveDir = "Downloads/fonts/new"

    #
    # DO NOT CHANGE BELLOW.
    #
    argc = len(argvs)

    if argc != 2:
        print "==> Usage: python %s font-file-name" % argvs[0]
        print "==>    eg. python %s msgothic.ttc" % argvs[0]
        quit()

    fontFSName = argvs[1]

    tmpPrefix = "breakttc"
    homeDir = os.path.expanduser("~")
    tempDir = tempfile.mkdtemp()
    # print tempDir

    # font file exist
    if os.path.exists(homeDir + "/" + workDir + "/" + fontFSName):
        print "==> Start breaking TTC."

        # Get packed family names
        familyNames = fontforge.fontsInFile(homeDir + "/" + workDir + "/" + fontFSName)

        # Break TTC. TTC => TTF.
        i = 0
        for familyName in familyNames:
            # openName format: "msgothic.ttc(MS UI Gothic)"
            print "==> %s" % familyName
            openName = "%s(%s)" % (homeDir + "/" + workDir + "/" + fontFSName, familyName)

            # tmp file name: breakttf0a.ttf and breakttf1a.ttf and so on.
            tmpTTF = "%s%da.ttf" % (tmpPrefix, i)

            # Open font
            font = fontforge.open(openName)

            # Edit font
            font.encoding = 'UnicodeFull'
            font.gasp = gasp()
            font.gasp_version = 1
            font.os2_vendor = "maud"
            font.os2_version = 1 # Windows で幅広問題を回避する。

            # Generate font
            font.generate(tempDir + "/" + tmpTTF, flags=flags)
            font.close()
            i += 1
        print "==> Finish breaking TTC."

        print "==> Starting generate TTC."
        newTTCname = fontFSName
        files = glob.glob(tempDir + "/" + tmpPrefix + '[0-9]a.ttf')
        fontX = []

        for file in files:
            fontOpen = fontforge.open(file)
            fontX.append(fontOpen)

        # Generate TTC.
        if len(fontX) > 1:
            f = fontX[0]
            fontX.pop(0)
            f.generateTtc(tempDir + "/" + newTTCname, (fontX), ttcflags=("merge",), layer=1)

            if os.path.exists(tempDir + "/" + newTTCname):
                shutil.move(tempDir + "/" + newTTCname, homeDir + "/" + saveDir + "/" + newTTCname)
            else:
                print "==> new TTC not found."
                quit()
        else:
            print "==> File not found or not enough fonts."
            quit()

        for openedFont in fontX:
            openedFont.close()

        f.close()
        print "==> Generated TTC."

        shutil.rmtree(tempDir)

        print "==> Finish all."

    # file not found
    else:
        print "==> File not found."
        print ""

if __name__ == '__main__':
    main(sys.argv)
