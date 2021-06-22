require 'json'

module RaceFile

  File.open("test.json") do |j|
    $hash = JSON.load(j)
  end

  def images
    images = []
    $hash["no"].size.times do |n|
      rank = $hash["rank"][n.to_s]
      name = $hash["name"][n.to_s].gsub(" ", "")
      filename = rank + "_" + name + ".jpg"
      path = './images/'
      images << path + filename
    end
    return images
  end

  def racernames
    racernames = []
    $hash["no"].size.times do |n|
      name = $hash["name"][n.to_s]
      racernames << name 
    end
    return racernames
  end

  def racerranks
    racerranks = []
    $hash["no"].size.times do |n|
      rank = $hash["rank"][n.to_s]
      team = $hash["team"][n.to_s]
      racerranks << rank + " " + team
    end
    return racerranks
  end

  def handicaps
    handicaps = []
    $hash["no"].size.times do |n|
      handicaps << $hash["hand"][n.to_s].delete("m").to_i
    end
    return handicaps
  end

  def racetimes
    racetimes = []
    $hash["no"].size.times do |n|
      racetimes << $hash["prd"][n.to_s]
    end
    return racetimes
  end

  module_function :images, :handicaps, :racetimes, :racernames, :racerranks

end


