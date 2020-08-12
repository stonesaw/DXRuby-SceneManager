class Play < Scene
  def initialize
    @@a = Sprite.new(100, 100, Image.new(50, 50, C_RED))
  end

  class << self
    def draw
      @@a.draw
    end
  end
end
