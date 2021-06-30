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
    @kbS_down = 1
    @kbR_down = 1
    @ff = 3
	end

  def load
		@panels = Panels.new
    @racers = Racers.new
    self.caption = @racers.title
    @race_draw = true
    if @kbS_down % 2 == 0
      @raceInfo = RaceInfo.new('prd')
    end
    if @kbR_down % 2 == 0
      @raceInfo = RaceInfo.new('run')
    end
    # @kbS_down = 1
    # @kbR_down = 1
  end

  def update
    if @kbS_down % 2 == 0
      load if not @race_draw
      @racers.update(@ff, 'avg_dif') # avg_dif or run_dif
      @raceInfo.update(@ff)
    end
    if @kbR_down % 2 == 0
      load if not @race_draw
      @racers.update(@ff, 'run_dif') # avg_dif or run_dif
      @raceInfo.update(@ff)
    end
  end

	def draw
    @background.draw(0,0,0)
    if @race_draw
      @panels.draw
      @raceInfo.draw
      if @kbS_down % 2 == 0
        @racers.draw('a')
      end
      if @kbR_down % 2 == 0
        @racers.draw('r')
      end
    end
	end

  def button_down(id)
    # update if id == Gosu::KbReturn
    # close if id == Gosu::KbEscape
    load if id == 15 # l
    @kbS_down += 1 if id == 22 # s
    @kbR_down += 1 if id == 21 # r
    initialize if id == 6 # c
    # @buttons_down += 1
  end

end

window = MyGame.new
window.show