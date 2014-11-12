「絵解き帳」追加エフェクト集
===============

----
Mac 用紙芝居動画作成支援アプリ、「[絵解き帳] [1]」の追加エフェクト集です。

以下の場所にパッチをコピーした後、[絵解き帳] [1]を再起動すれば利用できるようになります。

パッチ名| 設置場所
--------------------|----------
Bump.qtz| ~/Library/Compositions/
Move.qtz| ~/Library/Compositions/
Move Image.qtz| ~/Library/Compositions/
Shake.qtz| ~/Library/Compositions/
Pixels To Units Coordinate.qtz| ~/Library/Graphics/Quartz Composer Patches
AnchoredSprite.plugin| ~/Library/Graphics/Quartz Composer Plug-ins
TimerSwitch.plugin|~/Library/Graphics/Quartz Composer Plug-ins

※ AnchoredSprite.plugin は、Move.qtz でのみ使用されているため、Move.qtz を使わない場合はコピーする必要がありません。

※ TimerSwitch.plugin は、Shake.qtz を除く他のパッチすべてに使われているため、必ずコピーして下さい。

[1]:	http://nikyo.b.sourceforge.jp/%E4%BD%95%E3%81%9E%E3%80%81%E7%B5%B5%E8%A7%A3%E3%81%8D%E5%B8%B3/ "絵解き帳" 

　
## Bump.qtz
何かにぶつかったり、ぶつけられたりした時などによくある横揺れや縦揺れを表現するエフェクトです。

### 指定可能なパラメータ
#### X
横揺れの揺れ幅をピクセル単位で指定します。
#### Y
縦揺れの揺れ幅をピクセル単位で指定します。
#### Duration
揺れが継続する時間をミリ秒で指定します。
#### Is Bumped
チェックすると、画像に向かって何かがぶつかってきたように揺れます。デフォルトでは画像の側が何かにぶつかった時の揺れ方をします。

　
## Draw String With FontLister.qtz
標準では、文字を横向きもしくは縦向きにしか表示できませんが、このエフェクトでは任意の角度で表示させることができます。その際、移動やフェードなどのエフェクトをかけることもできます。フォントの選択に、[Font Lister][2]を使用しているため、別途入手して下さい。

※ [Font Lister][2] を以下のフォルダに設置した後で、導入して下さい。

	~/Library/Graphics/Quartz Composer Plug-Ins/

[2]: "http://www.kei3.com/archives/140" "Font Lister"

### 指定可能なパラメータ
#### String
表示させる文字列を入力して下さい。
#### Font Name
フォントを指定します。
#### Font Size
フォントサイズをピクセル単位で指定します。
#### Color
文字色を指定します。
#### X Positoin (X 位置)
文字列の表示を開始する X 座標 (横向き) をピクセル単位で指定します。座標指定は「絵解き帳」本体と同じく、画面左下隅が (0, 0, 0) になります。
#### Y Positoin (Y 位置)
文字列の表示を開始する Y 座標 (縦向き) をピクセル単位で指定します。
#### Z Positoin (Z 位置)
文字列の表示を開始する Z 座標 (奥行き) をピクセル単位で指定します。マイナスの値を指定すると、置くに遠ざかり、プラスの値を指定すると、手前に近づきます。
#### X Rotation (X 回転)
X 軸を中心にした傾きを角度で指定します。
#### Y Rotation (Y 回転)
Y 軸を中心にした傾きを角度で指定します。
#### Z Rotation (Z 回転)
Z 軸を中心にした傾きを角度で指定します。
#### To X
文字列を移動させる場合に X 軸方向の移動距離をピクセル単位で指定します。
#### To Y
文字列を移動させる場合に Y 軸方向の移動距離をピクセル単位で指定します。
#### To Z
文字列を移動させる場合に Z 軸方向の移動距離をピクセル単位で指定します。
#### Start Time
文字列の移動を開始する時間をミリ秒単位で指定します。
#### End Time
文字列の移動を完了する時間をミリ秒単位で指定します。
#### Is X Spin
文字列を X 軸中心に回転移動させる場合に、次の To X Rotation の値が角度ではなく、回転数を表す場合に指定します。
#### To X Rotation
X 軸を中心に回転する角度、または回転数を指定します。
#### Is Y Spin
文字列を Y 軸中心に回転移動させる場合に、次の To X Rotation の値が角度ではなく、回転数を表す場合に指定します。
#### To Y Rotation
Y 軸を中心に回転する角度、または回転数を指定します。
#### Is Z Spin
文字列を Z 軸中心に回転移動させる場合に、次の To X Rotation の値が角度ではなく、回転数を表す場合に指定します。
#### To Z Rotation
Z 軸を中心に回転する角度、または回転数を指定します。
#### Spin Start
回転を開始する時間をミリ秒単位で指定します。
#### Spin End
回転を終了する時間をミリ秒単位で指定します。
#### Fade From
文字列をフェード表示する場合の初期値を指定します。100 % で完全に表示、0 % で完全に透明です。
#### Fade To
文字列をフェード表示する場合の終了値を指定します。100 % で完全に表示、0 % で完全に透明です。
#### Fade Start
フェード表示の開始時間をミリ秒単位で指定します。
#### Fade End
フェード表示の完了時間をミリ秒単位で指定します。
#### Zoom From
文字列を拡大／縮小表示する場合の初期値を指定します。100 % が規定のサイズになります。
#### Zoom To
文字列を拡大／縮小表示する場合の完了値を指定します。100 % が規定のサイズになります。
#### Zoom Start
文字列を拡大／縮小表示する場合の開始時間をミリ秒単位で指定します。
#### Zoom End
文字列を拡大／縮小表示する場合の完了時間をミリ秒単位で指定します。
#### Bounce
文字をジャンプさせる回数を指定します。
#### Height
文字をジャンプする高さを指定します。
#### Jump_Start
文字がジャンプを始める時間をミリ秒単位で指定します。0 を指定すると、シーンの表示と同時に移動を開始します。
#### Jump_End
文字がジャンプを終える時間をミリ秒単位で指定します。

