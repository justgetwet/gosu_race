require 'gosu'
require 'mini_magick'
require './panels.rb'
require './racers.rb'

class MyGame < Gosu::Window

	def initialize
    @width = 640
    @height = 480
    super @width,@height,false
		@racer_panels = Panels.new
    @background = Gosu::Image.new('./after2.jpg')

    @racers = Racers.new
    @buttons_down = 0
    @ff = 3
	end

  def update
    if @buttons_down == 1
      @racers.update(@ff)
    end
  end

	def draw
    @background.draw(0,0,0)
		@racer_panels.draw
    @racers.draw
	end

  def button_down(id)
    # update if id == Gosu::KbReturn
    @ff = 1 if id == Gosu::KbF1
    @ff = 2 if id == Gosu::KbF2
    @ff = 3 if id == Gosu::KbDelete
    close if id == Gosu::KbEscape
    if id == Gosu::Kb1
      p 'hai!'
    end
    @buttons_down += 1
  end

end

window = MyGame.new
window.show