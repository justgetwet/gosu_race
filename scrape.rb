require 'nokogiri'
require 'open-uri'

url_oddspark = 'https://www.oddspark.com/autorace'

url_race = url_oddspark + '/OneDayRaceList.do?'

race = url_race + 'raceDy=20210611&placeCd=04'

html = URI.open(race).read

# doc = Nokogiri::HTML.parse(html, nil, 'UTF-8')

# puts doc.title

File.open("./nokogiri.html", mode="w") {|f|
	f.write(html, "\uFEFF", encoding: "utf-8")
}
