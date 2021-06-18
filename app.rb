require 'gosu'
require './player.rb'

class MyGame < Gosu::Window
   
  # コンストラクタ
  def initialize
    @width = 640
    @height = 480
    super @width,@height,false
    @background = Gosu::Image.new('course.png')

    @sec = 0
    @lap = 3
    @lap_draw = 0

    lap100m = 3.3
    # @t = 1.2 / lap100m
    @t = 1
    @tick = -36
    @x = 168.0 # 320
    @y = 345.5 # 370

    @white = Gosu::Image.new('racer_1.png')
    @w_x = 320
    @w_y = 360
    @w_tick = 0

    @black = Gosu::Image.new('racer_2.png')
    @red = Gosu::Image.new('racer_3.png')
    @blue = Gosu::Image.new('racer_4.png')
    # @yellow = Gosu::Image.new('racer_5.png')
    @green = Gosu::Image.new('racer_6.png')
    @orange = Gosu::Image.new('racer_7.png')
    
    @pink = Gosu::Image.new('racer_8.png')
    @p_x = 59.9
    @p_y = 294.1
    @p_tick = 299.1

    @buttons_down = 0
    @text = Gosu::Font.new(self, Gosu::default_font_name, 20)
  end

  def update
    @time = Gosu.milliseconds * 1/1000

    if @buttons_down == 1 then
      lap100m = 3.3
      # @tick += @t # 1/60sec
      t = 1.2 / lap100m
      @tick += t
      angle = @tick * Math::PI / 180
      @x += 4.5 * t * @t * Math.cos(-angle)
      @y += 2.3 * t * @t * Math.sin(-angle)
    end

    w_time = 3.61
    w_spd = 1.2 / w_time # 500m
    p_t = 1 * w_spd
    @w_tick+=p_t # 1/60 sec
    angle = @w_tick * Math::PI / 180
    @w_y += 2.3 * w_spd * Math.sin(-angle)
    @w_x += 4.5 * w_spd * Math.cos(-angle)

    p_time = 3.31
    p_spd = 1.2 / p_time
    p_t = 1 * p_spd
    @p_tick+=p_t
    angle = @p_tick * Math::PI / 180
    @p_y += 2.3 * p_spd *  Math.sin(-angle)
    @p_x += 4.5 * p_spd * Math.cos(-angle)

  end

  def draw
    @background.draw(0,0,0)

    if @tick < 360 * @lap + 36
      then @red.draw(@x, @y, 1)
      else @red.draw(471.1, 344.1, 1)
    end

    # if 360 + 36 - 0.1 < @tick and @tick < 360 + 36 + 0.1 then p @x, @y, @tick end

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
    if @tick % 60 == 0 then @sec += 1 end
    @text.draw(@sec, 450, 50, 1, 1.5, 1.5, Gosu::Color::BLUE)
    if @tick % 360 == 0 and @tick < 360 * @lap then @lap_draw += 1 end
    @text.draw(@lap_draw, 450, 10, 1, 1.5, 1.5, Gosu::Color::YELLOW)
  end

  def move
    if ((Gosu.milliseconds/1000) % 2) < 100 then @x+=5 end
  end

  def button_down(id)
    move if id == Gosu::KbReturn
    close if id ==Gosu::KbEscape
    @buttons_down += 1
  end

  # def button_up(id)
  #   @buttons_down -= 1
  # end

end

window = MyGame.new
window.show