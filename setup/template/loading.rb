$loading_template = <<-EOS
# This file was created by the program

# Loading is a special scene
# You can call it by writing `SceneManager.next(:any, loading: true)`

class Loading < Scene
  def initialize
    # write your code here 
  end

  class << self
    def update
      # write your code here
    end

    def draw
      # write your code here
    end
  end
end
EOS
