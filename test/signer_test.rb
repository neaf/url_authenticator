require File.dirname(__FILE__) + '/test_helper.rb'

class SignerTest < Test::Unit::TestCase
  EXPIRES_TIME = Time.utc(2011, 12, 12, 12, 30)
  SECRET = "password"
  VALID_URL = "http://themes.cardflick.co/themes?expires=1323693000&signature=adeb9e4c42661f04121f51bb53ddb10a"
  BASE_URL = "http://themes.cardflick.co/themes"

  def signer(time=EXPIRES_TIME)
    UrlAuthenticator::Signer.new(SECRET, time)
  end

  def test_sign_returns_signed_url
    assert_equal VALID_URL, signer.sign(BASE_URL)
  end
end