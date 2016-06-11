class Cipher
  def self.hash
    OpenSSL::PKCS5.pbkdf2_hmac_sha1 Config.get['pass'], salt, 20000, 20
  end

  def self.salt
    @salt ||= SecureRandom.base64(12)
  end

  def self.encrypt(data)
      d = box :encrypt
      crypt = d.update(data) + d.final
      encode [salt, @iv, crypt]
  end

  def self.decrypt(data)
    @salt, @iv, crypt = decode data
    d = box :decrypt
    d.update(crypt) + d.final
  end

  def self.box(mode)
    box = OpenSSL::Cipher::AES.new(128, :CBC)
    box.send mode
    box.key = hash
    box.iv = @iv ||= box.random_iv
    box
  end

  def self.encode(strings)
    strings.map { |s| Base64.encode64(s).encode('utf-8') }
  end

  def self.decode(strings)
    strings.map { |s| Base64.decode64 s.encode('utf-8') }
  end
end
