#!/usr/bin/env ruby
require 'rubygems'
require 'nokogiri'
require 'open-uri'

   
PAGE_URL = ARGV[0].to_s

IMG_URL = ARGV[1].to_s

JAVASCRIPT_URL = ARGV[2].to_s

CSS_URL = ARGV[3].to_s

VERSION = ARGV[4].to_s

#PAGE_URL = "https://s3-ap-southeast-1.amazonaws.com/yoose-tmp/Banner_for_v4/TheCoffeeHouse_1/TheCoffeeHouse_creative_4.html"

#IMG_URL = "https://s3-ap-southeast-1.amazonaws.com/yoose-tmp/Banner_for_v4/TheCoffeeHouse_1/BANNER-web-300x250.jpg"

#get the page, parse it
page = Nokogiri::HTML(open(PAGE_URL))

puts PAGE_URL

#get the image tag img
img = page.css('img')
img[0]["src"] = IMG_URL

#link to css
style = page.css('link')
style[0]["href"] = CSS_URL

#link to the Javascript
script  = page.css('script')
script[1]["src"]= JAVASCRIPT_URL

#puts script

puts page.to_html

f = File.new('after_processed' + VERSION + '.html', 'w')
f.write(page.to_html)
f.close    

ARGV.each do|a|
  #puts "Argument: #{a}"
end




