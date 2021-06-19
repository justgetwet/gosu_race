require 'gosu'
require './player.rb'

module RaceData

  def racers
    # color => [handicap, lap]
    {
      'white' => [0, 3.83],
      'black' => [0, 3.80],
      'red' => [10, 3.80],
      'blue' => [20, 3.77],
      'yellow' => [20, 3.82],
      'green' => [30, 3.80],
      'orange' => [40, 3.79],
      'pink' => [40, 3.77]
    }

  end

  def handicap
    {
      0 => [168.0, 345.5],
      10 => [143.6, 335.4],
      20 => [121.7, 323.8],
      30 => [100.3, 309.0],
      40 => [85.0, 295.0],
      50 => [73.2, 280.0]
    }
  end

  def theoretical_time
    {
      'white' => racers['white'][1] * (racers['white'][0]/10 + 31),
      'black' => racers['black'][1] * (racers['black'][0]/10 + 31),
      'red' => racers['red'][1] * (racers['red'][0]/10 + 31),
      'blue' => racers['blue'][1] * (racers['blue'][0]/10 + 31),
      'yellow' => racers['yellow'][1] * (racers['yellow'][0]/10 + 31),
      'green' => racers['green'][1] * (racers['green'][0]/10 + 31),
      'orange' => racers['orange'][1] * (racers['orange'][0]/10 + 31),
      'pink' => racers['pink'][1] * (racers['pink'][0]/10 + 31)
    }
  end

  def goal_order
    theoretical_time.sort_by { |_, v| v }
  end

  def goal_postion
    goal_pos = {}
    val = 0
    goal_order.reverse.each do |e|
      val += 10
      goal_pos[e[0]] = val
    end
    return goal_pos
  end

  def fastest_tick 
    # 最速time x 60 = 最速tick
    goal_order[0][1] * 60
  end

  def fastest_tick_lap
    # 周回の掲示用
    (fastest_tick / 6).round(0)
  end

end

