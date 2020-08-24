require 'dxruby'
require_relative 'scene-manager' # can use Scene and SceneManager

$font = Font.new(24)
# scene: title
class Title < Scene # have to Inheritance `Scene` class
  def initialize(args)
    @@y = 5
  end

  class << self
    # call always
    def update
      SceneManager.next(:play) if Input.key_push?(K_SPACE)
    end

    # call always
    def draw
      Window.draw_font(5, @@y,      "hello SceneManager!", $font)
      Window.draw_font(5, @@y + 30, "this is Title Scene ...", $font)
      Window.draw_font(5, @@y + 55, "Push to space key!", $font)
    end

    # call one time
    def last
      i = 0.1
      loop do
        Window.update
        i += 0.001
        i = (i > 1 ? 1 : i)
        @@y += i*i
        Window.draw_font(5, @@y,      "hello SceneManager!", $font)
        Window.draw_font(5, @@y + 30, "this is Title Scene ...", $font)
        Window.draw_font(5, @@y + 55, "Push to space key!", $font)
        break if @@y > 480
        break if Input.key_down?(K_ESCAPE)
      end
    end
  end
  # ↑ same `def self.update` or `def self.draw``
end

# scene: play
class Play < Scene
  def initialize(args)
    @@box = Sprite.new(100, 100, Image.new(50, 50, C_RED))
    @@mouse_x, @@mouse_y = Input.mouse_x, Input.mouse_y
    p args[0]
    p args[1]
  end

  class << self
    def update
      @@mouse_x, @@mouse_y = Input.mouse_x, Input.mouse_y
      if @@box.x <= @@mouse_x && @@mouse_x <= @@box.x + @@box.image.width &&
         @@box.y <= @@mouse_y && @@mouse_y <= @@box.y + @@box.image.height
        @@box.image = Image.new(50, 50, C_CYAN)
        SceneManager.kill if Input.mouse_down?(0)
      else
        @@box.image = Image.new(50, 50, C_RED)
      end
    end

    def draw
      @@box.draw
      Window.draw_font(5, 5,  "Play Scene ...", $font)
      Window.draw_font(5, 35, "Click box!", $font)
      Window.draw_font(5, 55, "mouse x : #{@@mouse_x}, y : #{@@mouse_y}", $font)
    end
  end
end


SceneManager.new({
  title: Title,
  play: Play
})


Window.loop do
  break if Input.key_down?(K_ESCAPE)
  SceneManager.update
  SceneManager.draw
end
