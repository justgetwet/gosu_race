require 'gosu'

class Around < Gosu::Window

def initialize
	@width = 640
	@height = 480
	super @width,@height,false
	@background = Gosu::Image.new('./course.jpg')
  @piece = Gosu::Image.new('./colors/racer_0.png')
  @x, @y =  168.0, 345.5
	@degree = -36
  @dif = 7.2
	@count = 0
end

def update
	@count += 1
	@degree += @dif
	rad = @degree * Math::PI / 180
	@x += 4.5 * @dif * Math::cos(-rad)
  @y += 2.3 * @dif * Math::sin(-rad)
	if @count == 42
		p @x
		p @y
	end
end

def draw
	@background.draw(0,0,0)
  @piece.draw(@x, @y, 1)
end

def button_down(id)
	close if id == Gosu::KbEscape
end

end

window = Around.new
window.show