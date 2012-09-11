require 'bundler'
require 'optparse'
require './lib/fogbugz'

options = {}

opts = OptionParser.new do |op|
  op.banner = "usage: fogbugz-timeline <start|stop> case"

  op.on('-v', '--[no]-verbose', 'Run verbosely') do |v|
    options[:verbose] = v
  end

end

#if ARGV.size < 2
#  puts opts.banner
#  exit
#end

opts.parse!

cmd = ARGV[0].to_s
case_num = ARGV[1]

fog = FogBugz::API.new File.absolute_path('config.yaml')
fog.eval_call(cmd,case_num)
