#!/usr/bin/env python
# -*- coding: utf-8 -*-

import sys, glob, fontforge;

argvs = sys.argv;
argc = len(argvs);

if argc == 1:
    print "Usage: python %s step{1|3} font-file-name prefix" % argvs[0]
    quit()

if argvs[1] == "step1":
    # Get TTC family names
    familyNames = fontforge.fontsInFile(argvs[2]);
    
    # Breake TTC
    i = 0;
    for familyName in familyNames:
        familyName = "%s(%s)" % (argvs[2], familyNames[i]); # ex, "msgothic.ttc(MS UI Gothic)"
        tmpTTF = "%s%d.ttf" % (argvs[3], i);
        font = fontforge.open(familyName);
        font.generate(tmpTTF);
        font.close();
        i += 1;
    
elif argvs[1] == "step3":
    # Generate TTC.
    newTTCname = 'new_' + argvs[2]
    files = glob.glob(argvs[3] + '[0-9]a.ttf')
    
    fontX = []
    for file in files:
        fontOpen = fontforge.open(file)
        fontX.append(fontOpen)
        
    if len(fontX) > 1:
        f = fontX[0]
        fontX.pop(0)
        f.generateTtc(newTTCname, (fontX), ttcflags = ("merge",), layer = 1);
    else:
        pass;
    
    for f in fontX:
        f.close();
    
else:
    pass;
