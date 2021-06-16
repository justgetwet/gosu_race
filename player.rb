require 'gosu'

class Player
  def initialize
    @image = Gosu::Image.new("racer_8.png")
    @x = @y = 0.0
    @vel_x = @vel_y = 0.0 
    @angle = 0.0
    @score = 0
    @time = Gosu.milliseconds/100
  end

  def warp(x, y)
    @x = x
    @y = y
  end

  def turn_left
    @angle -= 4.5
  end

  def turn_right
    @angle += 4.5
  end

  def accelerate
    @vel_x += Gosu.offset_x(@angle, 0.5)
    @vel_y += Gosu.offset_y(@angle, 0.5)
  end

  def test
    @angle += 45
    @vel_x += Gosu.offset_x(@angle, 1.5)
    @vel_y += Gosu.offset_y(@angle, 1.5)
  end

  def move
    @x += @vel_x
    @y += @vel_y
    @x %= 640
    @y %= 480
    @vel_x *= 0.95
    @vel_y *= 0.95
  end

  def draw
    @image.draw_rot(@x, @y, 1, @angle)
  end
end