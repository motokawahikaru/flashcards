class UsersController < ApplicationController
  before_action :require_user_logged_in, only: [:show]
  
  def create
    @user = User.new(user_params)
    
    if @user.save
      flash[:success] = "ユーザを登録しました"
      redirect_to root_url
    else
      flash[:danger] = "ユーザの登録に失敗しました。"
      render :new
    end
  end

  def new
    @user = User.new
  end

  def show
    @user = User.find(params[:id])
    user_counts(@user)
  end
  
  private
  
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end
