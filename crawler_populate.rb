#!/usr/bin/ruby
#Connor Sullivan
#crawler_populate.rb
#12/6/17

#Require all necessary gems
require 'active_record'
require 'sqlite3'
require 'open-uri'
require 'nokogiri'

#initialize arrays
hrefs = Array.new
titles = Array.new
content_types = Array.new
last_mod = Array.new
statuses = Array.new

#parse the link with Nokogiri
nku = "https://www.nku.edu/academics/informatics.html"
doc = Nokogiri::HTML(open(nku))

#Connect to database and create object models
ActiveRecord::Base.establish_connection(adapter: 'sqlite3', database: 'crawler.db')
class Page < ActiveRecord::Base
  has_and_belongs_to_many :pages
end
class Link < ActiveRecord::Base
  has_and_belongs_to_many :authors
end


#parse all 'a' tags with Nokogiri
links = doc.css('a')
links.each do |l|
  if l.attributes["href"].respond_to?(:value) == false || l.attributes["title"].respond_to?(:value) == false #Check to make sure link is readable
    next
  else  #If link is readable. save all data into arrays
    hrefs.push(l.attributes["href"].to_s)
    titles.push(l.attributes["title"].to_s)
    open(l.attributes["href"].to_s) do |f| #Use open-uri to get data that Nokogiri cannot get
      content_types.push(f.content_type)
      last_mod.push(f.last_modified)
      statuses.push(f.status[0])
    end
  end
end
#--------------TESTING-------------------
#hrefs.each do |h|
#  puts "Link: #{h}"
#  puts "Title: #{titles[hrefs.index(h)]}"
#  puts "Content Type: #{content_types[hrefs.index(h)]}"
#  puts "Last Mod: #{last_mod[hrefs.index(h)]}"
#  puts "Status: #{statuses[hrefs.index(h)]}"
#end
#------------------END TESTING--------------------
hrefs.each do |h|                    #Add everything to the database
  r = Page.new( :url => "#{h}", :title => "#{titles[hrefs.index(h)]}", :content_type => "#{content_types[hrefs.index(h)]}", :last_modified => last_mod[hrefs.index(h)], :status => "#{statuses[hrefs.index(h)]}")
  r.save
end
