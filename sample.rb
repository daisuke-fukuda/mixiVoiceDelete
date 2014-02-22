# -- coding: utf-8

require "open-uri"
require "rubygems"
require "nokogiri"

# スクレイピングするURL
url = "http://www.walmart.com.br/"

charset = nil
html = open(url) do |f|
  charset = f.charset
  f.read
end
doc = Nokogiri::HTML.parse(html, nil, charset)

# タイトルを表示
p doc.title



require 'rubygems'
require 'mechanize'
require 'kconv'

agent = Mechanize.new
agent.get('http://www.google.co.jp/')
agent.page.form_with(:name => 'f'){|form|
  form.field_with(:name => 'q').value = 'Ruby'
  form.click_button
}
agent.page.link_with(:text => "オブジェクト指向スクリプト言語 Ruby".toutf8).click
puts agent.page.uri
puts agent.page.at('div#logo/img')['alt']