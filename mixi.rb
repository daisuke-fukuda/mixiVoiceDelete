# -- coding: utf-8
require 'rubygems'
require 'mechanize'
require 'kconv'

# setting
DOMAIN = 'https://mixi.jp'
MAIL = ARGV[0]
PASS = ARGV[1]

if MAIL == nil || PASS == nil  then
  puts '2ARGS is require'
  exit 1
end

agent = Mechanize.new
agent.user_agent_alias = 'Mac Safari'

# ログイン
agent.get(DOMAIN)
p 'login'
agent.page.form('login_form').field('email').value=MAIL
agent.page.form('login_form').field('password').value=PASS
agent.page.form('login_form').submit

# トップページ
agent.get(DOMAIN + '/home.pl')
p 'top'


for num in 1..100 do
	page = agent.get(DOMAIN + '/list_voice.pl')
	p 'voice'

	#<a class="deleteIcon " href="delete_voice.pl?post_time=20161022191342&amp;redirect=list_voice.pl&amp;post_key=648078d3c3351838fb69737f14e1b2e3f59328f9">削除</a>
	elements = page.search('a')
	elements.each do |ele|
		if ele.get_attribute(:class) == 'deleteIcon '
			deleteHref = ele.get_attribute(:href)
			agent.get(DOMAIN + "/" + deleteHref)
			p deleteHref
		end
	end
end 

