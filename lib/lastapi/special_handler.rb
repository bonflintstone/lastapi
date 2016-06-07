class SpecialHandler
  def self.help_message
    puts %(
      Usage: lastapi [options] <account name regex>

      -f --config\tConfig FIle. Default ~/.config.yml
      -l --login\tUsername
      -p --pass\tPassword
      \tDont put it here, you will be prompted
      -c --cache\tCache Type. Possible values are:
      \tnocache reload normal remove

      All values can also be stored in the config.yaml file
    )
    exit
  end
end
