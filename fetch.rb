require "httparty"

class Fetch
  def initialize(config)
    @config = config
  end

  def try_something_new
    HTTParty.get "http://lastpass.com"
  end
end
