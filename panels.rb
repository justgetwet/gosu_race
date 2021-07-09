require 'gosu'
require './racej.rb'

class Panels

	FONT = Gosu::Font.new(14, :name => './fonts/RictyDiminished-Regular.ttf')

	def initialize

		@images = []
		@frames = []
    @names = []
    @ranks = []
    @laps = []
    @hands = []
    r = Race.new
		r.images.zip(r.frames, r.ranks, r.names, r.avgLaps, r.hands) do
      |image, frame, rank, name, lap, hand|
			@images << Gosu::Image.new(image)
			@frames << Gosu::Image.new(frame)
			@names << name
      @ranks << rank
      @laps << lap
      @hands << hand
		end

	end

	def draw
    
		x = -50
		y = 10
		add_x = 75
		@images.zip(@frames, @names, @ranks, @laps, @hands) do
      |image, frame, name, rank, lap, hand|
			x += add_x
			image.draw(x, y, 2)
			frame.draw(x, y, 1)
      FONT.draw_text(name, x, y+70, 1, 1, 1, 0xff000000)
      FONT.draw_text(rank, x, y+85, 1, 1, 1, 0xff000000)
      FONT.draw_text(lap, x, y+100, 1, 1, 1, 0xff000000)
      FONT.draw_text(hand, x, y+115, 1, 1, 1, 0xff000000)
		end

	end

end