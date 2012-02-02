class PageController < ApplicationController
  def auth
  end

  def home
  end

  def blocos
  end

  def bloco
  end

  def friends
    FbGraph.debug!
    if session[:access_token]
      @fb_user = FbGraph::User.me(session[:access_token]).fetch
    end
  end

  def maps
  end

  def schedule
  end

end
