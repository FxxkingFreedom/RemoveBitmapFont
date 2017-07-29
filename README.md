# This is a python script that removing a part of GASP table and bitmap data in Microsoft TrueType Collection font.

## Description
Windows 10 Creators Update で ClearType が[TTF でも縦方向に Anti-Alias するようになった](http://silight.hatenablog.jp/entry/2017/05/03/144138)ということなので、TTF 内の GASP テーブルの不要部分を削除しました。これをするだけで比較的綺麗にフォントが描画されるようになりました。まだ、FreeType にすら劣りますが、これまでのフォントレンダリングと比べたらものすごいマシです。MS が日本語を無視してから約二十年、長かった...。


## Result
| Fonts                               | Result | Note        |
|:------------------------------------|:------:|:------------|
| msgothic.ttc (MS Gothic)            | OK     | No problem. |
| msgothic.ttc (MS PGothic)           | OK     | No problem. |
| msgothic.ttc (MS UI Gothic)         | OK     | No problem. |
| meiryo.ttc (Meiryo)                 | OK     | No problem. |
| meiryo.ttc (Meiryo Italic)          | OK     | No problem. |
| meiryo.ttc (Meiryo UI)              | OK     | No problem. |
| meiryo.ttc (Meiryo UI Italic)       | OK     | No problem. |
| meiryob.ttc (Meiryo Bold)           | OK     | No problem. |
| meiryob.ttc (Meiryo Italic Bold)    | OK     | No problem. |
| meiryob.ttc (Meiryo UI Bold)        | OK     | No problem. |
| meiryob.ttc (Meiryo UI Italic Bold) | OK     | No problem. |

YuGo* の結果は割愛。


### Screenshot
GDI も DW もそこそこ綺麗になりました。縦方向 Anti-Alias の影響は大きいです。下のスクショは、msgothic.ttc, meiryo[b].ttc, YuGoth[BLMR].ttc の GASP テーブルの一部と msgothic.ttc のビットマップデータを削除することで、どのフォントサイズでもスムージングのみ、すなわち hinting を無視するようにしたものです。映ってる大部分が源真ゴシックじゃあないかというのはありますが、分かる人が見れば分かると思います。hook 系アプリを必要としないので Windows Update が失敗したり、特定のアプリが動かなかったり、GSOD になったり、ということはありません。

本来ならばフォントデータに手を加えるのではなく、ClearType が GASP テーブルを無視すべきだと思うのですが、未だに MS はそれをしないのが理解できません。例えば ClearType tuner に hinting を無視するオプションを追加して、ここが ON なら GASP テーブルを無視するとかでもいいんじゃないかと思います。

![result](./images/msgss.png)

アプリ個別のスクショは以下の通りです。GitHub 上では分からないと思いますので画像をダウンロードして、画像ビューワで実物大でご覧ください。

### cmd (MS Gothic)
bash.exe もこの描画になるので WSL で色々と遊びたくなります。

![result](./images/cmd-ss.png)

### Edge
このスクショでは主に Meiryo を表示しています。ClearType と既存の Meiryo で特有の崩れた字体にならずバランスがとても良くなります。

![result](./images/edge-ss.png)

### Flash Player Manager (MS UI Gothic)
![result](./images/flashctl-ss.png)

### Install Sheld (MS UI Gothic)
![result](./images/installer-ss.png)

### notepad (MS Gothic)
![result](./images/notepad-ss.png)

### Store App (YuGoth*)
YuGothic 系は違いが小さくて分かりづらいですが、文字によって字体のバランスが良くなります。やはり今までの ClearType は害悪なのでは？ボブは訝しんだ。

![result](./images/tw-ss.png)

msmincho や segoue などの GASP もいじれば統一感が出て Windows の見栄えもより良くなると思います。個人的には ClearType 側で GASP を無視してくれるのが一番なのですが MS はどうして分かってくれないのでしょうか。


## USAGE
### Preparing
This script makes a core dump on old fontforge. So please install new fontforge. Especially, fontforge in Ubuntu repository is 2012xxxx still.

- Install fontforge (2016xxxx or higher) with python extension.
   * If you use Mac, install fontforge via [homebrew](https://brew.sh).
   * If you use Linux or WSL, install fontforge via [linuxbrew](http://linuxbrew.sh). See [here](./howto-install-fontforge.md).
   * If you use Raspberry Pi 3, install fontforge from tarball. See [here](./howto-install-fontforge.md).

I confirm this script on EL Capitan, Sierra, High Sierra, WSL (Xenial), Raspberry Pi 3 (Jessie).

- Copy your font, eg msgothic.ttc, from Windows font directory to your working directory. Default working directory is ~/Downloads/fonts.


### Step 1 (on Mac or on Linux)
```
python removebitmap.py msgothic.ttc
```


### Step 2 (on Mac or on Linux and on Windows)
```
Move new fonts in ~/Downloads/fonts/new to Windows folder.
```


### Step 3 (on Windows)
```
Double click new font and click 'Install' button on Windows.
```


### Step 4 (on Windows)
```
exec regedit
    - HKLM\software\Microsoft\Windows NT\CurrentVersion\FontLink\SystemLink
    - HKLM\software\Microsoft\Windows NT\CurrentVersion\Fonts
```


### Step 5 (on Windows)
```
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

According to major BBS, ClearType Tuner has still a bug that fix a Gamma value everything.

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
