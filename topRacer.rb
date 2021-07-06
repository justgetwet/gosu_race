require 'gosu'
require './racej.rb'

class Racer

	attr_accessor :degree, :dif

end

class TopRacer

	FONT = Gosu::Font.new(18, :name => './fonts/RictyDiminished-Regular.ttf')
	
  attr_accessor :lapcase
  attr_accessor :prd_top, :run_top

	def initialize
		race = Race.new
		a_idx = race.avgDifs.index(0.0)
		avg_no = race.nos[a_idx]
		avg_name = race.names[a_idx]
    @avg_lap = race.avgLaps[a_idx]
		@avg_dif = 1.2 / @avg_lap
		@avg_top = 'Avg lap (' + avg_no + ') ' + avg_name

		m_idx = race.fstDifs.index(0.0)
		fst_no = race.nos[m_idx]
		fst_name = race.names[m_idx]
    # @max_lap = race.maxLaps[m_idx]
		@fst_top = 'Fst lap (' + fst_no + ') ' + fst_name

		if race.prdDifs.all?
			p_idx = race.prdDifs.index(0.0)
			prd_no = race.nos[p_idx]
			prd_name = race.names[p_idx]
			prd_lap = race.prdLaps[p_idx]
			@prd_dif = 1.2 / prd_lap
			@prd_top = 'Prd lap (' + prd_no + ') ' + prd_name
		else
			@prd_top = ""
		end

		if race.runDifs.all?
			r_idx = race.runDifs.index(0.0)
			run_no = race.nos[r_idx]
			run_name = race.names[r_idx]
			run_lap = race.runLaps[r_idx]
			@run_dif = 1.2 / run_lap
			@run_top = 'Rcd lap (' + run_no + ') ' + run_name
		else
			@run_top = ""
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

	def update_run(ff)
		unless @once
			@lapcase = 'Run!'
			@once = true
		end
		@racer.degree += @run_dif * ff
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
				FONT.draw_text(@fst_top, 215, 225, 1, 1.2, 1.2, 0xff000000)
				if @lapcase == 'Predict'
					FONT.draw_text(@prd_top, 215, 250, 1, 1.2, 1.2, Gosu::Color::BLUE)
				end
        if @lapcase == 'Run!'
					FONT.draw_text(@prd_top, 215, 250, 1, 1.2, 1.2, 0xff000000)
          FONT.draw_text(@run_top, 215, 275, 1, 1.2, 1.2, Gosu::Color::BLUE)
        end
      end
	end

end
