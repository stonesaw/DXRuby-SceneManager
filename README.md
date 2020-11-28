# DXRuby-SceneManager
DXRubyでシーン遷移を行うためのライブラリです  
[DXRubyとは...](http://dxruby.osdn.jp/)
## Getting start with ...
RubyとDXRubyがインストールされた環境で
```
git clone https://github.com/stonesaw/DXRuby-SceneManager
cd DXRuby-SceneManager
ruby sample/first/main.rb
```

## setup tool
SceneManagerを使用した、DXRubyのソースコードをセットアップするためのツールです。

このリポジトリをクローン後、ターミナルで
```
ruby setup.rb
```
と入力します  
するといくつかの質問がされるので、それに答えてください
```
[ Make SceneManager Template ]
 1. your project name here > hello_app
    OK
 2. What scenes to add? (example: > title play) > home play
    OK
```


### Tutorial
### Reference
### Scene class
- `.set_music`
- `.update`
- `.draw`
- `.last`
### SceneManager class
- `.new(scenes, start: nil, loading: false)`
- `.next(scene_symbol, *args, loading: false, is_init: tru)`
- `.update`
- `.draw`
- `.now`
- `.scenes`