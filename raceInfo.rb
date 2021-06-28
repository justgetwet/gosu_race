require 'gosu'
require './racej.rb'

class Racer

	attr_accessor :degree, :dif

end

class RaceInfo

	FONT = Gosu::Font.new(18, :name => './fonts/MPLUS1p-Regular.ttf')

	def initialize
		race = Race.new
		a_idx = race.avgDifs.index(0.0)
		avg_no = race.nos[a_idx]
		avg_name = race.names[a_idx]
		@avg_top = '平均lap 1着:(' + avg_no + ') ' + avg_name

		m_idx = race.maxDifs.index(0.0)
		max_no = race.nos[m_idx]
		max_name = race.names[m_idx]
		@max_top = '最速lap 1着:(' + max_no + ') ' + max_name

		p_idx = race.prdDifs.index(0.0)
		prd_no = race.nos[p_idx]
		prd_name = race.names[p_idx]
		@prd_top = '予測lap 1着:(' + prd_no + ') ' + prd_name

		lap = race.avgLaps[a_idx]
		hand = race.handicaps[a_idx]
		@topRacer = Racer.new
		@topRacer.degree = -36 - (7.2 * hand.to_f/10)
		@topRacer.dif = 1.2 / lap

		@around = 1

	end

	def update(ff)
		# @time = Gosu.milliseconds * 1/1000
    @topRacer.degree += (@topRacer.dif * ff)

	end

	def draw
		if @topRacer.degree > 360 * @around + 36 and @around < 6
			@around += 1
		end
		
		if @topRacer.degree < 360 * 6 + 36
			then FONT.draw_text(@around, 280, 200 , 1, 1.5, 1.5, Gosu::Color::BLUE)
			else 
				FONT.draw_text(@avg_top, 200, 230, 1, 1.2, 1.2, Gosu::Color::GREEN)
				FONT.draw_text(@max_top, 200, 250, 1, 1.2, 1.2, Gosu::Color::RED)
				FONT.draw_text(@prd_top, 200, 270, 1, 1.2, 1.2, Gosu::Color::BLUE)
		end
	end

end

