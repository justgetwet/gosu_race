require 'json'

class Race

  attr_reader :title
  attr_reader :images, :frames, :pieces
  attr_accessor :ranks, :names, :handicaps
  attr_accessor :avgLaps, :maxLaps, :prdLaps
  attr_accessor :prdDiffs

  def initialize

    File.open('test_new.json') do |j|
      hash = JSON.load(j)
      @title = hash['title']
      @images = []
      @frames = []
      @pieces = []
      @ranks = []
      @names = []
      @handicaps = []
      @avgLaps = []
      @maxLaps = []
      @prdLaps = []
      @prdDiffs = []
      hash['no'].size.times do |no|
        n = no.to_s
        rank = hash['rank'][n]
        name = hash['name'][n].gsub(' ', '')
        team = hash['team'][n]
        @images << './images/' + rank + '_' + name + '.jpg'
        @frames << './colors/frame_' + no.next.to_s + '.jpg'
        @pieces << './colors/racer_' + no.next.to_s + '.png'
        @ranks << rank + ' ' + team.slice(0)
        @names << name
        @handicaps << hash['hand'][n].delete('m').to_i
        @avgLaps << hash['avg'][n]
        @maxLaps << hash['max'][n]
        @prdLaps << hash['prd'][n]
        @prdDiffs << hash['pdm'][n]
      end
    end
  end

end

