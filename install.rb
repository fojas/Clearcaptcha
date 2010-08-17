# Install hook code here

puts "creating secret"

puts "Copying files..."

[
  {:src => "public/javascripts/clearcaptcha.js"},
  {:src => "defaults/clearcaptcha.yml.default",:dest => "config/clearcaptcha.yml"}
  
].each do |file_hash|
  src = file_hash[:src]
  dest = file_hash[:dest]
  
  if file_hash[:dest].nil?
    dest = src
  end
  
	dest_file = File.join(RAILS_ROOT, dest)
	src_file = File.join(File.dirname(__FILE__) , src)
	puts "cp "+src_file+" "+dest_file
	FileUtils.cp_r(src_file, dest_file)
end
puts "Files copied - Installation complete!"