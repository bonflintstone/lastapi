class AccountsCache
  CACHE_FILE = File.expand_path '~/.lastapi/accounts_cache.yml'

  def self.load_cache
    return false unless File.exists? CACHE_FILE
    salt, data = YAML.load_file(CACHE_FILE)
    Cypher.set_salt salt
    Cypher.decrypt data
  end

  def self.reload_cache
    save_cache Accounts.new
  end

  def self.save_cache(accounts)
    makedir
    File.write(CACHE_FILE, [Cypher.salt, Cypher.encrypt(accounts)].to_yaml)
    accounts
  end

  def self.remove_cache
    File.delete(CACHE_FILE)
  end

  private

  def self.makedir
    dirname = File.dirname(CACHE_FILE)
    unless File.directory?(dirname)
      FileUtils.mkdir_p(dirname)
    end
  end
end
