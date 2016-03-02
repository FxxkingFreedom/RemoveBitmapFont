# bitmap を内包した TrueType Collection から bitmap を削除するスクリプト

python 勉強用。まだ msgothic.ttc 専用。いろいろ決め打ち。未完成。

## USAGE

### Step 0
- Install dropbox, fontforge into Mac or Unix like.
- make Dropbox/removeBitmap directory. (ex: $HOME/Dropbox/removeBitmap/)
- copy your msgothic.ttc to that removeBitmap directory.

### Step 1
Breake TTC to TTFs. And fix OS/2 version bug of fontforge.
```
$ bash removeBitmap.sh step1
```
### Step 2
Adjust hinting on Windows.
```
> ttfautohint.exe
```
### Step 3
Merge TTFs to TrueType Collection.
```
$ bash removeBitmap.sh step3
```

## LICENSE

MIT

## Note
- まだ未完成なんで、ソース読んで理解した人だけ実行してください。
- hinting 調整も python でやりたいなあ...
