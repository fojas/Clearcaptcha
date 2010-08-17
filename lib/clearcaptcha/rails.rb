require 'clearcaptcha'

ActionView::Base.send(:include, Clearcaptcha::ClientHelper)
ActionController::Base.send(:include, Clearcaptcha::Verify)