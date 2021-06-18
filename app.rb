require 'gosu'
require './player.rb'

class MyGame < Gosu::Window
   
  # コンストラクタ
  def initialize
    @width = 640
    @height = 480
    super @width,@height,false
    @background = Gosu::Image.new('course.png')

    @purple = Gosu::Image.new('racer_0.png')

    @white = Gosu::Image.new('racer_1.png')
    @black = Gosu::Image.new('racer_2.png')
    @red = Gosu::Image.new('racer_3.png')
    @blue = Gosu::Image.new('racer_4.png')
    @yellow = Gosu::Image.new('racer_5.png')
    @green = Gosu::Image.new('racer_6.png')
    @orange = Gosu::Image.new('racer_7.png')
    @pink = Gosu::Image.new('racer_8.png')

    @sec = 0
    @lap = 3
    @lap_draw = 0

    @s0m_x, @s0m_y = 168.0, 345.5
    @s10m_x, @s10m_y = 143.6, 335.4 # tick: 317.0
    @s20m_x, @s20m_y = 121.7, 323.8 # tick: 310.0
    @s30m_x, @s30m_y = 100.3, 309.0 # tick: 302.0
    @s40m_x, @s40m_y = 85.0, 295.0 # tick: 295.0
    @s50m_x, @s50m_y = 73.2, 280.0 # tick: 288.0

    @goal_x, @goal_y = 471.1, 344.1

    purple_lap100m = 1.2
    @t = 1.2 / purple_lap100m
    @tick = 0
    @x, @y = 320, 370

    white_lap100m = 3.6
    @white_t = 1.2 / white_lap100m
    @white_tick = -36 # 7.2*5
    @white_x, @white_y = @s0m_x, @s0m_y

    black_lap100m = 3.5
    @black_t = 1.2 / black_lap100m
    @black_tick = -36
    @black_x, @black_y = @s0m_x, @s0m_y

    red_lap100m = 3.4
    @red_t = 1.2 / red_lap100m
    @red_tick = -36 - (7.2*1)
    @red_x, @red_y = @s10m_x, @s10m_y

    blue_lap100m = 3.3
    @blue_t = 1.2 / blue_lap100m
    @blue_tick = -36 - (7.2*1)
    @blue_x, @blue_y = @s10m_x, @s10m_y

    blue_lap100m = 3.3
    @blue_t = 1.2 / blue_lap100m
    @blue_tick = -36 - (7.2*2)
    @blue_x, @blue_y = @s20m_x, @s20m_y

    yellow_lap100m = 3.2
    @yellow_t = 1.2 / yellow_lap100m
    @yellow_tick = -36 - (7.2*2)
    @yellow_x, @yellow_y = @s20m_x, @s20m_y

    green_lap100m = 3.2
    @green_t = 1.2 / green_lap100m
    @green_tick = -36 - (7.2*3)
    @green_x, @green_y = @s30m_x, @s30m_y

    orange_lap100m = 3.2
    @orange_t = 1.2 / orange_lap100m
    @orange_tick = -36 - (7.2*3)
    @orange_x, @orange_y = @s30m_x, @s30m_y

    pink_lap100m = 3.1
    @pink_t = 1.2 / orange_lap100m
    @pink_tick = -36 - (7.2*4)
    @pink_x, @pink_y = @s40m_x, @s40m_y

    @buttons_down = 0
    @text = Gosu::Font.new(self, Gosu::default_font_name, 20)
  end

  def update
    @time = Gosu.milliseconds * 1/1000

    if @buttons_down == 1 then

      @tick += @t
      angle = @tick * Math::PI / 180
      @x += 4.5 * @t * Math.cos(-angle)
      @y += 2.3 * @t * Math.sin(-angle)

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

    if @tick < 360 * @lap + 36
      then @purple.draw(@x, @y, 1)
      else @purple.draw(@goal_x, @goal_y, 1)
    end

    if @white_tick < 360 * @lap + 36
      then @white.draw(@white_x, @white_y, 1)
      else @white.draw(@goal_x+5, @goal_y+10, 1)
    end

    if @black_tick < 360 * @lap + 36
      then @black.draw(@black_x, @black_y, 1)
      else @black.draw(@goal_x+10, @goal_y+15, 1)
    end

    if @red_tick < 360 * @lap + 36
      then @red.draw(@red_x, @red_y, 1)
      else @red.draw(@goal_x+15, @goal_y+20, 1)
    end

    if @blue_tick < 360 * @lap + 36
      then @blue.draw(@blue_x, @blue_y, 1)
      else @blue.draw(@goal_x+20, @goal_y+25, 1)
    end

    if @yellow_tick < 360 * @lap + 36
      then @yellow.draw(@yellow_x, @yellow_y, 1)
      else @yellow.draw(@goal_x+25, @goal_y+30, 1)
    end

    if @green_tick < 360 * @lap + 36
      then @green.draw(@green_x, @green_y, 1)
      else @green.draw(@goal_x+30, @goal_y+35, 1)
    end

    if @orange_tick < 360 * @lap + 36
      then @orange.draw(@orange_x, @orange_y, 1)
      else @orange.draw(@goal_x+25, @goal_y+30, 1)
    end

    if @pink_tick < 360 * @lap + 36
      then @pink.draw(@pink_x, @pink_y, 1)
      else @pink.draw(@goal_x+30, @goal_y+35, 1)
    end

    # if 360 + 36 - 0.1 < @tick and @tick < 360 + 36 + 0.1 then p @x, @y, @tick end
    if 360 - 36 - (7.2*6) - 0.5 < @tick and @tick < 360 - 36 - (7.2*6) + 0.5 then p @x, @y, @tick end
    # if @w_tick < 360 * @lap
    #   then @white.draw(@w_x, @w_y, 1)
    #   else @white.draw(330, 365, 1)
    # end
    
    # if 299.8 < @p_tick and @p_tick < 300.0 then p @p_x, @p_y, @p_tick end
    
    #   @green.draw(320, 380, 0)

    # if @p_tick < 360 * @lap
    #   then @pink.draw(@p_x, @p_y, 0) 
    #   else @pink.draw(330, 360, 0) 
    # end

    @text.draw(@time, 450, 90, 1, 1.5, 1.5, Gosu::Color::RED)
    if @white_tick % 60 == 0 then @sec += 1 end
    @text.draw(@sec, 450, 50, 1, 1.5, 1.5, Gosu::Color::BLUE)
    if @white_tick % 360 == 0 and @tick < 360 * @lap then @lap_draw += 1 end
    @text.draw(@lap_draw, 450, 10, 1, 1.5, 1.5, Gosu::Color::YELLOW)
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