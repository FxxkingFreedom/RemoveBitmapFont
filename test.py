#!/usr/bin/env python
# -*- coding: utf-8 -*-

import sys
import os
import glob
import fontforge

f1 = fontforge.fontsInFile('/tmp/msgothic.ttc');
for i in f1:
    print i
f2 = fontforge.fontsInFile('/tmp/meiryo.ttc');
for i in f2:
    print i
print "----- MS Gothic"
f = fontforge.open('/tmp/msgothic.ttc')
for x in f.sfnt_names:
    if x[1] == 'SubFamily':
        f.appendSFNTName(x[0], x[1], unicode('Bold', 'utf-8').encode('utf-16-be'))
        print f.fullname
print f.familyname
print f.temporary
f.close
print "----- Meiryo"
f = fontforge.open('/tmp/meiryo.ttc(Meiryo)')
f.simplify()
f.round()
f.autoHint()
f.autoInstr()
f.generate('/tmp/hoge.ttf')
for x in f.sfnt_names:
    print x
    # if x[1] == 'SubFamily':
    #     f.appendSFNTName(x[0], x[1], unicode('Bold', 'utf-8').encode('utf-16-be'))
    #     print f.fullname
print f.familyname
print f.temporary
f.close
os.rename('/tmp/hoge.ttf', os.environ['HOME'] + '/Dropbox/removeBitmap/hoge.ttf')

# argvs = sys.argv

# fontnames = fontforge.fontsInFile(argvs[2]);

# font = fontforge.open(argvs[2]+"("+fontnames[0]+")");
# font.close();

# font = fontforge.open(argvs[2]+"("+fontnames[1]+")");
# font.close();

# font = fontforge.open(argvs[2]+"("+fontnames[2]+")");
# font.close();

# foo = "tmp-ttf"
# files = glob.glob(foo+'[0-9]a.ttf')
# for file in files:
#     print file
