Gem::Specification.new do |s|
  s.name        = 'lastapi'
  s.version     = '0.0.2'
  s.date        = '2016-06-07'
  s.summary     = "An usable command line wrapper around lastpass-ruby"
  s.description = "An usable command line wrapper around lastpass-ruby"
  s.authors     = ["Frederik Bonfanti"]
  s.email       = 'freddy@railslove.com'
  s.files       = ['lib/lastapi.rb', 'lib/lastapi/cypher.rb', 'lib/lastapi/startup.rb','lib/lastapi/config.rb' ,'lib/lastapi/special_handler.rb', 'lib/lastapi/accounts.rb', 'lib/lastapi/accounts_cache.rb']
  s.executables << 'lastapi'
  s.homepage    =
    'http://rubygems.org/gems/lastapi'
  s.license       = 'MIT'
end
