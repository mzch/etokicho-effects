## Blaze.qtz
デフォルトではとてもそう見えませんが、背景に光の柱や火柱の**ようなもの**を表示するエフェクトです。部品画像やパラメータを色々といじってると思いも寄らない効果が得られますので、あれこれ試してみて下さい。

### 指定可能なパラメータ
#### X Position (X 位置)
表示開始位置の X 座標です。デフォルトでは画面中央に表示されますが、 値を変更する場合、画面左下隅が原点座標になりますので注意して下さい。
#### Y Position (Y 位置)
表示開始位置の Y 座標です。デフォルトの値より上にすると、ネタがわかったりします。:)
#### Z Position (Z 位置)
表示開始位置の Z 座標です。
#### Particle Count
炎を構成する部品画像の生成個数を指定します。デフォルトより少なくすると火柱っぽくなくなります。
#### Start Time
表示を開始する時間をミリ秒単位で指定します。
#### EndTime
表示を完了する時間をミリ秒単位で指定します。
#### Color
部品画像に特定の色をつける場合はここで変更できます。
#### X Min Velocity
炎を構成する部品画像が指定座標から飛び散る際の X 軸方向への初速度の下限を指定します。
#### X Max Velocity
炎を構成する部品画像が指定座標から飛び散る際の X 軸方向への初速度の上限を指定します。
#### Y Min Velocity
炎を構成する部品画像が指定座標から飛び散る際の Y 軸方向への初速度の下限を指定します。
#### Y Max Velocity
炎を構成する部品画像が指定座標から飛び散る際の Y 軸方向への初速度の上限を指定します。
#### Z Min Velocity
炎を構成する部品画像が指定座標から飛び散る際の Z 軸方向への初速度の下限を指定します。
#### Z Max Velocity
炎を構成する部品画像が指定座標から飛び散る際の Z 軸方向への初速度の上限を指定します。
#### Min Size
炎を構成する部品画像のサイズの下限を指定します。指定する値は、画面の横幅を 2 とした時の相対サイズです。
#### Max Size
炎を構成する部品画像が指定座標のサイズの上限を指定します。指定する値は、画面の横幅を 2 とした時の相対サイズです。
#### Lifetime
炎を構成する部品画像ひとつひとつがどれくらいの間表示され続けるかを指定します。単位は秒です。
#### Attraction
炎を構成する部品画像が発生座標へ引き戻される力の大きさを指定します。
#### Gravity
炎を構成する部品画像が落下する際の重力定数を指定します。デフォルトでマイナスになっているのは、表示された画像が上に向かって「落ちる」ようにするためです。
#### Size Delta
炎を構成する部品画像が表示されている間に大きさを徐々に変更する比率を指定します。正の値を指定すると大きくなっていき、負の値を指定すると小さくなっていきます。
#### Red Delta
炎を構成する部品画像が表示されている間に、三原色の赤成分を徐々に増減する比率を指定します。正の値を指定すると赤が強くなり、負の値を指定すると、赤が弱くなります。
#### Green Delta
炎を構成する部品画像が表示されている間に、三原色の緑成分を徐々に増減する比率を指定します。正の値を指定すると緑が強くなり、負の値を指定すると、緑が弱くなります。
#### Blue Delta
炎を構成する部品画像が表示されている間に、三原色の青成分を徐々に増減する比率を指定します。正の値を指定すると青が強くなり、負の値を指定すると、青が弱くなります。
#### Opacity Delta
炎を構成する部品画像が表示されている間に透明度を徐々に変更する比率を指定します。正の値を指定すると不透明になっていき、負の値を指定すると透明になっていきます。

　
## Blink.qtz
画像をちかちかと点滅させるように表示します。

### 指定可能なパラメータ
#### Blink
点滅させる回数を指定します。
#### Start Time
点滅表示を開始する時間をミリ秒単位で指定します。
#### End Time
点滅表示を終了する時間をミリ秒単位で指定します。

　
## Bounce.qtz
画像をぴょんぴょん跳ねさせたり、左右につんつん突くような動きをさせます。

