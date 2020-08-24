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
  @@do_exit_log = true
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
    elsif !@@scenes.has_key?(start)
      raise ArgumentError.new("SceneManager haven't key '#{start}' Arg:start")
    else
      @@now = start
    end
    @@scenes[@@now].new(nil) # now scene init!
  end

  class << self
    def update
      @@scenes[@@now].update
    end
    
    def draw
      @@scenes[@@now].draw
    end
    
    def next(scene_symbol, *args)
      raise ArgumentError.new("SceneManager haven't key '#{scene_symbol}' Arg:scene_symbol") unless @@scenes.has_key?(scene_symbol)
      raise ArgumentError.new("'#{scene_symbol}' is now scene") if scene_symbol == @@now
      @@scenes[@@now].last
      @@now = scene_symbol
      @@scenes[@@now].new(args)
    end

    def kill
      exit if @@do_exit_log == false

      puts "Exit! (called 'SceneManager.kill')"
      puts ":: log ::"
      puts "last scene: #{@@scenes[@@now]} (:#{@@now})"
      exit
    end

    # return: symbol
    def now
      @@now
    end

    # return: hash
    def scenes
      @@scenes
    end

    def EXIT_LOG
      @@do_exit_log
    end

    def EXIT_LOG=(bool)
      raise ArgumentError.new("Please boolean") unless bool.class == TrueClass || bool.class == FalseClass 
      @@do_exit_log = bool
    end
  end
end
