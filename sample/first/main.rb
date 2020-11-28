require "dxruby"

# scene-manager とそれぞれのシーンのファイルを require して、このファイルに加えます
require_relative "../../scene-manager"
require_relative 'scenes/loading'
require_relative "scenes/title"
require_relative "scenes/play"


# SceneManager を初期化します
SceneManager.new({
  title: Title,
  play: Play
})

# Window.loop は DXRuby が持つメインループです
# SceneManager を使う際は、ここに処理を書くことは少ないと思います
Window.loop do
  break if Input.key_down?(K_ESCAPE)
  SceneManager.update
  SceneManager.draw
end
