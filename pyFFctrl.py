#!/usr/bin/env python
# -*- coding: utf-8 -*-
#
# Usage: python %s step{1|3} font-file-name prefix
#
# argv[1] ... step1 or step3
# argv[2] ... font file name
# argv[3] ... temporary file prefix
#
# eg. python pyFFctrl.py step1 meiryo.ttc rbf-tmp-ttf

import sys
import glob
import fontforge

fontforge.setPrefs('CoverageFormatsAllowed', 1)

# – antialias: Hints are not applied, use grayscale smoothing.
# – gridfit: Use hints.
# – gridfit+smoothing: ClearType GridFitting.
# – symmetric-smoothing: ClearType Antialiasing.
def gasp():
    return (
        (8,     ('symmetric-smoothing') ),
        (23,    ('antialias', 'symmetric-smoothing') ),
        (65535, ('antialias', 'gridfit', 'symmetric-smoothing', 'gridfit+smoothing') ),
    )

def main(argvs):
    argc = len(argvs)
    
    if argc != 4:
        print "======> Usage: python %s step{1|3} font-file-name prefix" % argvs[0]
        print "======>    eg. python %s step1 msgothic.ttc rbf-tmp-ttf" % argvs[0]
        quit()
    
    stepSeq = argvs[1]
    fontFSName = argvs[2]
    tmpPrefix = argvs[3]
    
    # Step 1
    if stepSeq == "step1":
        # Get packed family names
        familyNames = fontforge.fontsInFile(fontFSName)
        # flags = ('opentype', 'TeX-table', 'round', 'dummy-dsig')
        flags = ('opentype')
        
        # Breake TTC
        i = 0
        for familyName in familyNames:
            # openName: "msgothic.ttc(MS UI Gothic)"
            openName = "%s(%s)" % (fontFSName, familyName)
            print "======> openName: %s" % openName
            # tmp file name: rbf-tmp-ttf0a.ttf and rbf-tmp-ttf1a.ttf and so on.
            tmpTTF = "%s%da.ttf" % (tmpPrefix, i)
            print "======> tmpTTF: %s" % tmpTTF
            
            # Open font
            font = fontforge.open(openName)
            
            # Edit font
            # font.encoding = 'UnicodeFull'
            # font.selection.all()
            # font.simplify()
            # font.round()
            # font.autoHint()
            # font.autoInstr()
            font.gasp = gasp()
            font.gasp_version = 1
            
            # Generate font
            font.generate(tmpTTF, flags = flags)
            font.close()
            i += 1
        print "======> Breake TTC."
    # Step 3
    elif stepSeq == "step3":
        newTTCname = 'new_' + fontFSName
        files = glob.glob(tmpPrefix + '[0-9]a.ttf')
        fontX = []
        
        for file in files:
            fontOpen = fontforge.open(file)
            fontX.append(fontOpen)
            
        # Generate TTC.
        if len(fontX) > 1:
            f = fontX[0]
            fontX.pop(0)
            f.generateTtc(newTTCname, (fontX), ttcflags = ("merge",), layer = 1)
        else:
            print "======> Fonts not found. Or it is not enough fonts."
            quit()
            
        for openedFont in fontX:
            openedFont.close()
            
        f.close()
        print "======> Generate TTC."
    # Other
    else:
        pass

if __name__ == '__main__':
    main(sys.argv)
