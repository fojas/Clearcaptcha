module Clearcaptcha
  module Config
    extend self

    def setup(options)
      config = options['defaults']

      case options[RAILS_ENV]
      when Hash   then config = options[RAILS_ENV]
      when String then config[:disabled] = true 
      end
      
      config.symbolize_keys!
      
      config
    end
  end
end