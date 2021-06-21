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
      racetimes << $hash["try"][n.to_s]
    end
    return racetimes
  end

  module_function :images, :handicaps, :racetimes

end


