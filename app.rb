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
    self.caption = ""
    # @buttons_down = 0
    @race_draw = false
    @btn_s_down = 1
    @ff = 3
	end

  def load
		@panels = Panels.new
    @racers = Racers.new
    @raceInfo = RaceInfo.new
    @btn_s_down = 1
    self.caption = @racers.title
    @race_draw = true
  end

  def update
    if @btn_s_down % 2 == 0
      @racers.update(@ff)
      @raceInfo.update(@ff)
    end
  end

	def draw
    @background.draw(0,0,0)
    if @race_draw
      @panels.draw
      @racers.draw
      @raceInfo.draw
    end
	end

  def spam
    @start = true
  end

  def button_down(id)
    # update if id == Gosu::KbReturn
    # close if id == Gosu::KbEscape
    load if id == 15 # l
    @btn_s_down += 1 if id == 22 # s
    initialize if id == 6 # c
    # p id
    # @buttons_down += 1
  end

end

window = MyGame.new
window.show