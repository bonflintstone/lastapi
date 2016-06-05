#!/usr/bin/env ruby

class Lastapi
  def self.startup
    accounts = AccountsCache.read_from_cache unless ['nocache', 'reload'].include? config['cache']
    accounts ||= AccountsCache.reload_cache(config) unless config['cache'] == 'nocache'
    accounts ||= Accounts.new(config)

    if accounts == nil
      puts "No Cache there"
      exit
    end

    puts accounts.get_password ARGV.pop
  end

  private

  def self.config
    @config ||= parse_opts.merge!(load_config){ |k, c, l| c }
    @config['pass'] ||= ask("Enter your password:  ") { |q| q.echo = "*" }
    @config
  end

  def self.parse_opts
    options = {}
    OptionParser.new do |opts|
      opts.banner = "Usage: lastpass_api [options] <site>"

      opts.on('--help', '') do |v|
        puts %(
          Display this helpful helping message.
          ToDo: content
        )
        exit
      end

      opts.on('-lLOGIN', '--login=LOGIN', 'Login name') do |l|
        options['name'] = l
      end

      opts.on('-pPASSWORD', '--pass=PASSWORD', 'Password') do |p|
        options['pass'] = p
      end

      opts.on('cTYPE', '--cache=TYPE') do |type|
        raise "Unknown cache option: #{type}" unless ['nocache', 'reload', 'normal'].include? type
        options['cache'] = type
      end
    end.parse!

    options
  end

  def self.load_config
    config = YAML.load_file('config.yml')
  rescue Errno::ENOENT
    {}
  end
end