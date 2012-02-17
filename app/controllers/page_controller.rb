class PageController < ApplicationController

  FB_APP_ID = YAML.load_file(Rails.root.join("config/facebook.yml"))[Rails.env]['app_id']

  def auth
  end

  def home
    redirect_to auth_path and return unless session[:access_token]

    @user_uid = session[:user_id] if session[:user_id]
    @user_uid = params[:id] unless params[:id].nil?

    @my_blocos = Bloco.find(:all, :order => 'date', :joins => :my_blocos, :conditions => ['my_blocos.user_id = ? and blocos.date >= ?',@user_uid, Date.today])
  end

  def blocos
    redirect_to auth_path and return unless session[:access_token]
    @user_id = session[:user_id]
    @blocos = Bloco.find(:all, :order => 'date', :conditions => ["date >= ?", Date.today])
  end

  def bloco
    redirect_to auth_path and return unless session[:access_token]

    @friends_in_bloco = []
    @user_id = session[:user_id]
    @bloco = Bloco.find(params[:id])
    friends = FbGraph::Query.new({:query1 => "SELECT uid2 FROM friend WHERE uid1 = me()",
                                    :query2 => "SELECT uid, pic_small, name FROM user WHERE is_app_user = #{FB_APP_ID} AND uid IN (SELECT uid2 FROM #query1)"}
                                  ).fetch(session[:access_token])[:query2]
    friends.each do |friend|
      @friends_in_bloco << friend unless MyBloco.find_by_user_id_and_bloco_id(friend[:uid], @bloco.id).nil?
    end

    @needToGo = MyBloco.find_by_user_id_and_bloco_id(session[:user_id], @bloco.id).nil?
  end

  def friends
    FbGraph.debug!
    if session[:access_token]
      @friends = FbGraph::Query.new({:query1 => "SELECT uid2 FROM friend WHERE uid1 = me()",
                                    :query2 => "SELECT uid, pic_small, name FROM user WHERE is_app_user = #{FB_APP_ID} AND uid IN (SELECT uid2 FROM #query1)"}
                                  ).fetch(session[:access_token])[:query2]
    end
  end

  def maps
    redirect_to auth_path and return unless session[:access_token]
    @bloco = Bloco.find(params[:bloco_id])
  end

  def about
    redirect_to auth_path unless session[:access_token]
  end

  def schedule
    redirect_to auth_path unless session[:access_token]
  end

  def join_user_and_bloco
    redirect_to auth_path and return unless session[:access_token]

    user_id = params[:user_id]
    bloco_id = params[:bloco_id]

    redirect_to home_path and return unless MyBloco.find_by_user_id_and_bloco_id(user_id,bloco_id).nil?


    my_bloco = MyBloco.new({:user_id => user_id, :bloco_id => bloco_id})
    my_bloco.save
    redirect_to home_path
  end

  def disconnect_user_and_bloco
    redirect_to auth_path and return unless session[:access_token]

    user_id = params[:user_id]
    bloco_id = params[:bloco_id]

    redirect_to home_path and return unless !MyBloco.find_by_user_id_and_bloco_id(user_id,bloco_id).nil?

    my_bloco = MyBloco.find_by_user_id_and_bloco_id(user_id,bloco_id)
    my_bloco.destroy
    redirect_to home_path
  end

  include ApplicationHelper
  def post_on_facebook
    redirect_to auth_path and return unless session[:access_token]

    me = FbGraph::User.me(session[:access_token])
    me.feed!(
      :message => "Acabo de criar o meu roteiro dos blocos de rua desse carnaval! Clique aqui para ver o meu e fazer o seu!",
      :picture =>  "http://www.meus-blocos.com.br/assets/meus-blocos.png",
      :link => "http://www.meus-blocos.com.br/home/#{session[:user_id]}",
      :name => 'Meus Blocos 2012',
      :description => "Crie e compartilhe com os seus amigos o seu roteiro da folia nesse carnaval de rua do Rio de Janeiro!"
    )

    redirect_to home_path
  end

end
