# These are scripts that remove a part of GASP table and bitmap data in Microsoft TrueType Collection font.

Windows 10 Creators Update で ClearType が[縦方向に Anti-Alias するようになった](http://silight.hatenablog.jp/entry/2017/05/03/144138)ということで、GASP テーブルの不要部分を削除するだけで(まあまあ)綺麗に表示されるようになりました。まだ、FreeType にすら劣りますが、これまでのフォントレンダリングと比べたらものすごいマシです。MS が日本語を無視してから約二十年、長かった...。

ClearType do vertical Anti-Alias on Windows 10 Creators Update. Well, some fonts become beautiful when you only remove unnecessary information, for example, a part of GASP table. It pasts about 20 years since MS ignore Japanese. It is long long time very much.

下のスクショは、msgothic, meiryo[b], YuGoth[BLMR] の GASP テーブルの一部とビットマップフォントデータを削除し、どのフォントサイズでもスムージングのみするようにしたものです。映ってる大部分が源真じゃあないかってのはありますが、分かる人が見れば分かると思います。hook 系アプリが必要ないので Windows Update でコケたり、GSOD になることはありません。

In a following screen shot, Windows font renderer executes only smoothing even any font size by editing GASP table of msgothic, meiryo[b], YuGothic[BLMR]. Never hinting.

![result](./images/msgss.png)

GDI も DW もそこそこ綺麗になりました。縦方向 AA がデカイ！

- cmd (MS Gothic)

![result](./images/cmd-ss.png)

- Edge

![result](./images/edge-ss.png)

- Flash Player Manager (MS UI Gothic)

![result](./images/flashctl-ss.png)

- Install Sheld (MS UI Gothic?)

![result](./images/installer-ss.png)

- notepad (MS Gothic)

![result](./images/notepad-ss.png)

- Store App (Twitter (YuGoth*))

![result](./images/tw-ss.png)


## Result

| フォント                            | 結果 | 備考        |
|:------------------------------------|:----:|:------------|
| msgothic.ttc (MS Gothic)            | OK   | No problem. |
| msgothic.ttc (MS PGothic)           | OK   | No problem. |
| msgothic.ttc (MS UI Gothic)         | OK   | No problem. |
| meiryo.ttc (Meiryo)                 | OK   | No problem. |
| meiryo.ttc (Meiryo Italic)          | OK   | No problem. |
| meiryo.ttc (Meiryo UI)              | OK   | No problem. |
| meiryo.ttc (Meiryo UI Italic)       | OK   | No problem. |
| meiryob.ttc (Meiryo Bold)           | OK   | No problem. |
| meiryob.ttc (Meiryo Italic Bold)    | OK   | No problem. |
| meiryob.ttc (Meiryo UI Bold)        | OK   | No problem. |
| meiryob.ttc (Meiryo UI Italic Bold) | OK   | No problem. |

YuGo* の結果は割愛。


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
- ricty 生成スクリプト群の os2version_riviser.sh を使わなくても「Windows で幅広問題」を回避するようにしました。(ricty 同梱のスクリプトを meiryo に使うと文字化けします)


## LICENSE

MIT
