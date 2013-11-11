# -- coding: utf-8
require "rubygems"
require "mechanize"
require "kconv"

MAIL="hoge@gmail.com"
PASS="password"

agent = Mechanize.new
agent.user_agent_alias = "Mac Safari"

# ログイン
agent.get("http://mixi.jp")
agent.page.form("login_form").field("email").value=MAIL
agent.page.form("login_form").field("password").value=PASS
agent.page.form("login_form").submit
agent.get("http://mixi.jp/home.pl")

##### トップページ
#p agent.page.title
#p agent.page.at('p').inner_text
#agent.page.search('p').each do |p|
#  puts p.inner_text
#end
#
agent.page.search("div[@class='recentStream']//div[@class='feedContent']").each do |div|
  p div.children.at("p[@class='name']").inner_text
  p div.children.at("p[@class='description']").inner_text
end
