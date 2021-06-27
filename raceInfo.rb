require 'gosu'
require './racej.rb'

class Racer

	attr_accessor :degree, :d

end

class RaceInfo

	def initialize
		race = Race.new

		# p race.avgDiffs.sort
		# -> [0.0, 9.1764705882, 9.1764705882, 9.1764705882, ..
		# minLap = race.avgLaps.min
		# idx = race.avgLaps.index(minLap)
		idx = race.avgDiffs.index(0.0)
		lap = race.avgLaps[idx]
		hand = race.handicaps[idx]
		no = race.nos[idx]
		name = race.names[idx]
		@top = '1着: ' + no.to_s + ' ' + name
		@topRacer = Racer.new
		@topRacer.degree = -36 - (7.2 * hand.to_f/10)
		@topRacer.d = 1.2 * 1 / lap

    font = './fonts/MPLUS1p-Regular.ttf'
    @text = Gosu::Font.new(18, :name => font)
		@around = 1

	end

	def update(ff)
		# @time = Gosu.milliseconds * 1/1000
    @topRacer.degree += (@topRacer.d * ff)

	end

	def draw
		if @topRacer.degree > 360 * @around + 36 and @around < 6
			@around += 1
		end
		
		if @topRacer.degree < 360 * 6 + 36
			then @text.draw_text(@around, 200, 230, 1, 1.2, 1.2, Gosu::Color::RED)
			else @text.draw_text(@top, 200, 230, 1, 1.2, 1.2, Gosu::Color::RED)
		end
	end

end

