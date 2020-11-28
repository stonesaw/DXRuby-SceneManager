class Title < Scene
  def initialize
    @@font_big = Font.new(36)
    @@font = Font.new(24)
  end

  class << self
    def update
      SceneManager.next(:play) if Input.key_push?(K_SPACE)
    end

    def draw
      Window.draw_font(510, 5, "Scene: Title", @@font)
      Window.draw_font(160, 180, "Hello SceneManager!", @@font_big)
      Window.draw_font(100, 235, "スペースキーを押して次のシーンに進みます", @@font)
    end
  end
end
