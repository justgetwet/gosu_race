require 'gosu'
require './readjson.rb'

class Racer

  attr_accessor :color
  attr_accessor :handicap, :racetime
  attr_accessor :start_x, :start_y

  # def initialize
  #   @handicap = 0
  #   @racetime = 0
  # end
  
end


class Racers
	
	def initialize

    $handicaps = RaceFile.handicaps
    $racetimes = RaceFile.prdtimes
    $goaldiffs = RaceFile.prddiffs
    $racetitle = RaceFile.racetitle

    $racer_data = []
    $handicaps.zip($racetimes) do |hand, time|
      $racer_data << [hand, time]
    end

    $start_potisons =
      {
        0 => [168.0, 345.5],
        10 => [143.6, 335.4],
        20 => [121.7, 323.8],
        30 => [100.3, 309.0],
        40 => [85.0, 295.0],
        50 => [73.2, 280.0]
      }

		@purple = Gosu::Image.new('./colors/racer_0.png')

    $fast_foward = 1

    @racers = []
    $racer_data.each do |data|
      racer = Racer.new
      hand = data[0]
      time = data[1]
      start_x, start_y = $start_potisons[hand]
      racer.handicap = data[0]
      racer.racetime = data[1]
      @racers << racer
    end

    # white_handi = $racers[0][0]
    # p white_handi
    # white_lap100m = $racers[0][1]
    # @white_t = 1.2 * $fast_foward / white_lap100m
    # @white_tick = -36 - 7.2 * (white_handi/10)
    # @white_x, @white_y = start_potisons[white_handi]

	end

  def test
    p @racers[0]
  end

  def update

  end

  def draw

  end

end

r = Racers.new
r.test