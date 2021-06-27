require 'gosu'
require './readjson.rb'
require './panels.rb'

module RaceData

  $handicaps = RaceFile.handicaps
  $racetimes = RaceFile.prdtimes
  $goaldiffs = RaceFile.prddiffs
  $racetitle = RaceFile.racetitle

  def racers
    # color => [handicap, lap]
    {
      'white' => [$handicaps[0], $racetimes[0]],
      'black' => [$handicaps[1], $racetimes[1]],
      'red' => [$handicaps[2], $racetimes[2]],
      'blue' => [$handicaps[3], $racetimes[3]],
      'yellow' => [$handicaps[4], $racetimes[4]],
      'green' => [$handicaps[5], $racetimes[5]],
      'orange' => [$handicaps[6], $racetimes[6]],
      'pink' => [$handicaps[7], $racetimes[7]],
    }

  end

  def handicap # potision
    {
      0 => [168.0, 345.5],
      10 => [143.6, 335.4],
      20 => [121.7, 323.8],
      30 => [100.3, 309.0],
      40 => [85.0, 295.0],
      50 => [73.2, 280.0]
    }
  end

end

class MyGame < Gosu::Window
  
  include RaceData

  def initialize

    @width = 640
    @height = 480
    super @width,@height,false
    self.caption = $racetitle
    @background = Gosu::Image.new('course.png')

    @racer = Panels.new

    @time = 0

    @purple = Gosu::Image.new('./colors/racer_0.png')

    @white = Gosu::Image.new('./colors/racer_1.png')
    @black = Gosu::Image.new('./colors/racer_2.png')
    @red = Gosu::Image.new('./colors/racer_3.png')
    @blue = Gosu::Image.new('./colors/racer_4.png')
    @yellow = Gosu::Image.new('./colors/racer_5.png')
    @green = Gosu::Image.new('./colors/racer_6.png')
    @orange = Gosu::Image.new('./colors/racer_7.png')
    @pink = Gosu::Image.new('./colors/racer_8.png')

    @white_goal = $goaldiffs[0].round(0)
    @black_goal = $goaldiffs[1].round(0)
    @red_goal = $goaldiffs[2].round(0)
    @blue_goal = $goaldiffs[3].round(0)
    @yellow_goal = $goaldiffs[4].round(0)
    @green_goal = $goaldiffs[5].round(0)
    @orange_goal = $goaldiffs[6].round(0)
    @pink_goal = $goaldiffs[7].round(0)

    @lap_count = 0
    @lap = 6
    @fast_foward = 2

    # @zero_x, @zero_y = 320, 370
    @goal_x, @goal_y = 471.1, 344.1



    purple_lap100m = 1.2
    @t = 1.2 / purple_lap100m
    @tick = 0

    @x, @y = 320, 370

    white_handi = racers['white'][0]
    white_lap100m = racers['white'][1]
    @white_t = 1.2 * @fast_foward / white_lap100m
    @white_tick = -36 - 7.2 * (white_handi/10)
    @white_x, @white_y = handicap[white_handi]

    black_handi = racers['black'][0]
    black_lap100m = racers['black'][1]
    @black_t = 1.2 * @fast_foward / black_lap100m
    @black_tick = -36 - 7.2 * (black_handi/10)
    @black_x, @black_y = handicap[black_handi]

    red_handi = racers['red'][0]
    red_lap100m = racers['red'][1]
    @red_t = 1.2 * @fast_foward / red_lap100m
    @red_tick = -36 - 7.2 * (red_handi/10)
    @red_x, @red_y = handicap[red_handi]

    blue_handi = racers['blue'][0]
    blue_lap100m = racers['blue'][1]
    @blue_t = 1.2 * @fast_foward / blue_lap100m
    @blue_tick = -36 - 7.2 * (blue_handi/10)
    @blue_x, @blue_y = handicap[blue_handi]

    yellow_handi = racers['yellow'][0]
    yellow_lap100m = racers['yellow'][1]
    @yellow_t = 1.2 * @fast_foward / yellow_lap100m
    @yellow_tick = -36 - 7.2 * (yellow_handi/10)
    @yellow_x, @yellow_y = handicap[yellow_handi]

    green_handi = racers['green'][0]
    green_lap100m = racers['green'][1]
    @green_t = 1.2 * @fast_foward / green_lap100m
    @green_tick = -36 - 7.2 * (green_handi/10)
    @green_x, @green_y = handicap[green_handi]

    orange_handi = racers['orange'][0]
    orange_lap100m = racers['orange'][1]
    @orange_t = 1.2 * @fast_foward / orange_lap100m
    @orange_tick = -36 - 7.2 * (orange_handi/10)
    @orange_x, @orange_y = handicap[orange_handi]

    pink_handi = racers['pink'][0]
    pink_lap100m = racers['pink'][1]
    @pink_t = 1.2 * @fast_foward / orange_lap100m
    @pink_tick = -36 - 7.2 * (pink_handi/10)
    @pink_x, @pink_y = handicap[pink_handi]

    @buttons_down = 0
    # font = 'C:\Users\frog7\AppData\Local\Microsoft\Windows\Fonts\NotoSansJP-Regular.otf'
    # @text = Gosu::Font.new(20, :name => font)
    @text = Gosu::Font.new(self, Gosu::default_font_name, 20)

  end

  def update

    if @buttons_down == 1 then

      @tick += 1
      @time = Gosu.milliseconds * 1/1000 * @fast_foward
      # @tick += @t
      # rad = @tick * Math::PI / 180
      # @x += 4.5 * @t * Math.cos(-rad)
      # @y += 2.3 * @t * Math.sin(-rad)

      @white_tick += @white_t
      rad = @white_tick * Math::PI / 180
      @white_x += 4.5 * @white_t * Math.cos(-rad)
      @white_y += 2.3 * @white_t * Math.sin(-rad)

      @black_tick += @black_t
      rad = @black_tick * Math::PI / 180
      @black_x += 4.5 * @black_t * Math.cos(-rad)
      @black_y += 2.3 * @black_t * Math.sin(-rad)

      @red_tick += @red_t
      rad = @red_tick * Math::PI / 180
      @red_x += 4.5 * @red_t * Math.cos(-rad)
      @red_y += 2.3 * @red_t * Math.sin(-rad)

      @blue_tick += @blue_t
      rad = @blue_tick * Math::PI / 180
      @blue_x += 4.5 * @blue_t * Math.cos(-rad)
      @blue_y += 2.3 * @blue_t * Math.sin(-rad)

      @yellow_tick += @yellow_t
      rad = @yellow_tick * Math::PI / 180
      @yellow_x += 4.5 * @yellow_t * Math.cos(-rad)
      @yellow_y += 2.3 * @yellow_t * Math.sin(-rad)

      @green_tick += @green_t
      rad = @green_tick * Math::PI / 180
      @green_x += 4.5 * @green_t * Math.cos(-rad)
      @green_y += 2.3 * @green_t * Math.sin(-rad)

      @orange_tick += @orange_t
      rad = @orange_tick * Math::PI / 180
      @orange_x += 4.5 * @orange_t * Math.cos(-rad)
      @orange_y += 2.3 * @orange_t * Math.sin(-rad)

      @pink_tick += @pink_t
      rad = @pink_tick * Math::PI / 180
      @pink_x += 4.5 * @pink_t * Math.cos(-rad)
      @pink_y += 2.3 * @pink_t * Math.sin(-rad)

    end


  end

  def draw
    @background.draw(0,0,0)
    @racer.draw

    if @white_tick < 360 * @lap + 36
      then @white.draw(@white_x, @white_y, 1)
      else @white.draw(@goal_x - @white_goal, @goal_y + 10, 1)
      # else unless $flag
      #   $goal_time = @time.clone
      #   $flag = true
      # end
    end
    # @text.draw_text($goal_time, 300, 300, 1, 1, 1, Gosu::Color::RED)


    if @black_tick < 360 * @lap + 36
      then @black.draw(@black_x, @black_y, 1)
      else @black.draw(@goal_x - @black_goal, @goal_y + 10, 1)
    end

    if @red_tick < 360 * @lap + 36
      then @red.draw(@red_x, @red_y, 1)
      else @red.draw(@goal_x - @red_goal, @goal_y + 10, 1)
    end

    if @blue_tick < 360 * @lap + 36
      then @blue.draw(@blue_x, @blue_y, 1)
      else @blue.draw(@goal_x - @blue_goal, @goal_y + 10, 1)
    end

    if @yellow_tick < 360 * @lap + 36
      then @yellow.draw(@yellow_x, @yellow_y, 1)
      else @yellow.draw(@goal_x - @yellow_goal, @goal_y + 10, 1)
    end

    if @green_tick < 360 * @lap + 36
      then @green.draw(@green_x, @green_y, 1)
      else @green.draw(@goal_x - @green_goal, @goal_y + 10, 1)
    end

    if @orange_tick < 360 * @lap + 36
      then @orange.draw(@orange_x, @orange_y, 1)
      else @orange.draw(@goal_x - @orange_goal, @goal_y + 10, 1)
    end

    if @pink_tick < 360 * @lap + 36
      then @pink.draw(@pink_x, @pink_y, 1)
      else @pink.draw(@goal_x - @pink_goal, @goal_y + 10, 1)
    end

    # if 360 + 36 - 0.1 < @tick and @tick < 360 + 36 + 0.1 then p @x, @y, @tick end
    # if 360 - 36 - (7.2*6) - 0.5 < @tick and @tick < 360 - 36 - (7.2*6) + 0.5 then p @x, @y, @tick end
    # if @w_tick < 360 * @lap
    #   then @white.draw(@w_x, @w_y, 1)
    #   else @white.draw(330, 365, 1)
    # end
    
    # if 299.8 < @p_tick and @p_tick < 300.0 then p @p_x, @p_y, @p_tick end

    @text.draw_text(@time, 50, 350, 1, 1.5, 1.5, Gosu::Color::RED)
    fastest_tick_lap = 1000
    if @tick == 1 or (@tick+1) % fastest_tick_lap == 0 then @lap_count += 1 end
    @text.draw_text(@lap_count, 50, 400, 1, 1.5, 1.5, Gosu::Color::BLUE)

  end

  def move
    if ((Gosu.milliseconds/1000) % 2) < 100 then @x+=5 end
  end

  def button_down(id)
    # move if id == Gosu::KbReturn
    close if id == Gosu::KbEscape
    @buttons_down += 1
  end

  # def button_up(id)
  #   @buttons_down -= 1
  # end

end

window = MyGame.new
window.show