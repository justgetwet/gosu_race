require 'gosu'
require './readjson.rb'

class Panels

	def initialize

		@racerimages = []
		@frames = []
		no = 0
		RaceFile.images.each do |image_path|
			@racerimages << Gosu::Image.new(image_path)
			no += 1
			frame_path = './colors/frame_' + no.to_s + '.jpg'
			@frames << Gosu::Image.new(frame_path)
		end

		@ranks = []
		@names = []
		RaceFile.ranks.zip(RaceFile.names) do |rank, name|
			@ranks << rank
			@names << name
		end

	end

	def draw

		x = -50
		y = 10
		add_x = 75
		@racerimages.zip(@frames) do |image, frame|
			x += add_x
			image.draw(x, y, 2)
			frame.draw(x, y, 1)
		end

    # pos_x = 25
    # add_x = 75
    # pos_y = 10
    # @white_img.draw(pos_x, pos_y, 2)
    # @white_frm.draw(pos_x, pos_y, 1)
    # @text.draw_text(@white_rank, pos_x, pos_y+70, 3, 0.75, 0.75, 0xff000000)
    # @text.draw_text(@white_name, pos_x, pos_y+85, 3, 0.75, 0.75, Gosu::Color::BLACK)

    # @black_img.draw(pos_x += add_x, pos_y, 2)
    # @black_frm.draw(pos_x, pos_y, 1)
    # @text.draw_text(@black_rank, pos_x, pos_y+70, 3, 0.75, 0.75, Gosu::Color::BLACK)
    # @text.draw_text(@black_name, pos_x, pos_y+85, 3, 0.75, 0.75, Gosu::Color::BLACK)

    # @red_img.draw(pos_x += add_x, pos_y, 2)
    # @red_frm.draw(pos_x, pos_y, 1)
    # @text.draw_text(@red_rank, pos_x, pos_y+70, 3, 0.75, 0.75, Gosu::Color::BLACK)
    # @text.draw_text(@red_name, pos_x, pos_y+85, 3, 0.75, 0.75, Gosu::Color::BLACK)
    
    # @blue_img.draw(pos_x += add_x, pos_y, 2)
    # @blue_frm.draw(pos_x, pos_y, 1)
    # @text.draw_text(@blue_rank, pos_x, pos_y+70, 3, 0.75, 0.75, Gosu::Color::BLACK)
    # @text.draw_text(@blue_name, pos_x, pos_y+85, 3, 0.75, 0.75, Gosu::Color::BLACK)

    # @yellow_img.draw(pos_x += add_x, pos_y, 2)
    # @yellow_frm.draw(pos_x, pos_y, 1)
    # @text.draw_text(@yellow_rank, pos_x, pos_y+70, 3, 0.75, 0.75, Gosu::Color::BLACK)
    # @text.draw_text(@yellow_name, pos_x, pos_y+85, 3, 0.75, 0.75, Gosu::Color::BLACK)

    # @green_img.draw(pos_x += add_x, pos_y, 2)
    # @green_frm.draw(pos_x, pos_y, 1)
    # @text.draw_text(@green_rank, pos_x, pos_y+70, 3, 0.75, 0.75, Gosu::Color::BLACK)
    # @text.draw_text(@green_name, pos_x, pos_y+85, 3, 0.75, 0.75, Gosu::Color::BLACK)

    # @orange_img.draw(pos_x += add_x, pos_y, 2)
    # @orange_frm.draw(pos_x, pos_y, 1)
    # @text.draw_text(@orange_rank, pos_x, pos_y+70, 3, 0.75, 0.75, Gosu::Color::BLACK)
    # @text.draw_text(@oragne_name, pos_x, pos_y+85, 3, 0.75, 0.75, Gosu::Color::BLACK)

    # @pink_img.draw(pos_x += add_x, pos_y, 2)
    # @pink_frm.draw(pos_x, pos_y, 1)
    # @text.draw_text(@pink_rank, pos_x, pos_y+70, 3, 0.75, 0.75, Gosu::Color::BLACK)
    # @text.draw_text(@pink_name, pos_x, pos_y+85, 3, 0.75, 0.75, Gosu::Color::BLACK)

	end

end