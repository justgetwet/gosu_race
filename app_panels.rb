require 'gosu'
require './panels.rb'

class MyGame < Gosu::Window

	def initialize
    @width = 640
    @height = 480
    super @width,@height,false
		@racer = Panels.new
	end

	def draw
		@racer.draw
	end

end

window = MyGame.new
window.show