# require 'gosu'

# class Racer
#   @color = ""
#   def setColor(img)
#     @color = img
#   end
#   def getColor
#     return @color
#   end
# end

# obj = Racer.new
# img = Gosu::Image.new('racer_3.png')
# obj.setColor(img)

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

lst = theoretical_time.sort_by { |_, v| v }
p lst[0][1]