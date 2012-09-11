# Load libraries
require 'nokogiri'
require 'httparty'

module FogBugz
  class FogBugz
    include HTTParty

    def initialize(config_file)
      @config = Psych.load(File.open(config_file,'r'))
      @token = @config["token"]
      @base_url = @config["base_url"]
      print @base_url
    end

    def make_request(command, params={})
      raise StandardError unless @token

      request = {:token => @token}
      request.merge!({:cmd => command})
      request.merge! params
      request = :body => request
      #Nokogiri::XML(self.class.post(@base_url, request).body)
      puts self.class.post(@base_url, request)
    end
  end

end
