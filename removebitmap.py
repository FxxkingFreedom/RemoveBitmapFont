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

# fontforge setting.
fontforge.setPrefs('CoverageFormatsAllowed', 1)

# TTF flags
flags = ('opentype', 'round')


# antialias: Hints are not applied, use grayscale smoothing.
# gridfit: Use hinting in Windows.
# gridfit+smoothing: ClearType GridFitting; (hinting with ClearType).
# symmetric-smoothing: ClearType Antialiasing; (ClearType smoothing only).
#
# gridfit is hinting on Windows. So gridfit is unnecessary for me.
#

def gasp():
    return (
        (65535, ('antialias', 'symmetric-smoothing')),
    )


# Main function
#

def main(argvs):
    # Set work and save director. Please apply these to your environment.
    workDir = "Downloads/fonts"
    saveDir = "Downloads/fonts/new"

    if not os.path.exists(saveDir):
        os.makedirs(saveDir)


    ##### DO NOT CHANGE BELLOW. #####
    argc = len(argvs)

    if argc != 2:
        print "==> Usage: python %s font-file-name" % argvs[0]
        print "==>    eg. python %s msgothic.ttc" % argvs[0]
        quit()

    # set variables.
    fontFSName = argvs[1]
    tmpPrefix = "breakttc"
    homeDir = os.path.expanduser("~")
    tempDir = tempfile.mkdtemp()
    fontPath = homeDir + "/" + workDir + "/" + fontFSName

    # font file exist
    if os.path.exists(fontPath):
        print "==> Start breaking TTC."

        # Get packed family names
        familyNames = fontforge.fontsInFile(fontPath)

        # Break a TTC to some TTFs.
        i = 0
        for familyName in familyNames:
            # openName format: "msgothic.ttc(MS UI Gothic)"
            print "==> %s" % familyName
            openName = "%s(%s)" % (fontPath, familyName)

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

            # ttf へ一時的に保存する。
            font.generate(tempDir + "/" + tmpTTF, flags=flags)
            font.close()
            i += 1

        print "==> Finish breaking TTC."

        print "===> Starting generate TTC."

        # set variables.
        newTTCname = fontFSName
        newFontPath = tempDir + "/" + newTTCname
        saveFontPath = homeDir + "/" + saveDir + "/" + newTTCname
        files = glob.glob(tempDir + "/" + tmpPrefix + '[0-9]a.ttf')
        fontX = []

        # fontX に複数の ttf を登録する。
        for file in files:
            fontOpen = fontforge.open(file)
            fontX.append(fontOpen)

        # Generate TTC.
        # TTC を扱うから複数じゃないと続行しない。
        # やっぱり一つでもいいや。
        if len(fontX) > 0:
            f = fontX[0]
            fontX.pop(0)

            # fontX の中の複数の ttf を一つの ttc にする。
            f.generateTtc(newFontPath,
                          (fontX),
                          ttcflags=("merge",),
                          layer=1
            )

            # temporary 内の ttc ファイルを保存先へ移動する。
            if os.path.exists(newFontPath):
                shutil.move(newFontPath, saveFontPath)
            else:
                print "==> new TTC not found."
                quit()
        else:
            print "==> File not found or not enough fonts."
            quit()

        # 開いたフォントをそれぞれ閉じる。
        for openedFont in fontX:
            openedFont.close()

        # 新しく生成した分のフォントも閉じる。
        f.close()
        print "===> Finish generate TTC."

        # 念のため temporary directory を掃除しておく。
        shutil.rmtree(tempDir)
        print "==> Finish all."
    else:
        print "==> File not found."
        print ""

if __name__ == '__main__':
    main(sys.argv)
