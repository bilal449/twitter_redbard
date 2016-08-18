class User < ActiveRecord::Base

	def self.from_omniauth(auth)
		user = where(provider: auth.provider, uid: auth.uid).first_or_create
		
		user.update(
			provider: auth.provider,
			uid: auth.uid,
			name: auth.info.name,
			oauth_token: auth.credentials.token,
			oauth_secret: auth.credentials.secret)
		
		user
  	end

  	def tweet(tweet)
	    client = Twitter::REST::Client.new do |config|
	      config.consumer_key        = Rails.application.config.twitter_key
	      config.consumer_secret     = Rails.application.config.twitter_secret
	      config.access_token        = oauth_token
	      config.access_token_secret = oauth_secret
	    end
	    
	    client.update(tweet)
  	end

end
