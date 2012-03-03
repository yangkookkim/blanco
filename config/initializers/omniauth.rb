require "omniauth"
#require 'forcedotcom'
require "omniauth-salesforce"

# Set the default hostname for omniauth to send callbacks to.
# seems to be a bug in omniauth that it drops the httpS
# this still exists in 0.2.0
OmniAuth.config.full_host = 'https://localhost:3000'

#module OmniAuth
#  module Strategies
#    #tell omniauth to load our strategy
#    autoload :Forcedotcom, 'lib/forcedotcom'
#  end
#end


Rails.application.config.middleware.use OmniAuth::Builder do
  provider :salesforce, '3MVG9rFJvQRVOvk6eOvf6uX9Du7WbJr2pMF763J57TCTvvz80FcA4pk23RdAyfBG0p7df3KqcDzkOg6o7r78X', '2647515227667638785'
end

