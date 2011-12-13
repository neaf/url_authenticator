require File.dirname(__FILE__) + '/test_helper.rb'

class UrlAuthenticatorTest < Test::Unit::TestCase
  SECRET = "password"
  BASE_URL = "http://themes.cardflick.co/themes"

  def test_api_cohesion
    signed = UrlAuthenticator.sign(BASE_URL, SECRET)
    assert UrlAuthenticator.verify(signed, SECRET)
  end

  def test_api_correctnes
    signed = UrlAuthenticator.sign(BASE_URL, "first")
    assert !UrlAuthenticator.verify(signed, "second")
  end
end