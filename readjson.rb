require 'json'

module RaceFile

  File.open('test_new.json') do |j|
    hash = JSON.load(j)
    $raceTitle = hash['title']
    $images = []
    $ranks = []
    $names = []
    $handicaps = []
    $avgLaps = []
    $maxLaps = []
    $prdLaps = []
    $prddiffs = []
    hash['no'].size.times do |no|
      n = no.to_s
      rank = hash['rank'][n]
      name = hash['name'][n].gsub(' ', '')
      hand = hash['hand'][n].delete('m').to_i
      team = hash['team'][n]
      avgLap = hash['avg'][n]
      maxLap = hash['max'][n]
      prdLap = hash['prd'][n]
      prdDiff = hash['pdm'][n]
      $images << './images/' + rank + '_' + name + '.jpg'
      $ranks << rank + ' ' + team.slice(0)
      $names << name
      $handicaps << hand
      $avgLaps << avgLap
      $maxLaps << maxLap
      $prdLaps << prdLap
      $prddiffs << prdDiff
    end
    # p $names
  end

  # File.open('test2.json') do |j|
  #   hash = JSON.load(j)
  #   $racetitle = hash['title']
  # end

  def images
    $images
  end

  def names
    $names
  end

  def ranks
    $ranks
  end

  def handicaps
    $handicaps
  end

  def avgLaps
    $avgLaps
  end

  def maxLaps
    $maxLaps
  end

  def prdLaps
    $prdLaps
  end

  def prdDiffs
    $prdDiffs
  end

  def raceTitle
    $raceTitle
  end

  module_function :images, :names, :ranks, :handicaps, :avgLaps, :maxLaps, :prdLaps, :prdDiffs, :raceTitle

end


