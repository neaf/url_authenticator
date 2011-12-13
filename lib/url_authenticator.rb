require "uri"
require "cgi"
require "openssl"

module UrlAuthenticator
  class << self
    attr_accessor :default_secret
  end

  def self.sign(url, secret = nil, expires = nil)
    secret ||= default_secret
    raise ArgumentError.new("Pass secret explicitly or set default_secret for UrlAuthenticator") unless secret
    Signer.new(secret, expires).sign(url)
  end

  def self.verify(url, secret = nil, now = nil)
    secret ||= default_secret
    raise ArgumentError.new("Pass secret explicitly or set default_secret for UrlAuthenticator") unless secret
    Verifier.new(secret, now).verify(url)
  end

  class Verifier
    def initialize(secret, now = nil)
      @secret = secret
      @now = (now || Time.now).utc.to_i
    end

    def verify(url)
      uri = URI.parse(url)
      params = CGI.parse(uri.query || "")
      expires = params["expires"].first.to_i
      signature = params["signature"].first
      signature_valid(url, signature) && @now <= expires
    end

    def signature_valid(url, signature)
      unsigned = url.sub(/(\?|&)signature=#{signature}/, "")
      OpenSSL::HMAC.hexdigest("md5", @secret, unsigned) == signature
    end
  end

  class Signer
    def initialize(secret, expires = nil)
      @secret = secret
      @expires = (expires || Time.now + 20 * 60).utc.to_i
    end

    def sign(url)
      url = append_param(url, "expires", @expires)
      signature = OpenSSL::HMAC.hexdigest("md5", @secret, url)
      append_param(url, "signature", signature)
    end

    def append_param(url, name, value)
      parameter = [name, value].join('=')
      separator = url.include?('?') ? '&' : '?'
      [url, parameter].join(separator)
    end
  end
end
