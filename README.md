「絵解き帳」追加エフェクト集
===============

----
Mac 用紙芝居動画作成支援アプリ、「[絵解き帳] [1]」の追加エフェクト集です。

以下の場所にパッチをコピーした後、[絵解き帳] [1]を再起動すれば利用できるようになります。

パッチ名| 設置場所
--------------------|----------
Bump.qtz| ~/Library/Compositions/
Move.qtz| ~/Library/Compositions/
Moving Image.qtz| ~/Library/Compositions/
Shake.qtz| ~/Library/Compositions/
Pixels To Units Coordinate.qtz| ~/Library/Graphics/Quartz Composer Patches
AnchoredSprite.plugin| ~/Library/Graphics/Quartz Composer Plug-ins
TimerSwitch.plugin|~/Library/Graphics/Quartz Composer Plug-ins

※ AnchoredSprite.plugin は、Move.qtz でのみ使用されているため、Move.qtz を使わない場合はコピーする必要がありません。

※ TimerSwitch.plugin は、Shake.qtz を除く他のパッチすべてに使われているため、必ずコピーして下さい。

[1]:	http://nikyo.b.sourceforge.jp/%E4%BD%95%E3%81%9E%E3%80%81%E7%B5%B5%E8%A7%A3%E3%81%8D%E5%B8%B3/ "絵解き帳"
----
## Bump.qtz
何かにぶつかったり、ぶつけられたりした時などによくある横揺れや縦揺れを表現するエフェクトです。


### 指定可能なパラメータ

#### X

### 設置場所

----
## Move.qtz

レイヤーを指定時間内に移動させます。移動量と移動を開始する時間、移動を完了させる時間を指定します。なお、併せてフェード、ズーム、回転、ジャンプを指定することで、フェードインしながら登場とか、ぴょんぴょん跳ねながら移動、くるくる周りながら退場といったことができるようになっています。

※「絵解き帳」の仕様上の制約から、回転やズームを行わせる場合に、回転やズームの起点となる画面内の座標を指定する必要があります。このアンカー座標を基準にして画像が回転します。実際には、アンカー座標を基準に画像を中央に描画し直して、そこで各種のエフェクトをかけた後、元の位置に画像を書き戻す、という処理を内部でしているので、GPU的には少しだけ重い処理になっています。


----
## Moving Image.qtz

前述の「Move.qtz」よりも描画回数が少ない（＝多少は動作が軽い）、回転ができない、ズームの基準座標がスクリーン中央に固定されている、といった点に違いがあります。


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

※なお、絵解き帳の仕様が原因で、元画像が画面から見切れる位置にあると、見切れた表示のまま移動してしまいます。使用する際はご注意下さい。

### 設置場所
~/Library/Compositions/

(ユーザーフォルダ直下の Library フォルダ内にある Compositions フォルダです)

----
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

### 設置場所
~/Library/Compositions/

(ユーザーフォルダ直下の Library フォルダ内にある Compositions フォルダです)

----
## Draw String With FontLister
標準では、文字を横向きもしくは縦向きにしか表示できませんが、このエフェクトでは任意の角度で表示させることができます。その際、移動やフェードなどのエフェクトをかけることもできます。フォントの選択に、[Font Lister][2]を使用しているため、別途入手して下さい。

※ [Font Lister][2] を以下のフォルダのいずれかに設置した後で、導入して下さい。

	~/Library/Graphics/Quartz Composer Plug-Ins/
	/Library/Graphics/Quartz Composer Plug-Ins/
	/System/Library/Graphics/Quartz Composer Plug-Ins/

[2]: "http://www.kei3.com/archives/140" "Font Lister"

#### String
表示させる文字列を入力して下さい。
#### Font Name
フォントを指定します。
#### Font Size
フォントサイズをピクセル単位で指定します。
#### Color
文字色を指定します。

#### Bounce
文字をジャンプさせる回数を指定します。
#### Height
文字をジャンプする高さを指定します。
#### Jump_Start
文字がジャンプを始める時間をミリ秒単位で指定します。0 を指定すると、シーンの表示と同時に移動を開始します。
#### Jump_End
文字がジャンプを終える時間をミリ秒単位で指定します。

※大変残念なことに、Quartz Composer の仕様のため、文字に縁取りや影をつけることはできません。