### 指定可能なパラメータ
#### Anchor X
処理の原点となる横方向の位置をピクセル単位で指定します。画面左下隅が 0 で、右方向に値が増えていきます。
#### Anchor Y
処理の原点となる縦方向の位置をピクセル単位で指定します。画面左下隅が 0 で、上方向に値が増えていきます。
#### Bounce
画像を跳ねさせる回数を指定します。
#### X Distance
X 軸方向（横向き）の移動量をピクセル単位で指定します。
#### Y Distance
Y 軸方向（縦向き）の移動量をピクセル単位で指定します。
#### Z Distance
Z 軸方向（奥行き）の移動量をピクセル単位で指定します。
#### Jum Style
「ぴょんぴょん」跳ねるようにジャンプするか、「カクカク」した動きにするか、「タメ」を作ってからジャンプするか、ジャンプしてからタメを作るか、いずれかを指定します。
#### Jump Start
画像が動作を始める時間をミリ秒単位で指定します。0 を指定すると、シーンの表示と同時に移動を開始します。
#### Jump End
画像が動作を終える時間をミリ秒単位で指定します。

　
## Bump.qtz
何かにぶつかったり、ぶつけられたりした時などによくある横揺れや縦揺れを表現するエフェクトです。

### 指定可能なパラメータ
#### X
横揺れの揺れ幅をピクセル単位で指定します。正の値を指定すると右に、負の値を指定すると左に揺れます。
#### Y
縦揺れの揺れ幅をピクセル単位で指定します。正の値を指定すると上に、負の値を指定すると下に揺れます。
#### Z
前後の揺れ幅をピクセル単位で指定します。正の値を指定すると前に、負の値を指定すると奥に揺れます。
#### Duration
揺れが継続する時間をミリ秒で指定します。
#### Is Bumped
チェックすると、画像に向かって何かがぶつかってきたように揺れます。デフォルトでは画像の側が何かにぶつかった時の揺れ方をします。

　
## Burst.qtz
なぜか標準の Quartz Composer には含まれていない、画像を破裂させるエフェクトです。パラメータを調整することで、単に破裂させるだけでなく、砂のように崩れたり、風に流されたりといったこともできます。

### 指定可能なパラメータ
#### Anchor X
破裂の起点となる位置の X 座標をピクセル単位で指定して下さい。原点は左下隅です。
#### Anchor Y
破裂の起点となる位置の Y 座標をピクセル単位で指定して下さい。原点は左下隅です。
#### X Position (X 位置)
破裂させる画像の左下隅の X 座標をピクセル単位で指定して下さい。（絵解き帳の「レイヤー情報→座標」の値をそのまま指定すると、指定画像全体が破裂します）
#### Y Position (X 位置)
破裂させる画像の左下隅の Y 座標をピクセル単位で指定して下さい。（絵解き帳の「レイヤー情報→座標」の値をそのまま指定すると、指定画像全体が破裂します）
#### Width
破裂させる画像の横幅をピクセル単位で指定して下さい。（絵解き帳の「レイヤー情報→座標」の値をそのまま指定すると、指定画像全体が破裂します）
#### Height
破裂させる画像の高さをピクセル単位で指定して下さい。（絵解き帳の「レイヤー情報→座標」の値をそのまま指定すると、指定画像全体が破裂します）
#### Horizontal Divisor
横方向にいくつの破片で破裂させるかを指定します。
#### Vertical Divisor
縦方向にいくつの破片で破裂させるかを指定します。
#### Color
破裂する際の画像の色を指定します。デフォルトは白です。
#### X Min Velocity
破裂時の X 軸方向の初速の最小値を指定します。マイナスの値は、左向き、プラスの値は右向きを表します。実際の破片の速度はこの値と次の最大値の間の値を乱数で決定します。
#### X Max Velocity
破裂時の X 軸方向の初速の最大値を指定します。
#### Y Min Velocity
破裂時の Y 軸方向の初速の最小値を指定します。マイナスの値は、下向き、プラスの値は上向きを表します。実際の破片の速度はこの値と次の最大値の間の値を乱数で決定します。
#### Y Max Velocity
破裂時の Y 軸方向の初速の最大値を指定します。
#### Z Min Velocity
破裂時の Z 軸方向の初速の最小値を指定します。マイナスの値は、奥向き、プラスの値は手前向きを表します。実際の破片の速度はこの値と次の最大値の間の値を乱数で決定します。
#### Z Max Velocity
破裂時の Z 軸方向の初速の最大値を指定します。
#### Attraction
破片を元の位置に引き戻そうとする力の値です。
#### Gravity
重力を表します。デフォルトは０ですが、地上の重力加速度は 9.8 です。
#### Start Time
破裂開始の時間をミリ秒単位で指定します。
#### End Time
破裂終了の時間をミリ秒単位で指定します。

　
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

　
## Fade.qtz
画像をフェードイン、フェードアウト表示します。

