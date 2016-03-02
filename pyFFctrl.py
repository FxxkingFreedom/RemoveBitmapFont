#!/usr/bin/env python
# -*- coding: utf-8 -*-

import sys, fontforge

argvs = sys.argv
argc = len(argvs)

if argc == 1:
    print "Usage: python %s step{1|3}" % argvs[0]
    quit()

if argvs[1] == "step1":
    # Breake TTC.
    font = fontforge.open("msgothic.ttc(MS Gothic)");
    font.generate('tmp-msgM.ttf');
    font.close();
    
    font = fontforge.open("msgothic.ttc(MS UI Gothic)");
    font.generate("tmp-msgUI.ttf");
    font.close();
    
    font = fontforge.open("msgothic.ttc(MS PGothic)");
    font.generate("tmp-msgP.ttf");
    font.close();
    
elif argvs[1] == "step3":
    # Generate TTC.
    fontM = fontforge.open('tmp-msgMa.ttf');
    fontP = fontforge.open('tmp-msgPa.ttf');
    fontUI = fontforge.open('tmp-msgUIa.ttf');
    
    if fontM and fontP and fontUI:
        fontM.generateTtc('newMSGothic.ttc', (fontP, fontUI), ttcflags = ("merge",), layer = 1);
    else:
        pass;
    
    fontM.close();
    fontP.close();
    fontUI.close();
    
else:
    pass;
