# MS の TTC の gasp テーブルとビットマップ部分を削除するスクリプト

Windows 10 Creators Update で ClearType が縦方向に AA するようになったということで、gasp の要らない部分を削除するだけで(まあまあ)綺麗に表示されるようになりました。MS から日本語が無視されて約二十年、長かった...

下記スクショは、msgothic, meiryo, yugothic[BLMR] の gasp をいじってどのサイズでもスムージングのみするようにしたものです。映ってる大部分が源真じゃあないかってのはありますが、分かる人が見れば分かるからってことで許してください。hook 系アプリが要らないというのはいい感じです。

![result](./images/msgss.png)

| フォント                      | 結果 | 備考               |
|:------------------------------|:----:|:-------------------|
| msgothic.ttc (MS Gothic)      | OK   | 問題なし           |
| msgothic.ttc (MS PGothic)     | OK   | 問題なし           |
| msgothic.ttc (MS UI Gothic)   | OK   | 問題なし           |
| meiryo.ttc (Meiryo)           | NG   | 日本語だけ文字化け |
| meiryo.ttc (Meiryo Italic)    | OK   | サムネだけおかしい |
| meiryo.ttc (Meiryo UI)        | OK   | 問題なし           |
| meiryo.ttc (Meiryo UI Italic) | OK   | 問題なし           |


## USAGE

### Step 0
- Install fontforge.
- Copy your ttc font to working directory.

### Step 1
```
python removebitmap.py msgothic.ttc rbf-tmp
```

### Step 2
```
Exec rmDefaultFonts.bat as administrator.
```

### Step 3
```
double-click new ttc font and click install button.
```


## LICENSE

MIT


## Note

標準 AA だと薄いし、アプリ側が対応してないと白黒二値化でビットマップよりひどい有様になるので、ClearType が縦に AA したのは大きいです。ただ、未だにフォントレンダリングの処理はアプリ開発者の選択に任せてるので、例えば OneNote と Edge を比べても同じ DW なアプリなのに見た目がちぐはぐです。
