# bitmap を内包した TrueType Collection から bitmap を削除するスクリプト

python 勉強用。~~~まだ msgothic.ttc 専用。~~~汎用性向上で msgothic.ttc 以外の TTC でも自動的にファミリー名を取得するからおk。でも未完成。

## USAGE

### Step 0
- Install dropbox, fontforge into Mac or Unix like.
- Make 'removeBitmap' directory in Dropbox. (ex: $HOME/Dropbox/removeBitmap/)
- Copy your foo.ttc to that 'removeBitmap' directory.

### Step 1
Breake TrueType Collection to TTFs. And fix OS/2 version bug of fontforge.
```
$ bash removeBitmap.sh step1 hoge.ttc
```
### Step 2
Adjust hinting on Windows.
```
C:\hogehoge> ttfautohint.exe
```
### Step 3
Merge TTFs to TTC.
```
$ bash removeBitmap.sh step3 hoge.ttc
```

## LICENSE

MIT

## Note
- InstallforWin7.bat and UninstallforWin7.bat work only msgothic.ttc.
- EL Capitan beta 5 で動作確認済み。
- しかし未完成なので、ソース読んで理解した人だけ実行してください。
- hinting 調整も python でやりたいなあ...
