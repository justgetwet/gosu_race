require 'gosu'
require './racej.rb'

class Racer

  attr_accessor :piece, :name
  attr_accessor :handicap
  attr_accessor :degree
  attr_accessor :avg_dif, :prd_dif, :run_dif
  attr_accessor :x, :y
  attr_accessor :avg_goalx, :avg_goaly
  attr_accessor :fst_goalx, :fst_goaly
  attr_accessor :prd_goalx, :prd_goaly
  attr_accessor :run_goalx, :run_goaly

end

class Racers

  attr_reader :title
  # attr_accessor :sum_rcd

	def initialize

    race = Race.new
    @title = race.title
    pieces = race.pieces
    names = race.names
    handicaps = race.handicaps
    avgLaps = race.avgLaps
    fstLaps = race.fstLaps
    prdLaps = race.prdLaps
    runLaps = race.runLaps
    # @sum_run = runLaps.sum

    racerColors = []
    avg_goaltimes = []
    fst_goaltimes = []
    prd_goaltimes = []
    run_goaltimes = []

    a1 = avgLaps.shift
    avgLaps.insert(0, a1 + 0.01)
    f1 = fstLaps.shift
    fstLaps.insert(0, f1 + 0.01)
    if prdLaps.all?
      p1 = prdLaps.shift
      prdLaps.insert(0, p1 + 0.01)
    end
    if runLaps.all?
      r1 = runLaps.shift
      runLaps.insert(0, r1 + 0.01)
    end
    handicaps.zip(avgLaps, fstLaps, prdLaps, runLaps) do |hand, avgLap, fstLap, prdLap, runLap|
      avg_goaltimes << avgLap * (31.0 + hand.to_f/100)
      fst_goaltimes << fstLap * (31.0 + hand.to_f/100)
      prd_goaltimes << prdLap.to_f * (31.0 + hand.to_f/100) # nil -> 0.0
      run_goaltimes << runLap.to_f * (31.0 + hand.to_f/100) # nil -> 0.0
    end

    # degree = -36
    # dif = 7.2 # 10m
    # x, y =  168.0, 345.5 # -36d. 0 han
    # 50.times do |n|
    #   degree += dif
    #   rad = degree * Math::PI/180
    #   x += 4.5 * dif * Math.cos(-rad)
    #   y += 2.3 * dif * Math.sin(-rad)
    #   if n > 40
    #     print("#{(49-n)*10} => [#{x.round(1)}, #{y.round(1)}],\n")
    #   end
    # end
    start_positions =
      {
        80 => [48.2, 234.2],
        70 => [50.3, 250.7],
        60 => [56.3, 267.0],
        50 => [66.4, 282.7],
        40 => [80.2, 297.7],
        30 => [97.5, 311.7],
        20 => [118.2, 324.4],
        10 => [141.8, 335.8],
        0 => [168.0, 345.5]
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
    fstGoals = goal_positions(fst_goaltimes, 25.0)
    prdGoals = goal_positions(prd_goaltimes, 50.0)
    runGoals = goal_positions(run_goaltimes, 75.0)
    
    # set racers
    @racers = []
    pieces.zip(names, handicaps, avgLaps, prdLaps, runLaps, avgGoals, fstGoals, prdGoals, runGoals) do 
      |piece, name, hand, avglap, prdlap, runlap, avg, fst, prd, run|
      racer = Racer.new
      racer.piece = Gosu::Image.new(piece)
      racer.name = name
      racer.handicap = hand
      racer.degree = -36.0 - (7.2 * hand.to_f/10)
      racer.avg_dif = 1.2 / avglap
      racer.prd_dif = 1.2 / prdlap.to_f
      racer.run_dif = 1.2 / runlap.to_f
      racer.x, racer.y = start_positions[hand]
      racer.avg_goalx, racer.avg_goaly = avg
      racer.fst_goalx, racer.fst_goaly = fst
      racer.prd_goalx, racer.prd_goaly = prd
      racer.run_goalx, racer.run_goaly = run
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
            racer.piece.draw(racer.fst_goalx, racer.fst_goaly)
            if @case_of_lap == 'prd_dif'
              racer.piece.draw(racer.prd_goalx, racer.prd_goaly)
            end
            if @case_of_lap == 'run_dif'
              racer.piece.draw(racer.prd_goalx, racer.prd_goaly)
              racer.piece.draw(racer.run_goalx, racer.run_goaly)
            end
        end
      end
    end
    # @purple.draw(320, 240, 1)
  end

end

# r = Racers.new
# r.test