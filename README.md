# MS の TTC の gasp テーブルとビットマップ部分を削除するスクリプト

Windows 10 Creators Update で ClearType が縦方向に Anti-Alias するようになったということで、gasp の要らない部分を削除するだけで(まあまあ)綺麗に表示されるようになりました。MS から日本語が無視されて約二十年、長かった...

下記スクショは、msgothic, meiryo[b], YuGothic[BLMR] の gasp を編集し、どのフォントサイズでもスムージング***のみ***するようにしたものです。映ってる大部分が源真じゃあないかってのはありますが、分かる人が見れば分かるからってことで許してください。hook 系アプリが要らないというのはいい感じです。

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

- Install fontforge and python-fontforge.
- Copy your msgothic.ttc font to working directory.


### Step 1

```
python removebitmap.py msgothic.ttc rbf-tmp
```


### Step 2

```
Move new font to Windows.
Exec rmDefaultFonts.bat as administrator.
```


### Step 3

```
double-click new msgothic.ttc and click 'Install' button.
Reboot Windows.
```


Enjoy!


## LICENSE

MIT


## Note

標準 AA だと薄いし、アプリ側が対応してないと白黒二値化でビットマップよりひどい有様になるので、ClearType が縦に AA したのは非常に大きいと個人的には思います。ただ、未だにフォントレンダリングの処理はアプリ開発者の選択に任せてるので、例えば、どちらも MS PGothic を使用しても OneNote と Edge ではどちらも DW アプリなのに見た目が同じにならず、非常に気持ち悪いです。
