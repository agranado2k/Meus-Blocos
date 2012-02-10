class PageController < ApplicationController
  def auth
  end

  def home
    redirect_to auth_path unless session[:access_token]

    user_uid = session[:user_id] if session[:user_id]

    user_uid = params[:id] unless params[:id].nil?

    @my_blocos = Bloco.find(:all, :order => 'date', :joins => :my_blocos, :conditions => ['my_blocos.user_id = ?',user_uid])
  end

  def blocos
    if !session[:access_token]
        redirect_to auth_path
    end

    @blocos = Bloco.find(:all, :order => 'date', :conditions => ["date >= ?", Date.today])
  end

  def bloco
    if !session[:access_token]
        redirect_to auth_path
    end
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
    if !session[:access_token]
        redirect_to auth_path
    end
    @bloco = Bloco.find(params[:bloco_id])
  end

  def about
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

  def disconnect_user_and_bloco
    if !session[:access_token]
        redirect_to auth_path
    end

    user_id = params[:user_id]
    bloco_id = params[:bloco_id]

    my_bloco = MyBloco.find_by_user_id_and_bloco_id(user_id,bloco_id)
    my_bloco.destroy
    redirect_to home_path
  end

  def post_on_facebook
    if !session[:access_token]
        redirect_to auth_path
    end
    me = FbGraph::User.me(session[:access_token])
    me.feed!(
      :message => "Galera! Usem o Meus Blocos e criem sua lista de blocos para o carnaval 2012! Eu  fiz a minha, venha ve-la!!!",
      :picture => 'http://vocedeolhoemtudo.com.br/wp-content/gallery/blocos-de-carnaval/blocos-de-carnaval-7.jpg',
      :link => 'https://apps.facebook.com/meus-blocos/',
      :name => 'Meus Blocos',
      :description => "Venha fazer sua lista de Blocos para o Carnaval 2012"
    )

    redirect_to home_path
  end

end