※大変残念なことに、Quartz Composer の仕様上、文字に縁取りや影をつけることはできません。

　
## Draw String WithOut FontLister.qtz
Font Lister を使用しない以外は、Draw String With FontLister と同じ動作をします。フォント名の指定以外はパラメータも同じです。

　
## Explosion.qtz
デフォルトはあまりそれっぽく見えませんが :P、爆発っぽいエフェクトを画像の背景に表示します。パラメータを変えると、かなり面白い効果が出ることはわかっているのですが、その調整が難しいのもので。:D

Quartz Composer がインストールしてあれば、パッチを開いて、Explosion というマクロパッチの中にある、Particle System というパッチの Setting にある、Start Up Delay という値を大きくすれば、花火にすることもできます。Quartz Composer で、かなり本物らしい花火動画を作成している方もいらっしゃいます。このマクロパッチでは無理ですが。^^;

### 指定可能なパラメータ
#### X Position (X 位置)
表示開始位置の X 座標です。デフォルトで 0 が入力されていますが、移動を行わない場合は画面中央に勝手に表示されます。なお、座標は画面左下隅が原点になっていますので、値を変更する場合は注意して下さい。
#### Y Position (Y 位置)
表示開始位置の X 座標です。
#### Z Position (Z 位置)
表示開始位置の X 座標です。
#### Particle Count
飛び散る破片の個数を指定します。
#### Start Time
表示を開始する時間をミリ秒単位で指定します。
#### EndTime
表示を完了する時間をミリ秒単位で指定します。表示間隔を変更する場合は、下にある Lifetime も併せて変更して下さい。Lifetime より表示間隔を長くすると、爆発(?)が繰り返し表示されますが、Quartz Composer の仕様ですので、致し方ありません。
#### X Distance
表示を移動させる場合に X 軸方向への移動量をピクセル単位で指定します。
#### Y Distance
表示を移動させる場合に Y 軸方向への移動量をピクセル単位で指定します。
#### Z Distance
表示を移動させる場合に Z 軸方向への移動量をピクセル単位で指定します。
#### Move Start
移動を開始する時間をミリ秒単位で指定します。
#### Move End
移動を完了する時間をミリ秒単位で指定します。
#### X Min Velocity
破片が飛び散る際の X 軸方向への初速度の下限を指定します。どの破片がどんな初速度を持つかは、上限と下限の間で OS が決定します。
#### X Max Velocity
破片が飛び散る際の X 軸方向への初速度の上限を指定します。
#### Y Min Velocity
破片が飛び散る際の Y 軸方向への初速度の下限を指定します。
#### Y Max Velocity
破片が飛び散る際の Y 軸方向への初速度の上限を指定します。
#### Z Min Velocity
破片が飛び散る際の Z 軸方向への初速度の下限を指定します。
#### Z Max Velocity
破片が飛び散る際の Z 軸方向への初速度の上限を指定します。
#### Min Size
破片のサイズの下限を指定します。指定する値は、画面の横幅を 2 とした時の相対サイズです。
#### Max Size
破片のサイズの上限を指定します。指定する値は、画面の横幅を 2 とした時の相対サイズです。
#### Lifetime
発生した破片がどれくらいの間表示され続けるかを指定します。単位は秒です。
#### Attraction
発生した破片が中心へ引き戻される力の大きさを指定します。
#### Gravity
発生した破片が落下する際の重力定数を指定します。現実の重力定数は 9.8 くらいです。
#### Size Delta
破片が表示されている間に破片の大きさを徐々に変更する比率を指定します。正の値を指定すると大きくなっていき、負の値を指定すると小さくなっていきます。
#### Red Delta
破片が表示されている間に破片の色のうち、三原色の赤成分を徐々に増減する比率を指定します。正の値を指定すると赤が強くなり、負の値を指定すると、赤が弱くなります。
#### Green Delta
破片が表示されている間に破片の色のうち、三原色の緑成分を徐々に増減する比率を指定します。正の値を指定すると緑が強くなり、負の値を指定すると、緑が弱くなります。
#### Blue Delta
破片が表示されている間に破片の色のうち、三原色の青成分を徐々に増減する比率を指定します。正の値を指定すると青が強くなり、負の値を指定すると、青が弱くなります。
#### Opacity Delta
破片が表示されている間に破片の透明度を徐々に変更する比率を指定します。正の値を指定すると不透明になっていき、負の値を指定すると透明になっていきます。
#### Color
破片に色をつける場合はここで変更できます。

　
## Move.qtz

