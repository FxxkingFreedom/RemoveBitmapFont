# bitmap を内包した TrueType Collection から bitmap を削除するスクリプト

python 勉強用。まだ msgothic.ttc 専用。いろいろ決め打ち。未完成。

## USAGE

### Step 0
- Install dropbox, fontforge into Mac or Unix like.
- Make 'removeBitmap' directory in Dropbox. (ex: $HOME/Dropbox/removeBitmap/)
- Copy your msgothic.ttc to that 'removeBitmap' directory.

### Step 1
Breake TrueType Collection to TTFs. And fix OS/2 version bug of fontforge.
```
$ bash removeBitmap.sh step1
```
### Step 2
Adjust hinting on Windows.
```
C:\hogehoge> ttfautohint.exe
```
### Step 3
Merge TTFs to TTC.
```
$ bash removeBitmap.sh step3
```

## LICENSE

MIT

## Note
- EL Capitan beta 5 で動作確認済み。
- しかし未完成なので、ソース読んで理解した人だけ実行してください。
- hinting 調整も python でやりたいなあ...
