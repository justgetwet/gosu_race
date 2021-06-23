require 'json'

module RaceFile

  File.open("test.json") do |j|
    hash = JSON.load(j)
    $images = []
    $ranks = []
    $names = []
    $handicaps = []
    $prdtimes = []
    $prddiffs = []
    hash["no"].size.times do |n|
      rank = hash["rank"][n.to_s]
      name = hash["name"][n.to_s].gsub(" ", "")
      hand = hash["hand"][n.to_s].delete("m").to_i
      team = hash["team"][n.to_s]
      prdtime = hash["prd"][n.to_s]
      prddiff = hash["prd-m"][n.to_s]
      $images << './images/' + rank + "_" + name + ".jpg"
      $ranks << rank + " " + team
      $names << name
      $handicaps << hand
      $prdtimes << prdtime
      $prddiffs << prddiff
    end
    # p $names
  end

  File.open("test2.json") do |j|
    hash = JSON.load(j)
    $racetitle = hash["title"]
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

  def prdtimes
    $prdtimes
  end

  def prddiffs
    $prddiffs
  end

  def racetitle
    $racetitle
  end

  module_function :images, :names, :ranks, :handicaps, :prdtimes, :prddiffs, :racetitle

end


