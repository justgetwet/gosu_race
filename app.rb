require 'gosu'
require './panels.rb'
require './racers.rb'
require './raceInfo.rb'

class MyGame < Gosu::Window

	def initialize
    @width = 640
    @height = 480
    super @width,@height,false

    @background = Gosu::Image.new('./course.jpg')
		@panels = Panels.new
    @racers = Racers.new
    @raceInfo = RaceInfo.new
    self.caption = @racers.title
    
    @buttons_down = 0
    @ff = 3
	end

  def update
    if @buttons_down == 1
      @racers.update(@ff)
      @raceInfo.update(@ff)
    end
  end

	def draw
    @background.draw(0,0,0)
		@panels.draw
    @racers.draw
    @raceInfo.draw
	end

  def button_down(id)
    # update if id == Gosu::KbReturn
    @ff = 1 if id == Gosu::KbF1
    @ff = 2 if id == Gosu::KbF2
    @ff = 3 if id == Gosu::KbDelete
    close if id == Gosu::KbEscape
    @buttons_down += 1
  end

end

window = MyGame.new
window.show