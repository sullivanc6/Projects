#!/usr/bin/ruby

#file_stats.rb
#Connor Sullivan
#11/20/17

counthash = Hash.new(0)  #This will count the extensions.
sizehash = Hash.new(0)   #This will keep track of the sizes.
extradir = Array.new  #This will hold additional directories inside the ones
                      #passed through arguments.

#This block gets the input and if there is none, makes it the current directory
input = ARGV
if input.length == 0
  input = ["./"]
end

#This block handles the directories given in the arguments and clears
#hashes and resets all the counters at the beginning. 
input.each do |dir|
  extradir.clear
  sizehash.clear
  counthash.clear
  if File.directory?(dir) == false  #Check if file is directory
    puts "#{dir} is not a directory or doesn't exist."
    next
  end
  if File.readable?(dir) == false  #Check if file is readable
    puts "Unable to read #{dir}"
    next
  end
  puts "---Disk utilization per extension under #{dir}--- "
  Dir.glob("#{dir}*").each do |file|
    if File.directory?(file) == true  #If it finds a directory, add it to a new
      extradir.push("#{file}/")       #array.
    else
      ext = File.extname(file)
      size = File.size(file)
      if ext == "" #if there is no extenshion, sets it as other and adds it
        ext = "<other>"
        counthash["#{ext}"] += 1
        sizehash["#{ext}"] += size
      else  #If there is an extension, add it to hashes normally
        counthash["#{ext}"] += 1
        sizehash["#{ext}"] += size
      end
    end
  end
  #This block will parse directories inside of the one passed to ARGV
  extradir.each do |dir2|
    if File.directory?(dir2) == false  #Check if file is directory
      puts "#{dir2} is not a directory or doesn't exist."
      next
    end
    if File.readable?(dir2) == false  #Check if file is readable
      puts "Unable to read #{dir2}"
      next
    end
    Dir.glob("#{dir2}*").each do |file2|
      if File.directory?(file2) == true  #If it finds a directory, add it to the
        extradir.push("#{file2}/")       #array currently being parsed.
      else
        ext = File.extname(file2)
        size = File.size(file2)
        if ext == "" #if there is no extenshion, sets it as other and adds it
          ext = "<other>"
          counthash["#{ext}"] += 1
          sizehash["#{ext}"] += size
        else  #If there is an extension, add it to hashes normally
          counthash["#{ext}"] += 1
          sizehash["#{ext}"] += size
        end
      end
    end
  end
  counthash.each do |k, v|
    puts "Extension: #{k} Count: #{v} Size: #{sizehash[k]}"
  end
end

