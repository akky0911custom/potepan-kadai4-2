class UsersController < ApplicationController
  before_action :authenticate_user, {only: [:show, :edit_profile, :update_account, :update_profile]}
  before_action :forbid_login_user, {only: [:new, :create, :login_form, :login]}
  before_action :ensure_correct_user, {only: [:edit_account, :edit_profile, :update_account, :update_profile]}

  def show
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
  end

  def create
    @user = User.create(user_create_params)
    if @user.save
      session[:user_id] = @user.id
      flash[:notice] = "ユーザー登録が完了しました"
      redirect_to user_path(@user)
    else
      flash[:notice] = "ユーザー登録に失敗しました"
      render "new"
    end
  end

  def edit_account
    @user = User.find(params[:id])
  end

  def edit_profile
    @user = User.find(params[:id])
  end

  def update_account
    @user = User.find(params[:id])
    if @user.update(user_account_params)
      flash[:notice] = "アカウント情報を編集しました"
      redirect_to user_path(@user)
    else
      flash[:notice] = "アカウント情報編集に失敗しました"
      render "edit_account"
    end
  end

  def update_profile
    @user = User.find(params[:id])
    if @user.update(user_profile_params)
      flash[:notice] = "アカウントプロフィールを編集しました"
      redirect_to user_path(@user)
    else
      flash[:notice] = "アカウントプロフィール編集に失敗しました"
      render "edit_profile"
    end
  end

  def login_form
  end

  def login
    @user = User.find_by(email: params[:email])
    if @user && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      flash[:notice] = "ログインしました"
      redirect_to :root
    else
      @error_message = "メールアドレスまたはパスワードが間違っています"
      @email = params[:email]
      @password = params[:password]
      render("users/login_form")
    end
  end

  def logout
    session[:user_id] = nil
    flash[:notice] = "ログアウトしました"
    redirect_to("/login")
  end

  def ensure_correct_user
    if @current_user.id != params[:id].to_i
      flash[:notice] = "権限がありません"
      redirect_to :root
    end
  end

private
  def user_create_params
    params.require(:user).permit(:name,:email,:image,:password,:password_confirmation).merge(image: "default_user.jpg")
  end

  def user_account_params
    params.require(:user).permit(:email,:password,:password_confirmation)
  end

  def user_profile_params
    params.require(:user).permit(:image,:name,:profile)
  end
end
