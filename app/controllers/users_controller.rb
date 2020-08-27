class UsersController < ApplicationController
    before_action :require_user_logged_in , only:[:edit,:update]
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      flash[:success] = 'ユーザを登録しました。'
      redirect_to login_url
    else
      flash.now[:danger] = 'ユーザの登録に失敗しました。'
      render :new
    end
  end
  
  def edit
    @user = User.find(current_user.id)
  end
  
  def update
    if @user.update(user_params)
      flash[:success] = 'user情報は正常に更新されました'
      redirect_to root_url
    else
      flash.now[:danger] = 'user情報は更新されませんでした'
      render :edit
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :target)
  end
end
