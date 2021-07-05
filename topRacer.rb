require 'gosu'
require './racej.rb'

class Racer

	attr_accessor :degree, :dif

end

class TopRacer

	FONT = Gosu::Font.new(18, :name => './fonts/RictyDiminished-Regular.ttf')
	attr_accessor :lapcase

	def initialize
		race = Race.new
		a_idx = race.avgDifs.index(0.0)
		avg_no = race.nos[a_idx]
		avg_name = race.names[a_idx]
    @avg_lap = race.avgLaps[a_idx]
		@avg_dif = 1.2 / @avg_lap
		@avg_top = 'Avg lap (' + avg_no + ') ' + avg_name

		m_idx = race.maxDifs.index(0.0)
		max_no = race.nos[m_idx]
		max_name = race.names[m_idx]
    # @max_lap = race.maxLaps[m_idx]
		@max_top = 'Fst lap (' + max_no + ') ' + max_name

		if race.prdDifs.all?
			p_idx = race.prdDifs.index(0.0)
			prd_no = race.nos[p_idx]
			prd_name = race.names[p_idx]
			@prd_lap = race.prdLaps[p_idx]
			@prd_dif = 1.2 / @prd_lap
			@prd_top = 'Prd lap (' + prd_no + ') ' + prd_name
		else
			@prd_top = ""
		end

		if race.rcdDifs.all?
			r_idx = race.rcdDifs.index(0.0)
			rcd_no = race.nos[r_idx]
			rcd_name = race.names[r_idx]
			@rcd_lap = race.rcdLaps[r_idx]
			@rcd_dif = 1.2 / @rcd_lap
			@rcd_top = 'Rcd lap (' + rcd_no + ') ' + rcd_name
		else
			@rcd_top = ""
		end

    hand = race.handicaps[a_idx]
    @racer = Racer.new
    @racer.degree = -36 - (7.2 * hand.to_f/10)

		@around = 0
		@lapcase = ''
		@once = false

	end

	def update_avg(ff)
		unless @once
			@lapcase = 'Average'
			@once = true
		end
    @racer.degree += @avg_dif * ff
	end

	def update_prd(ff)
		unless @once
			@lapcase = 'Predict'
			@once = true
		end
		@racer.degree += @prd_dif * ff
	end

	def update_rcd(ff)
		unless @once
			@lapcase = ' Record'
			@once = true
		end
		@racer.degree += @rcd_dif * ff
	end
	
	def draw
    # 640 x 480
		if @racer.degree > 360 * @around + 36 and @around < 6
			@around += 1
		end
		
		if @racer.degree < 360 * 6 + 36
			then
				FONT.draw_text(@lapcase, 222, 238 , 1, 1.2, 1.2, 0xff000000)
        FONT.draw_text(@around, 310, 230 , 1, 2, 2, 0xff000000)
			else
				FONT.draw_text(@avg_top, 215, 200, 1, 1.2, 1.2, 0xff000000)
				FONT.draw_text(@max_top, 215, 225, 1, 1.2, 1.2, 0xff000000)
				if @lapcase == 'Predict'
					FONT.draw_text(@prd_top, 215, 250, 1, 1.2, 1.2, Gosu::Color::BLUE)
				end
        if @lapcase == ' Record'
					FONT.draw_text(@prd_top, 215, 250, 1, 1.2, 1.2, 0xff000000)
          FONT.draw_text(@rcd_top, 215, 275, 1, 1.2, 1.2, Gosu::Color::BLUE)
        end
      end
	end

end
