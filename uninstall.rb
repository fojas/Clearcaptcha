# Uninstall hook code here
puts "Removing files..."

[
  {:src => "public/javascripts/clearcaptcha/clearcaptcha.js"},
  {:src => "defaults/clearcaptcha.yml.default",:dest => "config/clearcaptcha.yml"}
  
].each do |file_hash|
  src = file_hash[:src]
  dest = file_hash[:dest]
  
  if file_hash[:dest].nil?
    dest = src
  end
  
	dest_file = File.join(RAILS_ROOT, dest)
	puts "rm "+dest_file
	FileUtils.rm(src_file)
end