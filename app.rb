require 'gosu'
require './player.rb'

class MyGame < Gosu::Window
   
  # コンストラクタ
  def initialize
    @width = 640
    @height = 480
    super @width,@height,false
    @background = Gosu::Image.new('course.png')
    @ball = Gosu::Image.new('racer_8.png')
    @ball_2 = Gosu::Image.new('racer_1.png')
    # @time = Gosu.milliseconds/1000
    @time = 0
    # @tick = 0
    @tick_2 = 0
    # @x = 320
    # @y = 360
    @x = 95.9
    @y = 294.1
    @tick = 299.1

    @x_2 = 320
    @y_2 = 360
    @buttons_down = 0
    @text = Gosu::Font.new(self, Gosu::default_font_name, 20)
  end

  def update
    @time = Gosu.milliseconds * 1/1000
    r_time = 3.31
    spd = 1.2 / r_time
    t = 1 * spd
    @tick+=t # 1/60 sec
    angle = @tick * Math::PI / 180
    @y += 2.3 * spd * Math.sin(-angle)
    @x += 4.5 * spd * Math.cos(-angle)

    s_time = 3.4
    spd_2 = 1.2 / s_time
    s = 1 * spd_2
    @tick_2+=s
    angle = @tick_2 * Math::PI / 180
    @y_2 += 2.3 * spd_2 *  Math.sin(-angle)
    @x_2 += 4.5 * spd_2 * Math.cos(-angle)

  end

  def draw
    @background.draw(0,0,0)
    if @tick_2 < 360 * 6 - 300
      then @ball_2.draw(@x_2, @y_2, 1)
      else @ball_2.draw(330, 365, 1)
    end
    if 299.8 < @tick and @tick < 300.0 then p @x, @y, @tick end
    @ball_2.draw(320, 380, 0)
    if @tick < 360 * 6
      then @ball.draw(@x, @y, 0) 
      else @ball.draw(330, 360, 0) 
    end
    @text.draw(@time, 450, 10, 1, 1.5, 1.5, Gosu::Color::RED)
    @text.draw(@tick, 450, 50, 1, 1.5, 1.5, Gosu::Color::RED)
    @text.draw(Gosu.fps, 450, 90, 1, 1.5, 1.5, Gosu::Color::BLUE)
  end

  def move
    if ((Gosu.milliseconds/1000) % 2) < 100 then @x+=5 end
  end

  def button_down(id)
    move if id == Gosu::KbReturn
    close if id ==Gosu::KbEscape
    @buttons_down += 1
  end

  def button_up(id)
    @buttons_down -= 1
  end

end

window = MyGame.new
window.show