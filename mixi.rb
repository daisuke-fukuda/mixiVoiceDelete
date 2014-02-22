# -- coding: utf-8
require "rubygems"
require "mechanize"
require "kconv"

# setting
DOMAIN = "http://mixi.jp"
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
agent.get(DOMAIN)
p 'login'
agent.page.form("login_form").field("email").value=MAIL
agent.page.form("login_form").field("password").value=PASS
agent.page.form("login_form").submit

# トップページ
agent.get(DOMAIN + "/home.pl")
p 'top'

# コミュニティのトピックページ
agent.get(DOMAIN + '/list_bbs.pl?id=' + COMMUNITY_ID)
p 'community'

agent.page.search("div.pageTitle/h2").each do |div|
  p "commubnity title : " + div.inner_text.gsub("\n", "")
end

# 最新の更新日時
div =agent.page.search("dl.bbsList01//span.date")[0]
now_updated = div.inner_text.gsub("\n", "")
p  "now_updated : " + now_updated


# 前回の結果
dir_name = 'tmp'
file_name = dir_name + '/updated.txt'

if File.exist?(file_name)
  last_updated = File.read(file_name)
else
  last_updated = ''
end

# ファイル保存
FileUtils.mkdir_p(dir_name) unless FileTest.exist?(dir_name)

File.write(file_name, now_updated)

# 比較
if now_updated == last_updated
  p 'no change'
else
  p 'changed'
end