レイヤーを指定時間内に移動させます。移動量と移動を開始する時間、移動を完了させる時間を指定します。なお、併せてフェード、ズーム、回転、ジャンプを指定することで、フェードインしながら登場とか、ぴょんぴょん跳ねながら移動、くるくる周りながら退場といったことができるようになっています。

※「絵解き帳」の仕様上の制約から、回転やズームを行わせる場合に、回転やズームの起点となる画面内の座標を指定する必要があります。このアンカー座標を基準にして画像が回転します。実際には、アンカー座標を基準に画像を中央に描画し直して、そこで各種のエフェクトをかけた後、元の位置に画像を書き戻す、という処理を内部でしているので、GPU的には少しだけ重い処理になっています。

### 指定可能なパラメータ
#### Anchor X
処理の原点となる位置の X 座標をピクセル単位で指定します。画面左下隅が 0 で、上方向に値が増えていきます。
#### Anchor Y
処理の原点となる位置の Y 座標をピクセル単位で指定します。画面左下隅が 0 で、右方向に値が増えていきます。
#### Anchor Z
処理の原点となる位置の Y 座標をピクセル単位で指定します。通常は、0 です。
#### X Distance
画像を移動させる場合の X 軸方向（横向き）の移動量をピクセル単位で指定します。
#### Y Distance
画像を移動させる場合の Y 軸方向（縦向き）の移動量をピクセル単位で指定します。
#### Z Distance
画像を移動させる場合の Z 軸方向（奥行き）の移動量をピクセル単位で指定します。
#### Start Time
#### End Time
#### Bounce
画像をジャンプさせる回数を指定します。
#### Height
画像をジャンプする高さを指定します。
#### Jump_Start
画像がジャンプを始める時間をミリ秒単位で指定します。0 を指定すると、シーンの表示と同時に移動を開始します。
#### Jump_End
画像がジャンプを終える時間をミリ秒単位で指定します。
#### X Rotation (X 回転)
X 軸を中心にした傾きを角度で指定します。
#### Is X Spin
文字列を X 軸中心に回転移動させる場合に、次の To X Rotation の値が角度ではなく、回転数を表す場合に指定します。
#### To X Rotation
X 軸を中心に回転する角度、または回転数を指定します。
#### Y Rotation (Y 回転)
Y 軸を中心にした傾きを角度で指定します。
#### Is Y Spin
画像を Y 軸中心に回転移動させる場合に、次の To X Rotation の値が角度ではなく、回転数を表す場合に指定します。
#### To Y Rotation
Y 軸を中心に回転する角度、または回転数を指定します。
#### Z Rotation (Z 回転)
Z 軸を中心にした傾きを角度で指定します。
#### Is Z Spin
画像を Z 軸中心に回転移動させる場合に、次の To X Rotation の値が角度ではなく、回転数を表す場合に指定します。
#### To Z Rotation
Z 軸を中心に回転する角度、または回転数を指定します。
#### Spin Start
回転を開始する時間をミリ秒単位で指定します。
#### Spin End
回転を終了する時間をミリ秒単位で指定します。
#### Fade From
画像をフェード表示する場合の初期値を指定します。100 % で完全に表示、0 % で完全に透明です。
#### Fade To
画像をフェード表示する場合の終了値を指定します。100 % で完全に表示、0 % で完全に透明です。
#### Fade Start
フェード表示の開始時間をミリ秒単位で指定します。
#### Fade End
フェード表示の完了時間をミリ秒単位で指定します。
#### Zoom From
画像を拡大／縮小表示する場合の初期値を指定します。100 % が規定のサイズになります。
#### Zoom To
画像を拡大／縮小表示する場合の完了値を指定します。100 % が規定のサイズになります。
#### Zoom Start
画像を拡大／縮小表示する場合の開始時間をミリ秒単位で指定します。
#### Zoom End
画像を拡大／縮小表示する場合の完了時間をミリ秒単位で指定します。
#### From Color
画像に色をかぶせて表示する場合の初期色を指定します。元の画像のまま表示するには、白を指定します。
#### To Color
画像に色をかぶせて表示する場合の完了色を指定します。元の画像のまま表示するには、白を指定します。
#### Color Start
画像に色をかぶせて表示する場合の開始時間をミリ秒単位で指定します。
#### Color End
画像に色をかぶせて表示する場合の完了時間をミリ秒単位で指定します。

　
## Move Image.qtz

