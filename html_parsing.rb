#!/usr/bin/env ruby
require 'rubygems'
require 'nokogiri'
require 'open-uri'
require 'fileutils'
   
CAMPAIGN = ARGV[0].to_s

WIDTH = ARGV[1].to_s

HEIGHT = ARGV[2].to_s

VERSION = ARGV[3].to_s

CSS_URL = ARGV[4].to_s

combined_style = ""

combined_script = ""

PAGE_URL = "/var/lib/jenkins/workspace/manipulate_zip_creatives/index.html"

#IMG_URL = "https://s3-ap-southeast-1.amazonaws.com/yoose-tmp/Banner_for_v4/TheCoffeeHouse_1/BANNER-web-300x250.jpg"

#get the page, parse it
page = Nokogiri::HTML(open(PAGE_URL))

puts PAGE_URL

#change CSS file
style = page.css('style')

style.each do |style|
	combined_style = combined_style.to_s + style.text.to_s
	style.content = ""
end

f = File.new('result_style.css', 'w')
f.write(combined_style.to_s)
f.close   

# style.last.add_next_sibling <link rel="stylesheet" href="https://s3-ap-southeast-1.amazonaws.com/yoose-tmp/twix-nigra/twix-nigra-local-320x50/style0.css">

css_link = Nokogiri::XML::Node.new "link", page
css_link["rel"] = "stylesheet"
css_link["href"] = "style0.css"
style.last.add_next_sibling(css_link)

#Change Javascript file

script = page.css('script')
script_count = 0
# puts 

script.each do |script|
	f = File.new('function' + script_count.to_s + '.js', 'w')
	f.write(script.text.to_s)
	f.close
	script["src"] = 'function' + script_count.to_s + '.js'
	script.content = ""
	script_count = script_count + 1 
end

ARGV.each do|a|
  #puts "Argument: #{a}"
end

# Open the script file, read and store it in the last script tag

tracking_script = ""

fi = File.open("v4_tracking.js", "r")
fi.each_line do |line|
	tracking_script = tracking_script + line  		
end
# puts tracking_script
fi.close

#add the tracking script in
V4_tracking_script = Nokogiri::XML::Node.new "script", page
V4_tracking_script["id"] = "tracking_script"
V4_tracking_script.content = tracking_script
script.last.add_next_sibling(V4_tracking_script)

# script.last.add_next_sibling "<script>" + tracking_script + "</script>"

#Replace the element id with the one in tracking script
element = page.css('#creativelink')
element[0]["id"]="unique_animation_container"

#Change all source link to S3 or any other repo where this file is being pushed to
link = page.css('link')
script = page.css('script')
image = page.css('gwd-image')

link.each do |link|
	link["src"]="https://s3-ap-southeast-1.amazonaws.com/tuan.vu.yoose/" + CAMPAIGN.to_s + "/" + CAMPAIGN + "-" + WIDTH + "x" + HEIGHT + "/" + VERSION + "/" + link["src"].to_s
end

script.each do |script|
	script["src"]="https://s3-ap-southeast-1.amazonaws.com/tuan.vu.yoose/" + CAMPAIGN + "/" + CAMPAIGN + "-" + WIDTH + "x" + HEIGHT + "/" + VERSION + "/" + script["src"].to_s
end

#remove function 8 script URL
script[-2].remove

V4_tracking_script_proccesed = page.css('script#tracking_script')[0]

V4_tracking_script_proccesed.delete("src")

image.each do |image|
	image["source"]="https://s3-ap-southeast-1.amazonaws.com/tuan.vu.yoose/" + CAMPAIGN + "/" + CAMPAIGN + "-" + WIDTH + "x" + HEIGHT + "/" + VERSION + "/" + image["source"].to_s
end

#save the page to result file
f = File.new('after_processed.html', 'w')
f.write(page.to_html)
f.close    


# def create_file(path, extension)
#   dir = File.dirname(path)

#   unless File.directory?(dir)
#     FileUtils.mkdir_p(dir)
#   end

#   path << ".#{extension}"
#   File.new(path, 'w')
# end  

# #get the image tag img
# img = page.css('img')
# img[0]["src"] = IMG_URL

# #link to css
# style = page.css('link')
# style[0]["href"] = CSS_URL

# #link to the Javascript
# script  = page.css('script')
# script[1]["src"]= JAVASCRIPT_URL

#puts script

# puts page.to_html





