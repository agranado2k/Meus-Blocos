class PageController < ApplicationController
  def auth
  end

  def home
    if !session[:access_token]
        redirect_to auth_path
    end
  end

  def blocos
    if !session[:access_token]
        redirect_to auth_path
    end

    @blocos = Bloco.all
  end

  def bloco
    if !session[:access_token]
        redirect_to auth_path
    end

    @bloco = Bloco.find(params[:id])
  end

  def friends
    FbGraph.debug!
    if session[:access_token]
      @fb_user = FbGraph::User.me(session[:access_token]).fetch
    end
  end

  def maps
    if !session[:access_token]
        redirect_to auth_path
    end
  end

  def schedule
    if !session[:access_token]
        redirect_to auth_path
    end
  end

end
