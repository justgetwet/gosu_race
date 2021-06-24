require 'json'

module RaceFile

  File.open('test.json') do |j|
    hash = JSON.load(j)
    $images = []
    $ranks = []
    $names = []
    $handicaps = []
    $avgtimes = []
    $maxtimes = []
    $prdtimes = []
    $prddiffs = []
    hash['no'].size.times do |no|
      n = no.to_s
      rank = hash['rank'][n]
      name = hash['name'][n].gsub(' ', '')
      hand = hash['hand'][n].delete('m').to_i
      team = hash['team'][n]
      avgtime = hash['avg'][n]
      maxtime = hash['max'][n]
      prdtime = hash['prd'][n]
      prddiff = hash['prd-m'][n]
      $images << './images/' + rank + '_' + name + '.jpg'
      $ranks << rank + ' ' + team.slice(0)
      $names << name
      $handicaps << hand
      $avgtimes << avgtime
      $maxtimes << maxtime
      $prdtimes << prdtime
      $prddiffs << prddiff
    end
    # p $names
  end

  File.open('test2.json') do |j|
    hash = JSON.load(j)
    $racetitle = hash['title']
  end

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

  def avgtimes
    $avgtimes
  end

  def maxtimes
    $maxtimes
  end

  def prdtimes
    $prdtimes
  end

  def prddiffs
    $prddiffs
  end

  def racetitle
    $racetitle
  end

  module_function :images, :names, :ranks, :handicaps, :avgtimes, :maxtimes, :prdtimes, :prddiffs, :racetitle

end


