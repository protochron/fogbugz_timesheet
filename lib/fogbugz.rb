# Load libraries
require 'nokogiri'
require 'httparty'

module FogBugz
  class API
    include HTTParty

    class APIError < StandardError
    end

    def initialize(config_file)
      @config = Psych.load(File.open(config_file,'r'))
      @token = @config[:token]
      @base_url = @config[:base_url]
    end

    def eval_call(cmd, *options)
      if self.method(cmd).arity > 0
        if self.method(cmd).arity == options.size
          self.send(cmd, *options)
        else
          raise APIError
        end
      else
        self.send(cmd)
      end
    end

    def list_intervals
      make_request(:listIntervals)
    end

    def make_request(command, params={})
      raise StandardError unless @token

      request = {:token => @token}
      request.merge!({:cmd => command})
      request.merge! params
      request = {:body => request}
      Nokogiri::XML(self.class.post(@base_url, request).body)
    end
  end

end
