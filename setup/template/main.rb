$main_template = <<-EOS
# This file was created by the program

require "dxruby"

require_relative "scene-manager"
REQUIRE_SCENES


SceneManager.new(ARGS)


Window.loop do
  SceneManager.update
  SceneManager.draw
end
EOS