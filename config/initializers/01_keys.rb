APP_CONFIG = YAML.load_file("#{Rails.root}/config/keys.yml")

def twitter_api_key
  ENV['TWITTER_API_KEY'] || APP_CONFIG['consumer_key']
end

def twitter_api_secret
  ENV['TWITTER_API_SECRET'] || APP_CONFIG['consumer_secret']
end

def twitter_user_token
  ENV['TWITTER_USER_TOKEN'] || APP_CONFIG['user_token']
end

def twitter_user_secret
  ENV['TWITTER_USER_SECRET'] || APP_CONFIG['user_secret']
end
