require 'json'

class Race

  attr_reader :title
  attr_reader :images, :frames, :pieces
  attr_reader :nos, :ranks, :names, :handicaps
  attr_reader :avgLaps, :maxLaps, :prdLaps
  attr_reader :avgDifs, :maxDifs, :prdDifs

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
      @maxLaps = []
      @prdLaps = []
      @avgDifs = []
      @maxDifs = []
      @prdDifs = []
      hash['no'].size.times do |no|
        n = no.to_s
        rank = hash['rank'][n]
        name = hash['name'][n].gsub(' ', '')
        team = hash['team'][n]
        @nos << no.next.to_s
        @images << './images/' + rank + '_' + name + '.jpg'
        @frames << './colors/frame_' + no.next.to_s + '.jpg'
        @pieces << './colors/racer_' + no.next.to_s + '.png'
        @ranks << rank + ' ' + team.slice(0)
        @names << name
        @handicaps << hash['hand'][n].delete('m').to_i
        @avgLaps << hash['avg'][n]
        @maxLaps << hash['max'][n]
        @prdLaps << hash['prd'][n]
        @avgDifs << hash['agm'][n]
        @maxDifs << hash['mxm'][n]
        @prdDifs << hash['pdm'][n]
      end
    end
  end

end

