#!/usr/bin/env python
# -*- coding: utf-8 -*-

import sys,glob,fontforge

# f = fontforge.fontsInFile('/tmp/msgothic.ttc');
# for i in f:
#     print i

# argvs = sys.argv

# fontnames = fontforge.fontsInFile(argvs[2]);

# font = fontforge.open(argvs[2]+"("+fontnames[0]+")");
# font.close();

# font = fontforge.open(argvs[2]+"("+fontnames[1]+")");
# font.close();

# font = fontforge.open(argvs[2]+"("+fontnames[2]+")");
# font.close();

foo = "tmp-ttf"
files = glob.glob(foo+'[0-9]a.ttf')
for file in files:
    print file