class SpecialHandler
  def self.help_message
    puts %(
      Usage: lastapi [options] <account name regex>

      -f --config\tConfig FIle. Default ~/.config.yml
      -l --login\tUsername
      -p --pass\tPassword
      \t\tDont put it here, you will be prompted for input
      -c --cache\tCache Type. Possible values are:
      \t\tnocache reload normal remove
      -y --clipboard\tCopys the password to the clipboard instead of stdout
      \t\tValid xsel installation is needed. Support currently only for linux

      All values can also be stored in the specified config file
    )
    exit
  end
end
