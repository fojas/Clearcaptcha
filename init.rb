# Include hook code here

require 'clearcaptcha/rails'

unless File.exists? config_file = File.join(RAILS_ROOT, 'config', 'clearcaptcha.yml')
  config_file = File.join(File.dirname(__FILE__),'defaults', 'clearcaptcha.yml.default')
end

Clearcaptcha.config = YAML.load(ERB.new(IO.read(config_file)).result)
