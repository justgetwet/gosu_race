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
    @time = Gosu.milliseconds/100
    @x = 300
    @y = 300
    @buttons_down = 0
    @text = Gosu::Font.new(self, Gosu::default_font_name, 20)
  end

  def update
    @time = Gosu.milliseconds/100
  end

  def draw
    @background.draw(0,0,0)
    @ball.draw(@time *= 10, @y, 0)
    @text.draw(@time, 450, 10, 1, 1.5, 1.5, Gosu::Color::RED)
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