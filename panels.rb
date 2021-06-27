require 'gosu'
require './racej.rb'

class Panels

	def initialize

    font = './fonts/MPLUS1p-Regular.ttf'
    @text = Gosu::Font.new(18, :name => font)

		@images = []
		@frames = []
    @ranks = []
    @names = []
    race = Race.new
		race.images.zip(race.frames, race.ranks, race.names) do |image, frame, rank, name|
			@images << Gosu::Image.new(image)
			@frames << Gosu::Image.new(frame)
			@ranks << rank
			@names << name
		end

	end

	def draw
    
		x = -50
		y = 10
		add_x = 75
		@images.zip(@frames, @ranks, @names) do |image, frame, rank, name|
			x += add_x
			image.draw(x, y, 2)
			frame.draw(x, y, 1)
      @text.draw_text(rank, x, y+70, 1, 1, 1, 0xff000000)
      @text.draw_text(name, x, y+85, 1, 1, 1, 0xff000000)
		end

	end

end