# These are scripts that remove a part of GASP table and bitmap data in Microsoft TrueType Collection font.

## Description
Windows 10 Creators Update で ClearType が[縦方向に Anti-Alias するようになった](http://silight.hatenablog.jp/entry/2017/05/03/144138)ということで、GASP テーブルの不要部分を削除するだけで(まあまあ)綺麗に表示されるようになりました。まだ、FreeType にすら劣りますが、これまでのフォントレンダリングと比べたらものすごいマシです。MS が日本語を無視してから約二十年、長かった...。

ClearType do vertical Anti-Alias on Windows 10 Creators Update. Well, some fonts become beautiful when you only remove unnecessary information, for example, a part of GASP table. It pasts about 20 years since MS ignore Japanese. It is long long time very much.


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


## Screenshot
GDI も DW もそこそこ綺麗になりました。縦方向 AA がデカイ！下のスクショは、msgothic, meiryo[b], YuGoth[BLMR] の GASP テーブルの一部とビットマップフォントデータを削除し、どのフォントサイズでもスムージングのみするようにしたものです。映ってる大部分が源真じゃあないかってのはありますが、分かる人が見れば分かると思います。hook 系アプリが必要ないので Windows Update でコケたり、GSOD になることはありません。

![result](./images/msgss.png)

### cmd (MS Gothic)
![result](./images/cmd-ss.png)

### Edge
![result](./images/edge-ss.png)

### Flash Player Manager (MS UI Gothic)
![result](./images/flashctl-ss.png)

### Install Sheld (MS UI Gothic)
![result](./images/installer-ss.png)

### notepad (MS Gothic)
![result](./images/notepad-ss.png)

### Store App (YuGoth*)
![result](./images/tw-ss.png)


## USAGE
### Step 0
- Install fontforge (20161012_1) ~~and python-fontforge~~.
   * If you use Mac, install fontforge via [homebrew](https://brew.sh).
   * If you use Linux or WSL, install fontforge via [linuxbrew](http://linuxbrew.sh).
   * I confirm this script on EL Capitan, Sierra, High Sierra, WSL.
- Copy your msgothic.ttc from Windows to working directory.
   * mkdir -p ~/Downloads/fonts
- Make save directory
   * mkdir ~/Downloads/fonts/new


### Step 1
```
python removebitmap.py msgothic.ttc
```


### Step 2
```
Move new fonts in ~/Downloads/fonts/new to Windows.
```


### Step 3
```
Double click new font and click 'Install' button.
```


### Step 4
```
exec regedit
    - HKLM\software\Microsoft\Windows NT\CurrentVersion\FontLink\SystemLink
    - HKLM\software\Microsoft\Windows NT\CurrentVersion\Fonts

Reboot Windows.
```

Enjoy!


## Registory files

### default-fonts.reg
HKLM\\...\\CurrentVersion\\Fonts レジストリのデフォルト。

### default-systemlink.reg
HKLM\\...\\CurrentVersion\\Fontlink\\SystemLink レジストリのデフォルト。

### gamma-value.reg
某掲示板情報によると未だに Cleartype Tuner にはバグがあり、一度でも Cleartype Tuner を使うと gamma 値が固定されてしまうそうな。

### nohinting-gm.reg
msgothic と meiryo[b] の読み込み先を差し替える fonts レジストリ。

### nohinting-gmy.reg
msgothic と meiryo[b] と YuGoth[BLMR] の読み込み先を差し替える fonts レジストリ。

### nohinting-systemlink-gm.reg
msgothic と meiryo[b] のリンク先を差し替える SystemLink レジストリ。

### nohinting-systemlink-gmy.reg
msgothic と meiryo[b] と YuGoth[BLMR] のリンク先を差し替える SystemLink レジストリ。


## Changelog

- decrease argc.
- Ricty 生成スクリプト群の os2version_riviser.sh を使わなくても「Windows で幅広問題」を回避するようにしました。(Ricty 同梱のスクリプトを meiryo に使うと文字化けします)


## LICENSE

MIT
