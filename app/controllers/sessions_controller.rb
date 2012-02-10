class SessionsController < ApplicationController
  def create
    auth_hash = request.env['omniauth.auth']

    @auth = Authorization.find_or_create(auth_hash)
    if @auth
      session[:user_id] = @auth.uid
      session[:access_token] = @auth.access_token
    else
      User.find_by_uid(session[:user_id]).add_provider(auth_hash)
    end

    redirect_to home_path
  end

  def failure
    render :text => "Sorry, but you didn't allow access to our app!"
  end

  def destroy
    session[:user_id] = nil
    session[:access_token] = nil
    redirect_to home_path
  end

end
