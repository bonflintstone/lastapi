class Cypher
  def self.hash
    Digest::SHA1.hexdigest(salt + Config.get['pass'])
  end

  def self.set_salt(salt)
    @@salt = salt
  end

  def self.salt
    @@salt ||= SecureRandom.base64
  end

  def self.encrypt(data)
    data.to_yaml
  end

  def self.decrypt(data)
    YAML.load data
  end

  def self.encrypter
    return @encrypter if @encrypter
    @encrypter = OpenSSL::Cipher::AES256.new(:CBC).encrypt
    @encrypter.key = hash
    @encrypter.iv = salt
    @encrypter
  end

  def self.decrypter
    return @decrypter if @decrypter
    @decrypter = OpenSSL::Cipher::AES256.new(:CBC).encrypt
    @decrypter.key = hash
    @decrypter.iv = salt
    @decrypter
  end
end
