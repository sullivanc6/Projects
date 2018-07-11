#!/usr/bin/ruby
#parse_html.rb
#Connor Sullivan
#11/01/17
file = "computer-science.html"
require 'nokogiri'
urlmatch = Regexp.new(/^\/.*/)
mailmatch = Regexp.new(/^mailto:.*/)
httpmatch = Regexp.new(/^http.*/)
urlhash = Hash.new(0)
mailhash = Hash.new(0)
File.readlines(file).each do |line|
  doc = Nokogiri.HTML(line)
  url = doc.search('a').map{ |a| a['href'] }
  url.each do |x|
    if x == '#'
      next
    elsif x.match(httpmatch) != nil
      urlhash[x] += 1
    elsif x.match(urlmatch) != nil
      appendurl = "http://informatics.nku.edu" + x
      urlhash[appendurl] += 1
    elsif x.match(mailmatch) != nil
      x.slice! "mailto:"
      mailhash[x] += 1
    end
  end
end

puts "URLs collected:"
urlhash.each do |k, v|
  puts "#{k} -- #{v}"
end
puts ""
puts "Email Addresses collected:"
mailhash.each do |k, v|
  puts "#{k} -- #{v}"
end
