require 'gosu'
require './racej.rb'

class Racer

  attr_accessor :piece, :name
  attr_accessor :handicap
  attr_accessor :degree
  attr_accessor :avg_dif, :prd_dif, :rcd_dif
  attr_accessor :x, :y
  attr_accessor :avg_goalx, :avg_goaly
  attr_accessor :max_goalx, :max_goaly
  attr_accessor :prd_goalx, :prd_goaly
  attr_accessor :rcd_goalx, :rcd_goaly

end

class Racers

  attr_reader :title
	
	def initialize

    race = Race.new
    @title = race.title
    pieces = race.pieces
    names = race.names
    handicaps = race.handicaps
    avgLaps = race.avgLaps
    maxLaps = race.maxLaps
    prdLaps = race.prdLaps
    rcdLaps = race.rcdLaps

    racerColors = []
    avg_goaltimes = []
    max_goaltimes = []
    prd_goaltimes = []
    rcd_goaltimes = []
    avgLaps[0] = avgLaps[0] + 0.01
    maxLaps[0] = maxLaps[0] + 0.01
    prdLaps[0] = prdLaps[0] + 0.01
    handicaps.zip(avgLaps, maxLaps, prdLaps, rcdLaps) do |hand, avgLap, maxLap, prdLap, rcdLap|
      avg_goaltimes << avgLap * (31.0 + hand.to_f/100)
      max_goaltimes << maxLap * (31.0 + hand.to_f/100)
      prd_goaltimes << prdLap * (31.0 + hand.to_f/100)
      rcd_goaltimes << rcdLap * (31.0 + hand.to_f/100)
    end
    start_positions =
      {
        0 => [168.0, 345.5],
        10 => [143.6, 335.4],
        20 => [121.7, 323.8],
        30 => [100.3, 309.0],
        40 => [85.0, 295.0],
        50 => [73.2, 280.0]
      }

    def self.goal_positions(goaltimes, pos_y)
      top_time = goaltimes.min
      mps = 0.034 # 3.4sec / 100m
      goal_x, goal_y =  470.0 + 50.0, 345.0 + 15.0
      
      positions = []
      goaltimes.each do |goal_time|
        dif_m = (goal_time - top_time) / mps
        # p dif_m
        dif_x = 3 * dif_m
        positions << [goal_x - dif_x, goal_y + pos_y]
      end
      return positions
    end
    # goal時の1着との距離
    avgGoals = goal_positions(avg_goaltimes, 0.0)
    maxGoals = goal_positions(max_goaltimes, 25.0)
    prdGoals = goal_positions(prd_goaltimes, 50.0)
    rcdGoals = goal_positions(rcd_goaltimes, 75.0)
    
    # set racers
    @racers = []
    pieces.zip(names, handicaps, avgLaps, prdLaps, rcdLaps, avgGoals, maxGoals, prdGoals, rcdGoals) do 
      |piece, name, hand, avglap, prdlap, rcdlap, avg, max, prd, rcd|
      racer = Racer.new
      racer.piece = Gosu::Image.new(piece)
      racer.name = name
      racer.handicap = hand
      racer.degree = -36.0 - (7.2 * hand.to_f/10)
      racer.avg_dif = 1.2 / avglap
      racer.prd_dif = 1.2 / prdlap
      racer.rcd_dif = 1.2 / rcdlap
      racer.x, racer.y = start_positions[hand]
      racer.avg_goalx, racer.avg_goaly = avg
      racer.max_goalx, racer.max_goaly = max
      racer.prd_goalx, racer.prd_goaly = prd
      racer.rcd_goalx, racer.rcd_goaly = rcd
      @racers << racer
    end

    # @purple = Gosu::Image.new('./colors/racer_0.png')

	end

  def update(ff, method_name)
    @case_of_lap = method_name # avg_dif, prd_dif, rcd_dif
    @racers.each do |racer|
      d = racer.send(@case_of_lap)
      racer.degree += (d * ff)
      rad = racer.degree * Math::PI/180
      racer.x += 4.5 * d * ff * Math.cos(-rad)
      racer.y += 2.3 * d * ff * Math.sin(-rad)
    end
  end

  def draw
    if @case_of_lap
      @racers.each do |racer|
        if racer.degree < 360 * 6 + 36
          then racer.piece.draw(racer.x, racer.y, 1)
          else 
            racer.piece.draw(racer.avg_goalx, racer.avg_goaly)
            racer.piece.draw(racer.max_goalx, racer.max_goaly)
            if @case_of_lap == 'prd_dif'
              racer.piece.draw(racer.prd_goalx, racer.prd_goaly)
            end
            if @case_of_lap == 'rcd_dif'
              racer.piece.draw(racer.prd_goalx, racer.prd_goaly)
              racer.piece.draw(racer.rcd_goalx, racer.rcd_goaly)
            end
        end
      end
    end
    # @purple.draw(320, 240, 1)
  end

end

# r = Racers.new
# r.test