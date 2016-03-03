#!/usr/bin/env python
# -*- coding: utf-8 -*-

import sys, fontforge;

argvs = sys.argv;
argc = len(argvs);

if argc == 1:
    print "Usage: python %s step{1|3} font-file-name tmp-m tmp-p tmp-ui" % argvs[0]
    quit()

if argvs[1] == "step1":
    tmpM = argvs[3];
    tmpP = argvs[4];
    tmpUI = argvs[5];
    
    # Get TTC familynames
    fontnames = fontforge.fontsInFile(argvs[2]);
    
    # Breake TTC
    # TODO: family が 3つだったり 4つだったりするから動的に処理するように
    mFont = "%s(%s)" % (argvs[2], fontnames[0]); # ex: msgothic.ttc(MS Gothic)
    font = fontforge.open(mFont);
    font.generate(tmpM);
    font.close();
    
    pFont = "%s(%s)" % (argvs[2], fontnames[1]); # ex: msgothic.ttc(MS PGothic)
    font = fontforge.open(pFont);
    font.generate(tmpP);
    font.close();
    
    uFont = "%s(%s)" % (argvs[2], fontnames[2]); # ex: msgothic.ttc(MS UI Gothic)
    font = fontforge.open(uFont);
    font.generate(tmpUI);
    font.close();
    
elif argvs[1] == "step3":
    # Generate TTC.
    tmpMa = argvs[3];
    tmpPa = argvs[4];
    tmpUIa = argvs[5];
    newTTCname = 'new_' + argvs[2];
    
    fontM = fontforge.open(tmpMa);
    fontP = fontforge.open(tmpPa);
    fontUI = fontforge.open(tmpUIa);
    
    if fontM and fontP and fontUI:
        fontM.generateTtc(newTTCname, (fontP, fontUI), ttcflags = ("merge",), layer = 1);
    else:
        pass;
    
    fontM.close();
    fontP.close();
    fontUI.close();
    
else:
    pass;