レイヤーを指定時間内に移動させます。移動量と移動を開始する時間、移動を完了させる時間を指定します。なお、併せてフェード、ズーム、ジャンプを指定することで、フェードインしながら登場とか、ぴょんぴょん跳ねながら移動、くるくる周りながら退場といったことができるようになっています。

後述の「Move.qtz」との違いは、描画回数が少ない（＝多少は動作が軽い）、回転ができない、ズームの基準座標がスクリーン中央に固定されている、といった点です。

### 指定可能なパラメータ

#### X
左右に移動する量をピクセル単位で指定します。現在画像が置かれている位置が原点で、そこからの相対移動量を指定することに注意して下さい。プラスの値を指定すれば右、マイナスの値を指定すれば左に移動します。
#### Y
上下に移動する量をピクセル単位で指定します。現在画像が置かれている位置が原点で、そこからの相対移動量を指定することに注意して下さい。プラスの値を指定すれば上、マイナスの値を指定すれば下に移動します。
#### From_Z
奥もしくは手前から移動する場合の移動開始位置をピクセル単位で指定します。デフォルト位置は、0 です。
#### To_Z
奥もしくは手前に移動する場合の移動完了位置をピクセル単位で指定します。

#### Start_Time
移動を開始する時間をミリ秒単位で指定して下さい。0 を指定すると、シーンの表示と同時に移動を開始します。
#### End_Time
移動を完了する時間をミリ秒単位で指定して下さい。

#### Fade_From
フェード処理を開始する際の透過率をパーセント(%)で指定して下さい。100%で不透明、0%で透明になります。
#### Fade_To
フェード処理を完了する際の透過率をパーセント(%)で指定して下さい。
#### Fade_Start
フェード処理を開始する時間をミリ秒単位で指定して下さい。0 を指定すると、シーンの表示と同時に移動を開始します。
#### Fade_End
フェード処理を完了する時間をミリ秒単位で指定して下さい。0 を指定すると、シーンの表示と同時に移動を開始します。
#### Zoom_From
画像を拡大または縮小表示する最初の比率を元画像に対するパーセント(%)で指定して下さい。100%で元画像と同じ大きさを指定したことになります。
#### Zoom_To
画像の拡大または縮小を完了する時の比率を元画像に対するパーセント(%)で指定して下さい。100%で元画像と同じ大きさを指定したことになります。
#### Zoom_Start
画像の拡大／縮小表示を開始する時間をミリ秒単位で指定して下さい。0 を指定すると、シーンの表示と同時に移動を開始します。
#### Zoom_End
画像の拡大／縮小表示を完了する時間をミリ秒単位で指定して下さい。
#### Bounce
画像がジャンプさせる回数を指定します。
#### Height
画像がジャンプする高さを指定します。
#### Jump_Start
画像がジャンプを始める時間をミリ秒単位で指定します。0 を指定すると、シーンの表示と同時に移動を開始します。
#### Jump_End
画像がジャンプを終える時間をミリ秒単位で指定します。

※なお、絵解き帳の仕様が原因で、元画像が画面から見切れる位置にあ13ると、見切れた表示のまま移動してしまいます。使用する際はご注意下さい。

　
## Shake.qtz
簡易エフェクト集に含まれる、地震.qtz と同じ事をしますが、縦揺れ、横揺れが選択できるのと、開始時間、終了時間を指定することができます。

### 指定可能なパラメータ

#### Scale
揺れ幅を指定します。値が大きいほど極端な揺れ方になります。
#### Start_Time
揺れ始める時間をミリ秒単位で指定します。0 を指定すると、シーンの表示と同時に移動を開始します。
#### End_Time
静止する時間をミリ秒単位で指定します。
#### Is_Virtical
チェックすると縦に揺れます。
#### Is_Horizontal
チェックすると横に揺れます。

　
## 著作権について

	このリポジトリに含まれるモジュール、ソースコード、バイナリには、すべて University of California Berkeley が作成した最新版の BSD License が適用されます。ご利用はご自由に。

--
2014/11/13 初版

