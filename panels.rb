require 'gosu'
require './readjson.rb'

class Panels

	def initialize

    font = './fonts/MPLUS1p-Regular.ttf'
    @text = Gosu::Font.new(18, :name => font)

		@racerimages = []
		@frames = []
    @ranks = []
    @names = []
		no = 0
		RaceFile.images.zip(RaceFile.ranks, RaceFile.names) do |image, rank, name|
			@racerimages << Gosu::Image.new(image)
			@ranks << rank
			@names << name
			no += 1
			p = './colors/frame_' + no.to_s + '.jpg'
			@frames << Gosu::Image.new(p)
		end

	end

	def draw

		x = -50
		y = 10
		add_x = 75
		@racerimages.zip(@frames, @ranks, @names) do |image, frame, rank, name|
			x += add_x
			image.draw(x, y, 2)
			frame.draw(x, y, 1)
      @text.draw_text(rank, x, y+70, 1, 1, 1, 0xff000000)
      @text.draw_text(name, x, y+85, 1, 1, 1, 0xff000000)
		end

	end

end