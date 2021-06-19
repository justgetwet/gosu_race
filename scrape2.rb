require 'nokogiri'

html = open('nokogiri.html').read

# doc = Nokogiri::HTML.parse(html, nil, 'UTF-8')
doc = Nokogiri::HTML.parse(html)
title = doc.title
puts title

pp doc.css('table th')