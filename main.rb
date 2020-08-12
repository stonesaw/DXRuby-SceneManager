require 'dxruby'
require_relative 'scene'
require_relative 'scenes/title'
require_relative 'scenes/play'

SceneManager.new({
  title: Title,
  play: Play
})

Window.loop do
  break if Input.key_down?(K_ESCAPE)
  SceneManager.update
  SceneManager.draw
end
