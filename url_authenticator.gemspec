Gem::Specification.new do |s|
  s.name = %q{url_authenticator}
  s.version = "0.0.1"
  s.date = %q{2011-12-13}
  s.summary = %q{Helper classes for signing and verifying signed URLs with expiration time.}
  s.authors = ["Tomasz Werbicki", "Tomasz Paczkowski"]
  s.homepage = "https://github.com/neaf/url_authenticator"
  s.files = `git ls-files`.split("\n")
  s.test_files = `git ls-files -- test/*`.split("\n")
  s.require_paths = ["lib"]
end
