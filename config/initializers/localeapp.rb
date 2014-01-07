require 'localeapp/rails'

Localeapp.configure do |config|
  config.api_key = ENV['LOCALE_APP_KEY']
end
