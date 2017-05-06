
class UsersController < ApplicationController
  before_action :login_auth, only: :create
  def new
    @user = User.new
  end

  def create
    user = User.new(user_params)
    user.u_id = current_user.id
    if user.save
      render_msg 200
    else
      render_msg 422
    end
  end

  def show

  end

  def login
    @user = User.find_by(username: login_params[:username])
                .try(:authenticate, login_params[:password])
    if @user
      session[:current_user_id] = @user.id
      redirect_to '/admin/manage'
    else
      render 'guest/admin'
    end
  end

  def update
    @user = User.find_by(username: login_params[:username])
                .try(:authenticate, login_params[:password])
    render_msg
  end

  def logout
    session.delete(current_user.id) if current_user
    redirect_to '/'
  end

  private

  def login_params
    params.permit(:username, :password)
  end

  def user_params
    params.permit(:username, :password, :admin)
  end

  def update_info
    params.permit(:password, :new_password)
  end

end
