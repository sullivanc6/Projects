#!/usr/bin/ruby

#generate_commands.rb
#

# CIT 483/583-001 Fall 2017

# Starter code given with the assignment

users = {'smithj1' => 'John Smith', 'doej1' => "Jane Doe", 'publicj1' => "John Q. Public", 'mccordt' => "Tim McCord" }
words = ['Care' , 'less', 'Toys', 'game', 'rand', 'Ruby', 'star', 'Lite']
seps = ['−', '%', '&', '@', '#', '!' ]
alpha = [*('a'..'z'), *('A'..'Z')] 

# looping through the users hash
users.each do |u, n|
	i = 0
	encrypt = ""

	# create the unencrypted password
	un_pass = "#{words[rand(words.count)]}#{seps[rand(seps.count)]}#{words[rand(words.count)]}"
		# Loops through the alpha array to create a random string for encryption
		while i < 16
		encrypt = encrypt + "#{alpha[rand(alpha.length)]}"
		i = i + 1
		end
	#Encrypt the passwords and print the useradd statements
	enc_pass = un_pass.crypt("$6$#{encrypt}")
	puts "Command: useradd -m -c \"#{n}\" -p \'#{enc_pass}\' #{u}"	
end
