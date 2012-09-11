require 'bundler'
require './lib/fogbugz'

fog = FogBugz::FogBugz.new File.absolute_path('config.yaml')
fog.make_request(:listIntervals)
