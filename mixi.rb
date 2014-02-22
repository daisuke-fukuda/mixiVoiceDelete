# -- coding: utf-8
require "rubygems"
require "mechanize"
require "kconv"

# setting
domain = "http://mixi.jp"
MAIL = ARGV[0]
PASS = ARGV[1]
COMMUNITY_ID = ARGV[2]

if MAIL == nil || PASS == nil || COMMUNITY_ID == nil then
  puts "3ARGS is require"
  exit 1
end

agent = Mechanize.new
agent.user_agent_alias = "Mac Safari"

# ログイン
agent.get(domain)
p 'login'
agent.page.form("login_form").field("email").value=MAIL
agent.page.form("login_form").field("password").value=PASS
agent.page.form("login_form").submit

# トップページ
agent.get(domain + "/home.pl")
p 'top'

# コミュニティページ
agent.get(domain + '/view_community.pl?id=' + COMMUNITY_ID)
p 'community'

agent.page.search("div.pageTitle/h2").each do |div|
  p "commubnity title : " + div.inner_text.gsub("\n", "")
end
