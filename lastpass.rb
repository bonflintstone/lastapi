require 'optparse'
require 'pry-byebug'
require 'yaml'
require './fetch'

class Lastpass
  def self.startup
    fetch = Fetch.new(config)
    PP.pp fetch.try_something_new
  end

  private

  def self.config
    parse_opts.merge!(load_config){ |k, c, l| c }
  end

  def self.parse_opts
    options = {}
    OptionParser.new do |opts|
      opts.banner = "Usage: lastpass.rb [options] <site>"
      
      opts.on('--help', '') do |v|
        puts %<
          Display this helpful helping message.
          ToDo: content
        >
        exit
      end
      opts.on('-l^LOGIN', '--login=LOGIN', 'Login name') do |l|
        options[:name] = l
      end
      opts.on('-pPASSWORD', '--pass=PASSWORD', 'Password') do |p|
        options[:pass] = p
        # TODO: read password saferly from command line
      end
    end.parse!

    options
  end

  def self.load_config
    config = YAML.load_file('lastpass.yml')
  rescue Errno::ENOENT
    {}
  end
end

Lastpass.startup
