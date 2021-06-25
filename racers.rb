require 'gosu'
require './readjson.rb'

class Racer

  attr_accessor :color
  attr_accessor :handicap
  attr_accessor :degree, :d
  attr_accessor :x, :y
  attr_accessor :avg_goalx, :avg_goaly
  attr_accessor :max_goalx, :max_goaly
  attr_accessor :prd_goalx, :prd_goaly

end


class Racers
	
	def initialize

    $handicaps = RaceFile.handicaps
    $avgLaps = RaceFile.avgtimes
    $maxLaps = RaceFile.maxtimes
    $prdLaps = RaceFile.prdtimes
    $racetitle = RaceFile.racetitle

    # $racer_data = []
    $racer_colors = []
    $avg_goaltimes = []
    $max_goaltimes = []
    $prd_goaltimes = []
    n = 0
    $handicaps.zip($avgLaps, $maxLaps, $prdLaps) do |hand, avgLap, maxLap, prdLap|
      # $racer_data << [handi, avgLap, maxLap, prdLap]
      n += 1
      color = './colors/racer_' + n.to_s + '.png'
      $racer_colors << color

      avg_goaltime = (31 + hand.to_f/100) * avgLap
      $avg_goaltimes << avg_goaltime

      max_goaltime = (31 + hand.to_f/100) * maxLap
      $max_goaltimes << max_goaltime

      prd_goaltime = (31 + hand.to_f/100) * prdLap
      $prd_goaltimes << prd_goaltime

    end

    def self.goal_positions(goaltimes, pos_y)

      $top_time = goaltimes.min
      $mps = 0.034 # 3.4sec / 100m
      $goal_x, $goal_y =  470.0, 345.0
      
      $positions = []
      # $goal_diffs = []
      goaltimes.each do |goal_time|
        time_diff = goal_time - $top_time
        m_diff = 3 * time_diff / $mps
        # $goal_diffs << m_diff
        $positions << [$goal_x + 50 - m_diff, $goal_y + 25 + pos_y]
      end
      return $positions
    end

    $avgGoals = goal_positions($avg_goaltimes, 0)
    $maxGoals = goal_positions($max_goaltimes, 25)
    $prdGoals = goal_positions($prd_goaltimes, 50)

    $start_positions =
      {
        0 => [168.0, 345.5],
        10 => [143.6, 335.4],
        20 => [121.7, 323.8],
        30 => [100.3, 309.0],
        40 => [85.0, 295.0],
        50 => [73.2, 280.0]
      }

    # set racers
    @racers = []
    # $goal_times = []
    $racer_colors.zip($handicaps, $avgLaps, $avgGoals, $maxGoals, $prdGoals) do |color, hand, lap, avg, max, prd|
      racer = Racer.new
      racer.color = Gosu::Image.new(color)
      racer.handicap = hand
      # racer.racetime = lap
      racer.degree = -36 - (7.2 * hand.to_f/10)
      racer.d = 1.2 * 1 / lap
      racer.x, racer.y = $start_positions[hand]
      racer.avg_goalx, racer.avg_goaly = avg
      racer.max_goalx, racer.max_goaly = max
      racer.prd_goalx, racer.prd_goaly = prd
      @racers << racer

    end

    @purple = Gosu::Image.new('./colors/racer_0.png')

	end

  def update(ff)
    @racers.each do |racer|
      racer.degree += (racer.d * ff)
      rad = racer.degree * Math::PI/180
      racer.x += 4.5 * (racer.d * ff) * Math.cos(-rad)
      racer.y += 2.3 * (racer.d * ff) * Math.sin(-rad)
    end

  end

  def draw
    @racers.each do |racer|
      if racer.degree < 360 * 6 + 36
        then racer.color.draw(racer.x, racer.y, 1)
        else 
          racer.color.draw(racer.avg_goalx, racer.avg_goaly)
          racer.color.draw(racer.max_goalx, racer.max_goaly)
          racer.color.draw(racer.prd_goalx, racer.prd_goaly)
      end
    end
    # @purple.draw(320, 240, 1)
  end

  def test
  end

end

r = Racers.new
r.test