### 指定可能なパラメータ
#### Color #1
色の初期値を指定します。透過度も設定できます。
#### Color #2
```Color #1``` から変化する色を指定します。透過度も設定できます。
#### Color #3
```Color #2``` から変化する色を指定します。透過度も設定できます。
#### Fade In Start
最初のフェード表示を開始する時間をミリ秒単位で指定します。
#### Fade In Time
最初のフェード表示を終了する時間をミリ秒単位で指定します。
#### Fade In Opt
```Color #1```から```Color #2```までの色の変化を直線的に行うか、指数関数的に変化させるか、対数関数的に変化させるかを指定します。
#### Fade Out Start
二回目のフェードを開始する時間をミリ秒単位で指定します。
#### Fade Out Time
二回目のフェードを終了する時間をミリ秒単位で指定します。
#### Fade Out Opt
```Color #2```から```Color #3```までの色の変化を直線的に行うか、指数関数的に変化させるか、対数関数的に変化させるかを指定します。

　
## Foggy.qtz
正確には Blur なのですが、カメラのピントが合う、外れる効果です。
#### Start Radius
開始時のピントのぼけ具合を指定します。0 で焦点が合っている状態です。
#### End Radius
終了時のピントのぼけ具合を指定します。
#### Start Time
ピントが合う、ずれる動作の開始時間をミリ秒単位で指定します。
#### End Time
ピントが合う、ずれる動作の終了時間をミリ秒単位で指定します。

　
## Gleam.qtz
目がきらーんと光る時のあの光のエフェクトです。
### 指定可能なパラメータ
#### Color
光の色を指定します。
#### X Position (X 位置)
光を表示する左右方向の座標をピクセル単位で指定します。画面左下隅が原点です。
#### Y Position (Y 位置)
光を表示する上下方向の座標をピクセル単位で指定します。画面左下隅が原点です。
#### Z Position (Z 位置)
光を表示する前後の座標をピクセル単位で指定します。デフォルトは 0 で、負の値を指定すると画面に表示されません。
#### Start Time
光を表示する開始時間をミリ秒単位で指定します。
#### End Time
光の表示を終わらせる時間をミリ秒単位で指定します。
#### Duration
下記の値に従って、光は大きさを変えますが、その周期をミリ秒単位で指定します。
#### Min Radius
光源の強さ＝大きさの初期値を 0 〜 300 までの値で指定します。
#### Max Radius
光源の強さ＝大きさの最大値を 0 〜 300 までの値で指定します。最大値と言ってますが、Min Radius より小さな値を指定することもできます。その場合、最初大きく表示されて徐々に小さくなり、また大きくなるという動きをします。
#### Min Scale
十字の光の長さの初期値を 0 〜 100 までの値で指定します。
#### Max Scale
十字の光の長さの最大値を 0 〜 100 までの値で指定します。もちろん、Min Scale より小さい値を指定することもできます。
#### Min Angle
十字の光の傾きの初期値を角度で指定します。範囲は、0°〜180°です。
#### Max Angle
十字の光の傾きの最大値を角度で指定します。範囲は、0°〜180°です。
#### Min Opacity
十字の光の透明度の初期値を -8 〜 0 までの値で指定します。
#### Max Opacity
十字の光の透明度の最大値を -8 〜 0 までの値で指定します。Min Opacity より小さい値を指定することもできます。
#### Min Width
十字の光の幅の初期値を 0.5 〜 10 までの値で指定します。
#### Max Width
十字の光の幅の最大値を 0.5 〜 10 までの値で指定します。Min Width より小さい値を指定することもできます。
#### Min Epsilon
十字の光の減衰幅の初期値を -8 〜 0 までの値で指定します。
#### Max Epsilon
十字の光の減衰幅の最大値を -8 〜 0 までの値で指定します。
#### X Distance
光を移動させる場合の横方向への移動量をピクセル単位で指定します。正の値で右に、負の値で左に移動します。
#### Y Distance
光を移動させる場合の縦方向への移動量をピクセル単位で指定します。正の値で上に、負の値で下に移動します。
#### Z Distance
光を移動させる場合の前後方向への移動量をピクセル単位で指定します。正の値で手前に、負の値で奥に移動します。
#### Move Start
移動を開始する時間をミリ秒単位で指定します。
#### Move End
移動を完了する時間をミリ秒単位で指定します。

　
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

　
## Move Image.qtz
後方互換性のために残してあります。新規には、```Slide.qtz```をお使い下さい。

　
## Move.qtz
後方互換性のために残してあります。新規には、```Slide.qtz```をお使い下さい。

　
## Page Curl.qtz
ページめくりエフェクトです。何か違う……のですが、Quartz Composer の仕様なのか何をどういじっても改善しないし、何秒も表示されるものではないので、これでよしとしました。誰か改善して下さい。:P

