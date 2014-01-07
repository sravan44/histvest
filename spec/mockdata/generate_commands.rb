require 'digest/md5'

# Commands have to be run manually to run properly??
File.open("urls.txt").each_line { |line| 
	#p Digest::MD5::hexdigest(line.strip)
	command = "curl -is " + line.strip + " > " + Digest::MD5::hexdigest(line.strip) + ".http_response"
	puts command
}