#!/usr/bin/env python
# -*- coding: utf-8 -*-

import sys, fontforge;

argvs = sys.argv;
argc = len(argvs);

if argc == 1:
    print "Usage: python %s step{1|3} font-file-name tmp-m tmp-p tmp-ui" % argvs[0]
    quit()

if argvs[1] == "step1":
    # TODO: get argvs[2] info by fontforge. and fontforge.open()
    
    # Breake TTC.
    tmpM = argvs[3];
    tmpP = argvs[4];
    tmpUI = argvs[5];
    
    fontnames = fontforge.fontsInFile(argvs[2]);
    
    font = fontforge.open(argvs[2]+"("+fontnames[0]+")");
    font.generate(tmpM);
    font.close();
    
    font = fontforge.open(argvs[2]+"("+fontnames[1]+")");
    font.generate(tmpP);
    font.close();
    
    font = fontforge.open(argvs[2]+"("+fontnames[2]+")");
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
