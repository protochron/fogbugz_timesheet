require 'bundler'
require 'nokogiri'
require 'httparty'
require 'yaml'


if ARGV.size != 3
  puts "Need username and password to get Fogbugz API token"
  exit
end

base = ARGV[0]
user = ARGV[1]
pass = ARGV[2]

options = {:cmd => 'logon', :email => user, :password => pass}
request = {:body => options}

response = HTTParty.post(base, request).body

doc = Nokogiri.XML(response)
puts doc
token = doc.at_xpath('//token').content

base = {:base_url => base}
token = {:token => token}
File.open('config.yaml', 'w') { |f|
  f.write base.to_yaml
  f.write token.to_yaml
}

