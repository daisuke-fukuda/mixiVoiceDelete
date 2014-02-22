# -- coding: utf-8
require 'open-uri'
require 'nokogiri'


doc = Nokogiri::HTML(open("http://www.google.com/search?q=doughnuts"))

#doc.xpath('//h3[@class="r"]/a').each do |node|
doc.css('h3.r>a').each do |node|
  puts node.text
end