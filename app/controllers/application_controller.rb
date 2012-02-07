class ApplicationController < ActionController::Base
  protect_from_forgery

  FB_APP_ID = YAML.load_file(Rails.root.join("config/facebook.yml"))[Rails.env]['app_id']
end
