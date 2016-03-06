#!/usr/bin/env python
# -*- coding: utf-8 -*-

import sys
import glob
import fontforge

def getprep(font):
    if font.getTableData("prep") == None:
        return "None"
    prepAsm = font.getTableData("prep")
    prepText = fontforge.unParseTTInstrs(prepAsm)
    return prepText

argvs = sys.argv
argc = len(argvs)

# TODO: use paramXXXX
if argc == 1:
    print "  Usage: python %s step{1|3} font-file-name prefix" % argvs[0]
    print "    ex, python %s step1 meiryo.ttc tmp-ttf" % argvs[0]
    quit()

fontforge.setPrefs('CoverageFormatsAllowed', 1)

# Step 1
if argvs[1] == "step1":
    # Get TTC family names
    familyNames = fontforge.fontsInFile(argvs[2])
    # flags = ('opentype', 'TeX-table', 'round', 'dummy-dsig')
    flags = ('opentype', 'round')
    
    # Breake TTC
    i = 0
    for familyName in familyNames:
        openName = "%s(%s)" % (argvs[2], familyName) # ex, "msgothic.ttc(MS UI Gothic)"
        tmpTTF = "%s%da.ttf" % (argvs[3], i)
        
        # Open font
        font = fontforge.open(openName)
        print openName
        
        # Edit font
        font.encoding = 'UnicodeFull'
        # font.selection.all()
        font.simplify()
        font.round()
        font.autoHint()
        font.autoInstr()
        font.gasp = ((65535, ('gridfit', 'antialias', 'symmetric-smoothing', 'gridfit+smoothing')),)
        font.gasp_version = 1
        
        # Generate font
        font.generate(tmpTTF, flags = flags)
        font.close()
        i += 1

    print "End breake TTC."
# Step 3
elif argvs[1] == "step3":
    newTTCname = 'new_' + argvs[2]
    files = glob.glob(argvs[3] + '[0-9]a.ttf')
    fontX = []
    
    for file in files:
        fontOpen = fontforge.open(file)
        fontX.append(fontOpen)
        
    if len(fontX) > 1:
        # Generate TTC.
        f = fontX[0]
        fontX.pop(0)
        f.generateTtc(newTTCname, (fontX), ttcflags = ("merge",), layer = 1)
    else:
        print "Fonts not found."
        quit()
    
    for font in fontX:
        font.close()
    f.close()
    print "End generate TTC"
# Other
else:
    pass
