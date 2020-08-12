class Scene
  class << self
    def update
    end

    def draw
    end

    def last
    end
  end
end

class SceneManager
  # new(scenes_hash{symbol => SceneClass}, start: symbol)
  def initialize(scenes, start: nil)
    # check type
    raise ArgumentError.new("Please hash! #Arg:scenes") if scenes.class != Hash
    scenes.each do |ary|
      if ary[0].class != Symbol
        raise ArgumentError.new("Please symbol! (#{ary[0]}) #Arg:scenes {symbol: SceneClass}")
      elsif !(ary[1] < Scene)
        raise ArgumentError.new("Please inheritance Scene class! (#{ary[1]}) #Arg:scenes {symbol: SceneClass}")
      end
    end

    @@scenes = scenes
    if start == nil
      @@now = @@scenes.first[0] # first symbol
    else
      @@now = start
    end
    @@scenes[@@now].new # now scene init!
  end

  class << self
    def update
      @@scenes[@@now].update
    end
    
    def draw
      @@scenes[@@now].draw
    end
    
    def next(scene_symbol)
      raise ArgumentError.new("SceneManager haven't key (#{scene_symbol}) Arg:scene_symbol") unless @@scenes.has_key?(scene_symbol)
      @@scenes[@@now].last
      @@now = scene_symbol
      @@scenes[@@now].new
    end

    # return: symbol
    def now
      return @@now
    end

    # return: hash
    def scenes
      return @@scenes
    end
  end
end
