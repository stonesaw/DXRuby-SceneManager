class Play < Scene
  def initialize
    @@box = Sprite.new(200, 200, Image.new(50, 50, C_RED))
    @@font = Font.new(24)
  end

  class << self
    def update
      SceneManager.next(:title) if Input.key_push?(K_SPACE)
      @@box.angle += 2
    end

    def draw
      @@box.draw
      Window.draw_font(510, 5,  "Scene: Play", @@font)
      Window.draw_font(100, 100, "スペースキーを押して前のシーンに戻ります", @@font)
    end
  end
end
