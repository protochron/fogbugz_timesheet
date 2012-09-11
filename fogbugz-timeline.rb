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

cmd = ARGV[0].to_sym
case_num = ARGV[1]

fog = FogBugz::API.new File.absolute_path('config.yaml')

if cmd == :start
  puts fog.start_work(case_num)
elsif cmd == :stop
  puts fog.stop_work
else
  puts fog.api_call(cmd, case_num, ARGV[2..ARGV.size-1])
end