class MyGame < Gosu::Window
  
  include RaceData

  def initialize
    @width = 640
    @height = 480
    super @width,@height,false
    @background = Gosu::Image.new('course.png')

    @time = 0

    @purple = Gosu::Image.new('racer_0.png')

    @white = Gosu::Image.new('racer_1.png')
    @black = Gosu::Image.new('racer_2.png')
    @red = Gosu::Image.new('racer_3.png')
    @blue = Gosu::Image.new('racer_4.png')
    @yellow = Gosu::Image.new('racer_5.png')
    @green = Gosu::Image.new('racer_6.png')
    @orange = Gosu::Image.new('racer_7.png')
    @pink = Gosu::Image.new('racer_8.png')

    @lap_count = 0
    @lap = 6
    @lap_draw = 0

    # @s0m_x, @s0m_y = 168.0, 345.5
    # @s10m_x, @s10m_y = 143.6, 335.4 # tick: 317.0
    # @s20m_x, @s20m_y = 121.7, 323.8 # tick: 310.0
    # @s30m_x, @s30m_y = 100.3, 309.0 # tick: 302.0
    # @s40m_x, @s40m_y = 85.0, 295.0 # tick: 295.0
    # @s50m_x, @s50m_y = 73.2, 280.0 # tick: 288.0

    # @zero_x, @zero_y = 320, 370
    @goal_x, @goal_y = 471.1, 344.1

    purple_lap100m = 1.2
    @t = 1.2 / purple_lap100m
    @tick = 0
    @x, @y = 320, 370

    white_handi = racers['white'][0]
    white_lap100m = racers['white'][1]
    @white_t = 1.2 / white_lap100m
    @white_tick = -36 - 7.2 * (white_handi/10)
    @white_x, @white_y = handicap[white_handi]

    black_handi = racers['black'][0]
    black_lap100m = racers['black'][1]
    @black_t = 1.2 / black_lap100m
    @black_tick = -36 - 7.2 * (black_handi/10)
    @black_x, @black_y = handicap[black_handi]

    red_handi = racers['red'][0]
    red_lap100m = racers['red'][1]
    @red_t = 1.2 / red_lap100m
    @red_tick = -36 - 7.2 * (red_handi/10)
    @red_x, @red_y = handicap[red_handi]

    blue_handi = racers['blue'][0]
    blue_lap100m = racers['blue'][1]
    @blue_t = 1.2 / blue_lap100m
    @blue_tick = -36 - 7.2 * (blue_handi/10)
    @blue_x, @blue_y = handicap[blue_handi]

    yellow_handi = racers['yellow'][0]
    yellow_lap100m = racers['yellow'][1]
    @yellow_t = 1.2 / yellow_lap100m
    @yellow_tick = -36 - 7.2 * (yellow_handi/10)
    @yellow_x, @yellow_y = handicap[yellow_handi]

    green_handi = racers['green'][0]
    green_lap100m = racers['green'][1]
    @green_t = 1.2 / green_lap100m
    @green_tick = -36 - 7.2 * (green_handi/10)
    @green_x, @green_y = handicap[green_handi]

    orange_handi = racers['orange'][0]
    orange_lap100m = racers['orange'][1]
    @orange_t = 1.2 / orange_lap100m
    @orange_tick = -36 - 7.2 * (orange_handi/10)
    @orange_x, @orange_y = handicap[orange_handi]

    pink_handi = racers['pink'][0]
    pink_lap100m = racers['pink'][1]
    @pink_t = 1.2 / orange_lap100m
    @pink_tick = -36 - 7.2 * (pink_handi/10)
    @pink_x, @pink_y = handicap[pink_handi]

    @buttons_down = 0
    @text = Gosu::Font.new(self, Gosu::default_font_name, 20)
  end

  def update

    if @buttons_down == 1 then

      @tick += 1
      @time = Gosu.milliseconds * 1/1000
      # @tick += @t
      # angle = @tick * Math::PI / 180
      # @x += 4.5 * @t * Math.cos(-angle)
      # @y += 2.3 * @t * Math.sin(-angle)

      @white_tick += @white_t
      angle = @white_tick * Math::PI / 180
      @white_x += 4.5 * @white_t * Math.cos(-angle)
      @white_y += 2.3 * @white_t * Math.sin(-angle)

      @black_tick += @black_t
      angle = @black_tick * Math::PI / 180
      @black_x += 4.5 * @black_t * Math.cos(-angle)
      @black_y += 2.3 * @black_t * Math.sin(-angle)

      @red_tick += @red_t
      angle = @red_tick * Math::PI / 180
      @red_x += 4.5 * @red_t * Math.cos(-angle)
      @red_y += 2.3 * @red_t * Math.sin(-angle)

      @blue_tick += @blue_t
      angle = @blue_tick * Math::PI / 180
      @blue_x += 4.5 * @blue_t * Math.cos(-angle)
      @blue_y += 2.3 * @blue_t * Math.sin(-angle)

      @yellow_tick += @yellow_t
      angle = @yellow_tick * Math::PI / 180
      @yellow_x += 4.5 * @yellow_t * Math.cos(-angle)
      @yellow_y += 2.3 * @yellow_t * Math.sin(-angle)

      @green_tick += @green_t
      angle = @green_tick * Math::PI / 180
      @green_x += 4.5 * @green_t * Math.cos(-angle)
      @green_y += 2.3 * @green_t * Math.sin(-angle)

      @orange_tick += @orange_t
      angle = @orange_tick * Math::PI / 180
      @orange_x += 4.5 * @orange_t * Math.cos(-angle)
      @orange_y += 2.3 * @orange_t * Math.sin(-angle)

      @pink_tick += @pink_t
      angle = @pink_tick * Math::PI / 180
      @pink_x += 4.5 * @pink_t * Math.cos(-angle)
      @pink_y += 2.3 * @pink_t * Math.sin(-angle)

    end


  end

  def draw
    @background.draw(0,0,0)

    # if @tick < 360 * @lap + 36
    #   then @purple.draw(@x, @y, 1)
    #   else @purple.draw(@goal_x, @goal_y, 1)
    # end

    if @white_tick < 360 * @lap + 36
      then @white.draw(@white_x, @white_y, 1)
      else @white.draw(@goal_x+goal_postion['white'], @goal_y, 1)
    end

    if @black_tick < 360 * @lap + 36
      then @black.draw(@black_x, @black_y, 1)
      else @black.draw(@goal_x+goal_postion['black'], @goal_y, 1)
    end

    if @red_tick < 360 * @lap + 36
      then @red.draw(@red_x, @red_y, 1)
      else @red.draw(@goal_x+goal_postion['red'], @goal_y, 1)
    end

    if @blue_tick < 360 * @lap + 36
      then @blue.draw(@blue_x, @blue_y, 1)
      else @blue.draw(@goal_x+goal_postion['blue'], @goal_y, 1)
    end

    if @yellow_tick < 360 * @lap + 36
      then @yellow.draw(@yellow_x, @yellow_y, 1)
      else @yellow.draw(@goal_x+goal_postion['yellow'], @goal_y, 1)
    end

    if @green_tick < 360 * @lap + 36
      then @green.draw(@green_x, @green_y, 1)
      else @green.draw(@goal_x+goal_postion['green'], @goal_y, 1)
    end

    if @orange_tick < 360 * @lap + 36
      then @orange.draw(@orange_x, @orange_y, 1)
      else @orange.draw(@goal_x+goal_postion['orange'], @goal_y, 1)
    end

    if @pink_tick < 360 * @lap + 36
      then @pink.draw(@pink_x, @pink_y, 1)
      else @pink.draw(@goal_x+goal_postion['pink'], @goal_y, 1)
    end

    # if 360 + 36 - 0.1 < @tick and @tick < 360 + 36 + 0.1 then p @x, @y, @tick end
    # if 360 - 36 - (7.2*6) - 0.5 < @tick and @tick < 360 - 36 - (7.2*6) + 0.5 then p @x, @y, @tick end
    # if @w_tick < 360 * @lap
    #   then @white.draw(@w_x, @w_y, 1)
    #   else @white.draw(330, 365, 1)
    # end
    
    # if 299.8 < @p_tick and @p_tick < 300.0 then p @p_x, @p_y, @p_tick end

    @text.draw_text(@time, 450, 10, 1, 1.5, 1.5, Gosu::Color::RED)

    if @tick == 1 or (@tick+1) % fastest_tick_lap == 0 then @lap_count += 1 end
    @text.draw_text(@lap_count, 450, 50, 1, 1.5, 1.5, Gosu::Color::BLUE)

  end

  def move
    if ((Gosu.milliseconds/1000) % 2) < 100 then @x+=5 end
  end

  def button_down(id)
    # move if id == Gosu::KbReturn
    close if id ==Gosu::KbEscape
    @buttons_down += 1
  end

  # def button_up(id)
  #   @buttons_down -= 1
  # end

end

window = MyGame.new
window.show