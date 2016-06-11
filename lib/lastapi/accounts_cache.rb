class AccountsCache
  CACHE_FILE = File.expand_path '~/.lastapi/accounts_cache.yml'

  def self.load_cache
    return false unless File.exists? CACHE_FILE
    YAML.load(Cipher.decrypt(YAML.load(File.open(CACHE_FILE, 'r:utf-8'))))
  end

  def self.reload_cache
    save_cache Accounts.new
  end

  def self.save_cache(accounts)
    makedir
    File.write(CACHE_FILE, Cipher.encrypt(accounts.to_yaml))
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
