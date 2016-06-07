class Config
  def self.get
    @@config
  end

  def self.load
    @@config = {}
    default_config = {
      'cache' => 'normal',
      'config' => '~/.lastapi/config.yml'
    }

    from_input
    @@config = default_config.merge(@@config)
    @@config = from_yaml.merge(@@config)

    @@config['login'] ||= ask('Please input your Username: ')
    @@config['pass'] ||= ask('Please input your Password: ' ) {|q| q.echo = false}
  end

  def self.from_yaml
    config = YAML.load_file(File.expand_path @@config['config'])
  rescue Errno::ENOENT
    {}
  end

  def self.from_input
    OptionParser.new do |opts|
      opts.on('-h', '--help', '') { |v| SpecialHandler.help_message }
      opts.on('-lLOGIN', '--login=LOGIN', 'Login name') { |login| @@config['login'] = login }
      opts.on('-pPASSWORD', '--pass=PASSWORD', 'Password') { |pass| @@config['pass'] = pass }
      opts.on('-fFile', '--config=File', 'Config File') { |file| @@config['config'] = file }
      opts.on('-cTYPE', '--cache=TYPE', 'Cache Type') do |type|
        raise "Unknown cache option: #{type}" unless ['nocache', 'reload', 'normal', 'remove'].include? type
        @@config['cache'] = type
      end
    end.parse!
  end
end
