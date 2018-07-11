#!/usr/bin/ruby

#Introspection.rb
#Connor Sullivan
#09/25/17
objects = [ 3, 3.0, "A message", %w[u v w x y z], {:IN=>"Indiana", :IL=>"Illinois"}, (90..100) ]
methods = [ :collect, :times, :size, :each, :+, :*, :to_a, :to_s ]

objects.each do |o|
	puts "Object: #{o}"
	methods.each do |m|
		if o.respond_to?(m)
			 puts "Calling method #{m} on object #{o}"
                        begin
                               puts "#{o.send(m)}"
                        rescue ArgumentError => e
                                puts "\tException caught: Argument Error"
                                puts "\t#{e}"
                                next
                        end
		else
			puts "Objects of type #{o.class} do not normally respond to the #{m} method."

		end
	end
end
