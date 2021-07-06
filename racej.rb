require 'json'

class Race

  attr_reader :title
  attr_reader :images, :frames, :pieces
  attr_reader :nos, :ranks, :names, :handicaps
  attr_reader :avgLaps, :fstLaps, :prdLaps, :runLaps
  attr_reader :avtDifs, :avgDifs, :fstDifs
  attr_reader :prdDifs, :runDifs
  attr_reader :odrs, :favs

  def initialize

    File.open('test_new.json') do |j|
      hash = JSON.load(j)
      @title = hash['title']
      @images = []
      @frames = []
      @pieces = []
      @nos = []
      @ranks = []
      @names = []
      @handicaps = []
      @avgLaps = []
      @fstLaps = []
      @prdLaps = []
      @runLaps = []
      # @avtDifs = []
      @avgDifs = []
      @fstDifs = []
      @prdDifs = []
      @runDifs = []
      @odrs = []
      @favs = []
      hash['no'].size.times do |no|
        n = no.to_s
        rank = hash['rank'][n]
        name = hash['name'][n].gsub(' ', '')
        lg = hash['lg'][n]
        @nos << hash['no'][n]
        @images << './images/' + rank + '_' + name + '.jpg'
        @frames << './colors/frame_' + no.next.to_s + '.jpg'
        @pieces << './colors/racer_' + no.next.to_s + '.png'
        @ranks << rank + ' ' + lg.slice(0)
        @names << name
        if hash['hand'][n] != nil
          @handicaps << hash['hand'][n].delete('m').to_i
        else
          @handicaps << '0m'
        end
        @avgLaps << hash['avg'][n]
        @fstLaps << hash['fst'][n]
        @prdLaps << hash['prd'][n]
        @runLaps << hash['run'][n]
        # @avtDifs << hash["atm"][n]
        @avgDifs << hash['avm'][n]
        @fstDifs << hash['fsm'][n]
        @prdDifs << hash['pdm'][n]
        @runDifs << hash['rnm'][n]
        @odrs << hash['odr'][n]
        @favs << hash['fav'][n]
      end
    end
  end
end