### 指定可能なパラメータ

#### Ext Origin X
ページめくりを開始する点の X 座標を指定します。0 以外の値にすると、ページめくりに見えなくなるのは多分仕様なんだと思われます。
#### Ext Origin Y
ページめくりを開始する点の Y 座標を指定します。
#### Ext Width
めくりあげる幅を指定します。
#### Ext Height
めくりあげる高さを指定します。
#### Angle
めくりあげる角度を指定します。
#### Radius
実際に本の頁を端から持ち上げてめくってみるとわかりますが、カールした紙は円柱に沿って持ち上げられているかのように動きます。ここは、カールの大きさをその円柱状の空間の半径で指定するイメージです。
#### Duration
一応、突然画面が切り替わった印象を避けるために、カールしたページに透明化処理を行っているのですが、完全には透明になりません……それはともかく、カールしたページが透明になるまでの時間をミリ秒単位で指定します。デフォルトは、２秒です。
#### Is Target Dup
チェックすると、遷移後の画面をあらかじめ表示します。具体的にどう変わるかは試してみて下さい。
#### Is Source Back
チェックすると、遷移前の画面がカールした時に表示される裏側に、遷移前の画像を貼りつけます。このチェックを外すと、下の「Backside Image」で指定した画像を貼りつけます。
#### Backside Image
ページの裏側に表示される画像を Drag & Drop して下さい。
#### Shading Image
シェーディングなのですから、シャドウのような効果かなと思いましたが……ちょっとよくわかんないです。試した画像がよくなかったのかな。

　
## Particle System.qtz
Quick Composer の Particle System パッチそのものです。泉のように噴き出す亜美真美とか、四方八方に飛び去る愛ちゃんとか、工夫次第で色んなことが！ｗ

　
## Scrollqtz
画像をスクロールします。スクロールアウトした部分は逆方向から再表示されますので、連続して違和感のない画像を指定するようにして下さい。

### 指定可能なパラメータ

#### Direction
スクロール方向です。上下左右の四方向のいずれかを指定します。
#### Speed
スクロールスピードです。
#### Start Time
スクロールを開始する時間をミリ秒単位で指定します。
#### End Time
スクロールを停止する時間をミリ秒単位で指定します。

　
## Shake.qtz
簡易エフェクト集に含まれる、地震.qtz と同じ事をしますが、縦揺れ、横揺れが選択できるのと、開始時間、終了時間を指定することができます。

### 指定可能なパラメータ

