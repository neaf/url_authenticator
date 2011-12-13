require File.dirname(__FILE__) + '/test_helper.rb'

class VerifierTest < Test::Unit::TestCase
  GENERATION_TIME = Time.utc(2011, 12, 12, 12, 0)
  EXPIRES_TIME = Time.utc(2011, 12, 12, 12, 30)
  SECRET = "password"
  VALID_URL = "http://themes.cardflick.co/themes?expires=1323693000&signature=adeb9e4c42661f04121f51bb53ddb10a"
  NO_EXPIRES_URL = "http://themes.cardflick.co/themes?signature=daac5be63c57def09223748d76d713f0"
  INVALID_URL = "http://themes.cardflick.co/themes?expires=1323693000&signature=adeb9e4c42661f04121f51bb53ddb20b"
  NO_SIG_URL = "http://themes.cardflick.co/themes?expires=1323693000"
  BASE_URL = "http://themes.cardflick.co/themes"

  def verifier(time=GENERATION_TIME)
    UrlAuthenticator::Verifier.new(SECRET, time)
  end

  def test_verify_returns_true_for_correct_signature
    assert verifier.verify(VALID_URL)
  end

  def test_verify_returns_false_when_timestamp_is_stale
    stale = EXPIRES_TIME + 1
    assert !verifier(stale).verify(VALID_URL)
  end

  def test_verify_returns_false_when_incorrect_signature
    assert !verifier.verify(INVALID_URL)
  end

  def test_verify_returns_false_when_no_signature
    assert !verifier.verify(NO_SIG_URL)
  end

  def test_verify_without_expires_is_false
    assert !verifier.verify(NO_EXPIRES_URL)
  end

  def test_verify_works_when_no_params
    assert !verifier.verify(BASE_URL)
  end
end
