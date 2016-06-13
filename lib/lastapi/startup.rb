class Startup
  def self.run
    Config.load

    AccountsCache.remove_cache if ['remove'].include? Config.get['cache']
    accounts = AccountsCache.load_cache unless ['nocache', 'remove', 'reload'].include? Config.get['cache']
    accounts ||= AccountsCache.reload_cache unless ['nocache', 'remove'].include? Config.get['cache']
    accounts ||= Accounts.new

    if accounts == nil
      puts "No Accounts there"
      exit
    end

    password = accounts.get_password ARGV.pop

    if Config.get['clipboard']
      `echo #{password} | xsel -i --clipboard`
    else
      puts password
    end
  end
end