#### Scale
揺れ幅を指定します。値が大きいほど極端な揺れ方になります。
#### Start Time
揺れ始める時間をミリ秒単位で指定します。0 を指定すると、シーンの表示と同時に移動を開始します。
#### End Time
静止する時間をミリ秒単位で指定します。
#### Is Virtical
チェックすると縦に揺れます。
#### Is Horizontal
チェックすると横に揺れます。

　
## Slide.qtz
レイヤーを指定時間内に移動させます。移動開始位置と終了位置、移動開始時間、移動終了時間を指定します。なお、併せてフェード、ズーム、回転、ジャンプを指定することで、フェードインしながら登場とか、ぴょんぴょん跳ねながら移動、くるくる周りながら退場といったことができるようになっています。
　
### 指定可能なパラメータ
#### Anchor X
処理の原点となる横方向の位置をピクセル単位で指定します。画面左下隅が 0 で、右方向に値が増えていきます。
#### Anchor Y
処理の原点となる縦方向の位置をピクセル単位で指定します。画面左下隅が 0 で、上方向に値が増えていきます。
#### X Start Pos
画像の移動開始位置の X 座標（横方向）をピクセル単位で指定します。画面左下隅が原点で、右方向に値が大きくなります。
#### X End Pos
画像の移動終了位置の X 座標（横方向）をピクセル単位で指定します。
#### X Option
横方向の移動を「等速」で行うか「加速」しつつ移動するか、「減速」しつつ移動するかを指定します。
#### Y Start Pos
画像の移動開始位置の Y 座標（縦方向）をピクセル単位で指定します。画面左下隅が原点で、上方向に値が大きくなります。
#### Y End Pos
画像の移動終了位置の Y 座標（縦方向）をピクセル単位で指定します。
#### Y Option
縦方向の移動を「等速」で行うか「加速」しつつ移動するか、「減速」しつつ移動するかを指定します。
#### Z Start Pos
画像の移動開始位置の Z 座標（奥行き）をピクセル単位で指定します。現在位置が原点で、正の値を指定すると手前に、負の値を指定すると奥へ移動します。
#### Z End Pos
画像の移動終了位置の Y 座標（奥行き）をピクセル単位で指定します。
#### Z Option
奥行き方向の移動を「等速」で行うか「加速」しつつ移動するか、「減速」しつつ移動するかを指定します。
#### Start Time
画像の移動を開始する時間をミリ秒単位で指定します。
#### End Time
画像の移動を完了する時間をミリ秒単位で指定します。
#### Color #1
フェードインの際の表示開始色を指定します。完全不透明の白を指定すると元画像の色のままです。透明度を指定することで、フェードインが可能です。
#### Color #2
フェードインの表示終了時、かつフェードアウト表示開始時の色を指定します。フェードインが終わってからフェードアウトが始まるまではこの色が画像に被さります。
#### Color #3
フェードアウトの際の表示終了色を指定します。
#### Fade In Start
```Color #1``` から ```Color #2``` への色変化の開始時間をミリ秒単位で指定します。
#### Fade In End
```Color #1``` から ```Color #2``` への色変化の完了時間をミリ秒単位で指定します。
#### Fade In Opt
上記の色の遷移が「一定」か、「指数関数的」に変化するか、「対数関数的」に変化するかを指定します。
#### Fade Out Start
```Color #2``` から ```Color #3``` への色変化の開始時間をミリ秒単位で指定します。
#### Fade Out End
```Color #2``` から ```Color #3``` への色変化の完了時間をミリ秒単位で指定します。
#### Fade Out Opt
上記の色の遷移が「一定」か、「指数関数的」に変化するか、「対数関数的」に変化するかを指定します。
#### X Scale From
画像を X 軸方向に拡大／縮小表示する場合の初期値を指定します。100 % が規定のサイズになります。
#### X Scale To
画像を X 軸方向に拡大／縮小表示する場合の終了値を指定します。100 % が規定のサイズになります。
#### Y Scale From
画像を Y 軸方向に拡大／縮小表示する場合の初期値を指定します。100 % が規定のサイズになります。
#### Y Scale To
画像を Y 軸方向に拡大／縮小表示する場合の終了値を指定します。100 % が規定のサイズになります。
#### Z Scale From
画像を Z 軸方向に拡大／縮小表示する場合の初期値を指定します。100 % が規定のサイズになります。
#### Z Scale To
画像を Z 軸方向に拡大／縮小表示する場合の終了値を指定します。100 % が規定のサイズになります。
#### Scale Start
画像を拡大／縮小表示する場合の開始時間をミリ秒単位で指定します。
#### Scale End
画像を拡大／縮小表示する場合の完了時間をミリ秒単位で指定します。
#### Bounce
画像をジャンプさせる回数を指定します。
#### Jump Style
画像をジャンプさせる場合のジャンプパターンを指定します。跳ねるような動きがディフォルトです。
#### X Lead
X 軸方向にジャンプさせる場合の幅を指定します。正の値で右に、負の値で左に動きます。
#### Y Lead
Y 軸方向にジャンプさせる場合の幅を指定します。正の値で上に、負の値で下に動きます。
#### Z Lead
Z 軸方向にジャンプさせる場合の幅を指定します。正の値で手前に、負の値で奥に動きます。
#### Jump Start
画像がジャンプを始める時間をミリ秒単位で指定します。0 を指定すると、シーンの表示と同時に移動を開始します。
#### Jump End
画像がジャンプを終える時間をミリ秒単位で指定します。
#### Jum Style
「ぴょんぴょん」跳ねるようにジャンプするか、「カクカク」した動きにするか、「タメ」を作ってからジャンプするか、ジャンプしてからタメを作るか、いずれかを指定します。
#### X Axis (X 軸)
画像を回転させる際に基準座標となる縦方向の軸 (X軸) の傾きを -180° 〜 180° の範囲で指定します。デフォルトは、0 です。
#### Y Axis (Y 軸)
画像を回転させる際に基準座標となる横方向の軸 (Y軸) の傾きを -180° 〜 180° の範囲で指定します。デフォルトは、0 です。
#### Z Axis (Z 軸)
画像を回転させる際に基準座標となる奥行き方向の軸 (Z軸) の傾きを -180° 〜 180° の範囲で指定します。デフォルトは、0 です。
#### X Degree
X 軸を中心にした傾きを角度で指定します。
#### Is X Spin
チェックすると、次の X End Degree の値が角度ではなく、回転数であることを示します。
#### X End Degree
X 軸中心の回転が終了する角度、または回転数を指定します。
#### Y Degree
Y 軸を中心にした傾きを角度で指定します。
#### Is Y Spin
チェックすると、次の Y End Degree の値が角度ではなく、回転数であることを示します。
#### Y End Degree
Y 軸中心の回転が終了する角度、または回転数を指定します。
#### Z Degree
Z 軸を中心にした傾きを角度で指定します。
#### Is Z Spin
チェックすると、次の Z End Degree の値が角度ではなく、回転数であることを示します。
#### Z End Degree
Z 軸中心の回転が終了する角度、または回転数を指定します。
#### Spin Start
回転を開始する時間をミリ秒単位で指定します。
#### Spin End
回転を終了する時間をミリ秒単位で指定します。

　
## Spin.qtz
レイヤーを指定時間内で回転させます。```Slide.qtz```とは、回転速度と加速度を指定する点が異なります。

