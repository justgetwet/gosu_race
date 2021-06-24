require 'gosu'
require 'mini_magick'
require './panels.rb'

class MyGame < Gosu::Window

	def initialize
    @width = 640
    @height = 480
    super @width,@height,false
		@racer = Panels.new
    @background = Gosu::Image.new('./from_unsplash.jpg')
	end

  def update

  end

	def draw
    @background.draw(0,0,0)
		@racer.draw
	end

end

window = MyGame.new
window.show