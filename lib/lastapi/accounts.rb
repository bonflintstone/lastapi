class Accounts
  attr_reader :accounts

  def initialize(config)
    @config = config
    @accounts = LastPass::Vault.open_remote(config['name'], config['pass']).accounts
  end

  def get_password(account_name)
    matching_accounts = @accounts.select do |account|
      "#{account.name} #{account.url}".match Regexp.new account_name
    end

    return 'No Account found' if matching_accounts.length == 0
    return matching_accounts.first.password if matching_accounts.length == 1

    return choose_account(matching_accounts).password
  end

  def choose_account(matching_accounts)
    puts "Found multiple matching Sites, choose one:"

    matching_accounts.each_with_index do |account, i|
      puts "[#{i}] #{account.name} => #{account.username}"
    end

    matching_accounts[ask('Choose one: ', Integer) { |q| q.in = 0...matching_accounts.length } ]
  end
end
