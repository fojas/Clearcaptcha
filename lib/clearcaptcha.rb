# Clearcaptcha
require 'clearcaptcha/client_helper'
require 'clearcaptcha/verify'
require 'clearcaptcha/config'

module Clearcaptcha
  VERSION = "0.0.1"

  SKIP_VERIFY_ENV = ['test', 'cucumber']

  @@config = {}
  
  mattr_reader :config

  def self.config=(options)
    @@config = Config.setup options
  end
  
  class ClearcaptchaError < StandardError; end
  
end