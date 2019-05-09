class UsersController < ApplicationController
  before_action :require_user_logged_in, only: [:index, :show]
  def index
    @users = User.order(id: :desc).page(params[:page]).per(5)
  end

  def show
    @user = User.find(params[:id])
    @microposts = @user.microposts.order(id: :desc).page(params[:page])
    counts(@user)
  end

  def new
     @user = User.new
  end

  def create
     @user = User.new(user_params)

    if @user.save
      flash[:success] = 'ユーザを登録しました。'
      redirect_to @user
    else
      flash.now[:danger] = 'ユーザの登録に失敗しました。'
      render :new
    end
  end
  
  def edit
     @user = User.find(params[:id])
  end
  
  def update
    @user = User.find(params[:id])

    if @user.update(user_params)
      flash[:success] = '名前の変更 は正常におこなわれました'
      redirect_to @user
    else
      flash.now[:danger] = '名前の変更 はおこなわれませんでした'
      render :edit
    end
  end
  
   def destroy
    @user = User.find(params[:id])
    @user.destroy

    flash[:success] = 'アカウントは正常に削除されました'
    redirect_to users_url
   end
  
  
  
  def followings
    @user = User.find(params[:id])
    @followings = @user.followings.page(params[:page])
    counts(@user)
  end
  
  def followers
    @user = User.find(params[:id])
    @followers = @user.followers.page(params[:page])
    counts(@user)
  end
  
  def likes
    @micropost = Micropost.find(params[:content, :id])
    @likes = @user.likes.page(params[:page])
    counts(@micropost)
  end
  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end
