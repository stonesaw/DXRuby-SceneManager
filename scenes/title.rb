class Title < Scene
  def initialize
    @@font = Font.new(48)
    @@str = "hello"
    @@font_w = @@font.get_width(@@str)
    @@frame = Sprite.new(100, 100, Image.new(300, 60).box(0, 0, 300, 60, C_WHITE))
    @@moji =  Sprite.new(100, 100, Image.new(300, 60).draw_font(8, 6, @@str, @@font, C_WHITE))
    @@cursor = Sprite.new(100, 106, Image.new(1, 48, C_WHITE))
    @@ex = Sprite.new(40, 300, Image.new(400, 60).draw_font(8, 6, "Please type 'Next'...", @@font))
    @@tick = 0
    @@alphabet = ('a'..'z').to_a
  end

  class << self
    def update
      @@tick += 1
      SceneManager.next(:play) if Input.key_down?(K_RETURN) && @@str == "Next"
      typing()
      
      if @@str == "Next"
        @@ex.image = Image.new(400, 60).draw_font(8, 6, "And push Enter!", @@font)
      else
        @@ex.image = Image.new(400, 60).draw_font(8, 6, "Please type 'Next'...", @@font)
      end

      @@font_w = @@font.get_width(@@str)
      if @@font_w + 16 > @@frame.image.width
        diff = @@font_w + 16 - @@frame.image.width
        @@cursor.x = @@frame.x + @@frame.image.width - 15
        @@moji.image = Image.new(300, 60).draw_font(-diff, 6, @@str, @@font, C_WHITE)
      else
        @@cursor.x = @@frame.x + 10 + @@font_w
        @@moji.image = Image.new(300, 60).draw_font(8, 6, @@str, @@font, C_WHITE)
      end
    end

    def draw
      @@frame.draw
      @@moji.draw
      @@cursor.draw if (@@tick % 60 < 30)
      @@ex.draw
      Window.draw_font(2, 2, "fps : #{Window.real_fps}", @@font)
    end

    private
    def typing
      26.times do |i|
        if Input.key_push?(eval("K_" + @@alphabet[i].upcase))
          if Input.key_down?(K_LSHIFT) || Input.key_down?(K_RSHIFT)
            @@str += @@alphabet[i].upcase
          else
            @@str += @@alphabet[i]
          end
        end
      end
      @@str += " " if Input.key_push?(K_SPACE) || Input.key_down?(K_SPACE) && @@tick % 6 == 0
      @@str[-1] = "" if @@str.length > 0 && (Input.key_push?(K_BACK) || Input.key_down?(K_BACK) && @@tick % 6 == 0)
    end
  end
end
