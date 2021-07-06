require 'gosu'
require './panels.rb'
require './racers.rb'
require './topRacer.rb'

class MyGame < Gosu::Window

	def initialize
    @width = 640
    @height = 480
    super @width,@height,false
    @background = Gosu::Image.new('./course.jpg')
    self.caption = ""
    # @buttons_down = 0
    @race_draw = false
    @kbA_down, @kbP_down, @kbR_down = 1, 1, 1
    @ff = 5
	end

  def load
		@panels = Panels.new
    @racers = Racers.new
    @topRacer = TopRacer.new
    self.caption = @racers.title
    @race_draw = true
    @kbA_down, @kbP_down, @kbR_down = 1, 1, 1
  end

  def update
    if @kbA_down % 2 == 0
      load if not @race_draw
      @racers.update(@ff, 'avg_dif') # avg_dif or rcd_dif
      @topRacer.update_avg(@ff)
    end
    if @kbP_down % 2 == 0 and @topRacer.prd_top != ''
      load if not @race_draw
      @racers.update(@ff, 'prd_dif') # avg_dif or rcd_dif
      @topRacer.update_prd(@ff)
    end
    if @kbR_down % 2 == 0 and @topRacer.run_top != ''
      load if not @race_draw
      @racers.update(@ff, 'run_dif') # avg_dif or rcd_dif
      @topRacer.update_run(@ff)
    end
  end

	def draw
    @background.draw(0,0,0)
    if @race_draw
      @panels.draw
      @racers.draw
      @topRacer.draw
    end
	end

  def button_down(id)
    # update if id == Gosu::KbReturn
    close if id == Gosu::KbEscape
    load if id == 15 # l
    @kbA_down += 1 if id == 4 # a: avg
    @kbP_down += 1 if id == 19 # p: prd
    @kbR_down += 1 if id == 21 # r: rcd
    # p id
    initialize if id == 6 # c
    # @buttons_down += 1
  end

end

window = MyGame.new
window.show