class PageController < ApplicationController
  def auth
  end

  def home
    if !session[:access_token]
        redirect_to auth_path
    end

    @my_blocos = User.find(session[:user_id]).blocos
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
    @user_id = session[:user_id]
    @bloco = Bloco.find(params[:id])
    @t = @bloco->with('user').find(params[session[:user_id]])
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

  def join_user_and_bloco
    if !session[:access_token]
        redirect_to auth_path
    end

    user_id = params[:user_id]
    bloco_id = params[:bloco_id]

    my_bloco = MyBloco.new({:user_id => user_id, :bloco_id => bloco_id})
    my_bloco.save
    redirect_to home_path
  end

end
