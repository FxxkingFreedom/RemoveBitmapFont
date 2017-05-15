# These are scripts that edit GASP table and remove bitmap part in Microsoft TrueType Collection font.

Windows 10 Creators Update で ClearType が縦方向に Anti-Alias するようになったということで、GASP の要らない部分を削除するだけで(まあまあ)綺麗に表示されるようになりました。MS から日本語が無視されて約二十年、長かった...

ClearType do vertical Anti-Alias on Windows 10 Creators Update. Well, some fonts become beautiful when you only edit or remove unnecessary information, for example, GASP and EDBD table. It pasts about 20 years since MS ignore Japanese. It is long long time very much.

下記スクショは、msgothic, meiryo[b], YuGothic[BLMR] の GASP を編集し、どのフォントサイズでもスムージングのみするようにしたものです。映ってる大部分が源真じゃあないかってのはありますが、分かる人が見れば分かるからってことで許してください。hook 系アプリが要らないというのはいい感じです。

In a following screen shot, Windows font rendering is only smoothing any font size by editing GASP table of msgothic, meiryo[b], YuGothic[BLMR]. Never hinting.

![result](./images/msgss.png)

GDI も DW もそこそこ綺麗になりました。縦方向 AA がデカイ！

![result](./images/cmd-ss.png)
![result](./images/edge-ss.png)
![result](./images/flashctl-ss.png)
![result](./images/notepad-ss.png)
![result](./images/tw-ss.png)


| フォント                      | 結果 | 備考        |
|:------------------------------|:----:|:------------|
| msgothic.ttc (MS Gothic)      | OK   | No problem. |
| msgothic.ttc (MS PGothic)     | OK   | No problem. |
| msgothic.ttc (MS UI Gothic)   | OK   | No problem. |
| meiryo.ttc (Meiryo)           | OK   | No problem. |
| meiryo.ttc (Meiryo Italic)    | OK   | No problem. |
| meiryo.ttc (Meiryo UI)        | OK   | No problem. |
| meiryo.ttc (Meiryo UI Italic) | OK   | No problem. |


## USAGE

### Step 0

- Install fontforge and python-fontforge.
- Copy your msgothic.ttc font to working directory.
- mkdir -p ~/Downloads/fonts


### Step 1

```
python removebitmap.py msgothic.ttc
```


### Step 2

```
Move new font in ~/Downloads/fonts/ to Windows.
```


### Step 3

```
Double-click new font and click 'Install' button.
```


### Step 4

```
exec regedit
    - HKLM\software\Microsoft\Windows NT\CurrentVersion\FontLink\SystemLink
    - HKLM\software\Microsoft\Windows NT\CurrentVersion\Fonts
Reboot Windows.
```


Enjoy!


## Changelog

- decrease argc.
- ricty 生成スクリプト群の shell スクリプトを使わなくても「Windows で幅広問題」を回避するようにしました。(ricty 同梱のスクリプトを meiryo に使うと文字化けします)


## LICENSE

MIT


## Note

標準 AA だと薄いし、アプリ側が対応してないと白黒二値化でビットマップよりひどい有様になるので、ClearType が縦に AA したのは非常に大きいと個人的には思います。ただ、未だにフォントレンダリングの処理はアプリ開発者の選択に任せてるので、例えば、どちらも MS PGothic を使用しても OneNote と Edge ではどちらも DW アプリなのに見た目が同じにならず、非常に気持ち悪いです。
