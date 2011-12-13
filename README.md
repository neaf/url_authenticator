UrlAuthenticator
================

A library to sign and verify signed URLs.

Usage
-----

	require "url_authenticator"
	
	url = "http://example.com"
	signed_url = UrlAuthenticator.sign(url, "your_secret")
	# => "http://example.com?expires=1323787739&signature=c064a2cbda335ed784387ad69abd1880"

	UrlAuthenticator.verify(signed_url, "your_secret") # => true



	# If you want to extend expire period (20 minutes default):
	expires_at = Time.now + 40 * 60
	signed_url = UrlAuthenticator.sign(url, "your_secret", expires_at)
	# => "http://example.com?expires=1323789137&signature=813b0e16bd5bc3618dd84d2274e9c212"


	# If you want to use different time for expiration verification (default Time.now):
	now = Time.new(2000, 7, 7, 12, 30)
	UrlAuthenticator.verify(signed_url, "your_secret", now) # => true

### Settings

	UrlAuthenticator.default_secre = "your_secret"

License
-------

[MIT License](https://github.com/neaf/url_authenticator/blob/master/MIT-LICENSE)
