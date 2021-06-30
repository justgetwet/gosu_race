require 'gosu'
require './racej.rb'

class Racer

	attr_accessor :degree, :dif

end

class RaceInfo

	FONT = Gosu::Font.new(18, :name => './fonts/MPLUS1p-Regular.ttf')

	def initialize(lap_case)
		race = Race.new
		a_idx = race.avgDifs.index(0.0)
		avg_no = race.nos[a_idx]
		avg_name = race.names[a_idx]
    @avg_lap = race.avgLaps[a_idx]
		@avg_top = '平均 Lap (' + avg_no + ') ' + avg_name

		m_idx = race.maxDifs.index(0.0)
		max_no = race.nos[m_idx]
		max_name = race.names[m_idx]
    # @max_lap = race.maxLaps[m_idx]
		@max_top = '最速 Lap (' + max_no + ') ' + max_name

		p_idx = race.prdDifs.index(0.0)
		prd_no = race.nos[p_idx]
		prd_name = race.names[p_idx]
    @prd_lap = race.prdLaps[p_idx]
		@prd_top = '直前 Lap (' + prd_no + ') ' + prd_name

		r_idx = race.runDifs.index(0.0)
		run_no = race.nos[r_idx]
		run_name = race.names[r_idx]
    @run_lap = race.runLaps[r_idx]
		@run_top = '本番 Lap (' + run_no + ') ' + run_name

    hand = race.handicaps[a_idx]
    @topRacer = Racer.new
    @topRacer.degree = -36 - (7.2 * hand.to_f/10)
    
    @lap = @avg_lap
    @lap = @prd_lap if lap_case == 'prd'
    @lap = @run_lap if lap_case == 'run'
    @topRacer.dif = 1.2 / @lap

		@around = 1

	end

	def update(ff)
		# @time = Gosu.milliseconds * 1/1000
    @topRacer.degree += (@topRacer.dif * ff)

	end

	def draw
    # 640 x 480
		if @topRacer.degree > 360 * @around + 36 and @around < 6
			@around += 1
		end
		
		if @topRacer.degree < 360 * 6 + 36
			then 
        countColor = Gosu::Color::GREEN
        countColor = Gosu::Color::RED if @lap == @prd_lap
        countColor = Gosu::COlor::BLUE if @lap == @run_lap
        FONT.draw_text(@around, 310, 230 , 1, 2, 2, countColor)
        FONT.draw_text('Run!', 260, 233 , 1, 1.5, 1.5, countColor)
			else
				FONT.draw_text(@avg_top, 240, 210, 1, 1.2, 1.2, 0xff000000)
				FONT.draw_text(@max_top, 240, 230, 1, 1.2, 1.2, 0xff000000)
				FONT.draw_text(@prd_top, 240, 250, 1, 1.2, 1.2, 0xff000000)
        if @lap == @run_lap
          FONT.draw_text(@run_top, 240, 270, 1, 1.2, 1.2, Gosu::Color::BLUE)
        end
      end
	end

end

