require 'mini_magick'

image = MiniMagick::Image.open('https://source.unsplash.com/random/640x480')
image.write('from_unsplash.jpg')