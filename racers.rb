require 'gosu'
require './readjson.rb'

class Racer

  attr_accessor :color
  attr_accessor :handicap, :racetime
  attr_accessor :degree, :d
  attr_accessor :x, :y
  attr_accessor :goal_x, :goal_y

end


class Racers
	
	def initialize

    $handicaps = RaceFile.handicaps
    $avgtimes = RaceFile.avgtimes
    $maxtimes = RaceFile.maxtimes
    $prdtimes = RaceFile.prdtimes
    $racetitle = RaceFile.racetitle

    $racer_data = []
    $racer_colors = []
    $goal_times = []
    $max_goal_times = []
    $prd_goal_times = []
    n = 0
    avgs, maxs, prds = $avgtimes, $maxtimes, $prdtimes
    $handicaps.zip(avgs, maxs, prds) do |handi, avgLap, maxLap, prdLap|
      $racer_data << [handi, avgLap, maxLap, prdLap]
      n += 1
      color = './colors/racer_' + n.to_s + '.png'
      $racer_colors << color

      goal_time = (31 + handi.to_f/100) * avgLap
      $goal_times << goal_time

      max_goal_time = (31 + handi.to_f/100) * maxLap
      $max_goal_times << goal_time

      prd_goal_time = (31 + handi.to_f/100) * prdLap
      $prd_goal_times << goal_time

    end

    $top_time = $goal_times.min
    $goal_positions = []
    $goal_diffs = []
    $mps = 0.034
    $goal_x, $goal_y =  470.0, 345.0
    $goal_times.each do |goal_time|
      time_diff = goal_time - $top_time
      m_diff = 2 * time_diff / $mps
      $goal_diffs << m_diff
      $goal_positions << [$goal_x + 50 - m_diff, $goal_y + 50]
    end
    p $goal_diffs

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
    $goal_times = []
    $racer_colors.zip($racer_data, $goal_positions) do |color, data, goal|
      racer = Racer.new
      racer.color = Gosu::Image.new(color)
      handi = data[0]
      lap100 = data[1]
      racer.handicap = handi
      racer.racetime = lap100
      racer.degree = -36 - (7.2 * handi.to_f/10)
      racer.d = 1.2 * 1 / lap100
      racer.x, racer.y = $start_positions[handi]
      racer.goal_x, racer.goal_y = goal
      @racers << racer

    end

    @purple = Gosu::Image.new('./colors/racer_0.png')

	end

  def spm_goal_positions

  end

  def avg_goal_positions

  end

  def max_goal_positions

  end

  def prd_goal_positions

  end

  def rlt_goal_positions

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
        else racer.color.draw(racer.goal_x, racer.goal_y)
      end
    end
    # @purple.draw(320, 240, 1)
  end

  def test
  end

end

r = Racers.new
r.test