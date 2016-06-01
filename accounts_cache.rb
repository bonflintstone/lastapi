require 'yaml'

class AccountsCache
  FILE = 'accounts_cache.yml'

  def self.read_from_cache
    return false unless File.exists? FILE
    YAML.load_file(FILE)
  end

  def self.reload_cache(config)
    accounts = Accounts.new(config)
    save_cache accounts
    accounts
  end

  def self.save_cache(accounts)
    File.write(FILE, accounts.to_yaml)
  end
end