### 指定可能なパラメータ
#### Anchor X
処理の原点となる横方向の位置をピクセル単位で指定します。画面左下隅が 0 で、右方向に値が増えていきます。
#### Anchor Y
処理の原点となる縦方向の位置をピクセル単位で指定します。画面左下隅が 0 で、上方向に値が増えていきます。
#### X Axis (X 軸)
画像を回転させる際に基準座標となる縦方向の軸 (X軸) の傾きを -180° 〜 180° の範囲で指定します。デフォルトは、0 です。
#### Y Axis (Y 軸)
画像を回転させる際に基準座標となる横方向の軸 (Y軸) の傾きを -180° 〜 180° の範囲で指定します。デフォルトは、0 です。
#### Z Axis (Z 軸)
画像を回転させる際に基準座標となる奥行き方向の軸 (Z軸) の傾きを -180° 〜 180° の範囲で指定します。デフォルトは、0 です。
#### Speed X
X 軸方向に回転させる場合の速度を -3600 〜 3600 の範囲で指定します。正の値を指定すると時計回り。負の値を指定すると、反時計回りに回転します。
#### Accel X
X 軸中心の回転の加速度を -360 〜 360 の範囲で指定します。正の値を指定すると加速、負の値を指定すると減速となりますが、回転速度を加速度の累積が上回った場合、逆回転を始めます。
#### Speed Y
Y 軸中心に回転させる場合の速度を -3600 〜 3600 の範囲で指定します。正の値を指定すると時計回り。負の値を指定すると、反時計回りに回転します。
#### Accel Y
Y 軸中心の回転の加速度を -360 〜 360 の範囲で指定します。正の値を指定すると加速、負の値を指定すると減速となりますが、回転速度を加速度の累積が上回った場合、逆回転を始めます。
#### Speed Y
Z 軸中心に回転させる場合の速度を -3600 〜 3600 の範囲で指定します。正の値を指定すると時計回り。負の値を指定すると、反時計回りに回転します。
#### Accel Y
Z 軸中心の回転の加速度を -360 〜 360 の範囲で指定します。正の値を指定すると加速、負の値を指定すると減速となりますが、回転速度を加速度の累積が上回った場合、逆回転を始めます。
#### Start Time
回転を開始する時間をミリ秒単位で指定します。
#### End Time
回転を停止する時間をミリ秒単位で指定します。 

　
## Spot Light.qtz
画像をスポットライトで照らします。
#### Light Position (X)
ライトの横方向の位置をピクセル単位で指定します。画面左下隅が原点 (0,0) です。
#### Light Position (Y)
ライトの縦方向の位置をピクセル単位で指定します。画面左下隅が原点 (0,0) です。
#### Light Position (Z)
ライトの奥行き方向の位置をピクセル単位で指定します。正の値を指定すると手前に、負の値を指定すると画像の奥にライトを置くことになります。
#### Light Points At (X)
ライトが照らす横方向の位置をピクセル単位で指定します。画面左下隅が原点 (0,0) です。
#### Light Points At (Y)
ライトが照らす縦方向の位置をピクセル単位で指定します。画面左下隅が原点 (0,0) です。
#### Light Points At (Z)
ライトが照らす奥行き方向の位置をピクセル単位で指定します。正の位置を指定すると画面の手前を照らし、負の値を指定すると、画面の奥を照らします。
#### Brightness
ライトの明るさを指定します。
#### Concentration
光の広がりを指定します。値が小さいほど絞った光になります。
#### Color
ライトの色を指定します。
#### Blink
ライトが瞬く回数を指定します。0 を指定すると最初から点灯しっぱなしです。
#### Duration
ライトが瞬く時間をミリ秒単位で指定します。
#### Start Time
ライトの点灯を開始する時間を指定します。
#### X Distance
画像を移動させる場合の横方向の移動距離をピクセル単位で指定します。正の値を指定すると右に、負の値を指定すると左に移動します。
#### Y Distance
画像を移動させる場合の縦方向の移動距離をピクセル単位で指定します。正の値を指定すると上に、負の値を指定すると下に移動します。
#### Z Distance
画像を移動させる場合の奥行き方向の移動距離をピクセル単位で指定します。正の値を指定すると手前に、負の値を指定すると奥に移動します。
#### Move Start
移動を開始する時間をミリ秒単位で指定します。
#### Move End
移動を完了する時間をミリ秒単位で指定します。

　
## Ultra Q.qtz
往年の名特撮番組、ウルトラＱのオープニングタイトルっぽい雰囲気を再現するエフェクトです。
#### X 1st
#### Y 1st
左側の渦巻きの中心位置をピクセル単位で指定します。
#### X 2nd
#### Y 2nd
右側の渦巻きの中心位置をピクセル単位で指定します。
#### Start Angle
#### End Angle
渦巻き具合を角度で指定します。
#### Radius
渦巻きの大きさを指定します。
#### Start Time
#### End Time
渦巻きが逆巻きで戻っていく時間をミリ秒単位で指定します。

　
## Walk.qtz
画像を歩かせたり、走らせたりするエフェクトです。余りにもパラメータが多くなりすぎるので、基本的に正面画像だけを考慮した作りになっています。横向きの画像に適用すると歩いているようには見えません。
　
### 指定可能なパラメータ
#### Anchor X
処理の原点となる横方向の位置をピクセル単位で指定します。画面左下隅が 0 で、右方向に値が増えていきます。
#### Anchor Y
処理の原点となる縦方向の位置をピクセル単位で指定します。画面左下隅が 0 で、上方向に値が増えていきます。
#### X Start Pos
画像の移動開始位置の X 座標（横方向）をピクセル単位で指定します。画面左下隅が原点で、右方向に値が大きくなります。
#### X End Pos
画像の移動終了位置の X 座標（横方向）をピクセル単位で指定します。
#### X Option
横方向の移動を「等速」で行うか「加速」しつつ移動するか、「減速」しつつ移動するかを指定します。
#### Y Start Pos
画像の移動開始位置の Y 座標（縦方向）をピクセル単位で指定します。画面左下隅が原点で、上方向に値が大きくなります。
#### Y End Pos
画像の移動終了位置の Y 座標（縦方向）をピクセル単位で指定します。
#### Y Option
縦方向の移動を「等速」で行うか「加速」しつつ移動するか、「減速」しつつ移動するかを指定します。
#### Z Start Pos
画像の移動開始位置の Z 座標（奥行き）をピクセル単位で指定します。現在位置が原点で、正の値を指定すると手前に、負の値を指定すると奥へ移動します。
#### Z End Pos
画像の移動終了位置の Y 座標（奥行き）をピクセル単位で指定します。
#### Z Option
奥行き方向の移動を「等速」で行うか「加速」しつつ移動するか、「減速」しつつ移動するかを指定します。
#### Swing
画像が歩く（もしくは走る）たびに身体を傾ける角度を指定します。```Swing Option```で「走って」「スキップ」を指定すると無視されます。
#### Swing Roll
画像が歩く（もしくは走る）たびに身体を揺らす横揺れの幅をピクセル単位で指定します。
#### Swing Pitch
画像が歩く（もしくは走る）たびに身体を揺らす縦揺れの幅をピクセル単位で指定します。
#### Swing Duration
一歩にかかる時間をミリ秒単位で指定します。
#### Swing Option
歩き方（もしくは走り方）を指定します。「歩いて」は普通に身体を揺らしながら歩いているエフェクトになります。「ぴょんぴょん」は跳ねるような歩き方になります。「走って」は身体を揺らしません。「スキップ」も同様です。「よろよろ」は身体をよろめかせつつ歩いている様子となります。
#### Start Time
画像の移動を開始する時間をミリ秒単位で指定します。
#### End Time
画像の移動を完了する時間をミリ秒単位で指定します。
#### Color #1
フェードインの際の表示開始色を指定します。完全不透明の白を指定すると元画像の色のままです。透明度を指定することで、フェードインが可能です。
#### Color #2
フェードインの表示終了時、かつフェードアウト表示開始時の色を指定します。フェードインが終わってからフェードアウトが始まるまではこの色が画像に被さります。
#### Color #3
フェードアウトの際の表示終了色を指定します。
#### Fade In Start
```Color #1``` から ```Color #2``` への色変化の開始時間をミリ秒単位で指定します。
#### Fade In End
```Color #1``` から ```Color #2``` への色変化の完了時間をミリ秒単位で指定します。
#### Fade In Opt
上記の色の遷移が「一定」か、「指数関数的」に変化するか、「対数関数的」に変化するかを指定します。
#### Fade Out Start
```Color #2``` から ```Color #3``` への色変化の開始時間をミリ秒単位で指定します。
#### Fade Out End
```Color #2``` から ```Color #3``` への色変化の完了時間をミリ秒単位で指定します。
#### Fade Out Opt
上記の色の遷移が「一定」か、「指数関数的」に変化するか、「対数関数的」に変化するかを指定します。
#### X Scale From
画像を X 軸方向に拡大／縮小表示する場合の初期値を指定します。100 % が規定のサイズになります。
#### X Scale To
画像を X 軸方向に拡大／縮小表示する場合の終了値を指定します。100 % が規定のサイズになります。
#### Y Scale From
画像を Y 軸方向に拡大／縮小表示する場合の初期値を指定します。100 % が規定のサイズになります。
#### Y Scale To
画像を Y 軸方向に拡大／縮小表示する場合の終了値を指定します。100 % が規定のサイズになります。
#### Z Scale From
画像を Z 軸方向に拡大／縮小表示する場合の初期値を指定します。100 % が規定のサイズになります。
#### Z Scale To
画像を Z 軸方向に拡大／縮小表示する場合の終了値を指定します。100 % が規定のサイズになります。
#### Scale Start
画像を拡大／縮小表示する場合の開始時間をミリ秒単位で指定します。
#### Scale End
画像を拡大／縮小表示する場合の完了時間をミリ秒単位で指定します。

----
2014/11/20 初版    
2014/11/21 ```Fade.qtz``` 更新、```Spot Light.qtz``` 追加    
2014/11/23 ```Move.qtz``` 更新    
2014/11/24 ```Bounce.qtz``` 追加    
2014/11/29 ```Fade.qtz``` 更新    
2014/12/18 ```Slide.qtz``` 追加    
2014/12/21 ```Burst.qtz``` 追加    
2014/12/27 ```Foggy.qtz``` & ```Ultra Q.qtz``` 追加    
2014/12/29 ```Slide.qtz``` 仕様変更    
2014/12/31 ```Spin.qtz``` 追加 & ```Slide.qtz```仕様追加    
2015/01/01 ```Fade.qtz``` 仕様変更 & ```Scroll.qtz``` 追加    
2015/01/06 ```Walk.qtz``` 追加    
