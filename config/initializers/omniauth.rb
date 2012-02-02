Rails.application.config.middleware.use OmniAuth::Builder do
  CONFIG = YAML.load_file(Rails.root.join("config/facebook.yml"))[Rails.env]
  APP_ID = CONFIG['app_id']
  SECRET = CONFIG['secret_key']
  scope = { :scope => "email, offline_access, user_checkins, friends_checkins, publish_checkins, user_events, friends_events, user_likes, read_stream, publish_stream " }
  provider :facebook, APP_ID, SECRET, scope
end