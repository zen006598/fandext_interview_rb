class UsersController < ApplicationController
  def index
    @users = User.all
  end
  def new
    @user = User.new
  end

   def create
    @user = User.new(user_params)

    register_user = CreateUserProcedure.call(self, user: @user)

    if register_user.succeeded?
      flash.now[:success] = register_user.succeeded_message
      redirect_to users_path
    else
      flash.now[:warning] = register_user.error
      render :new
    end
  end

  private
  def user_params
    params.require(:user).permit(:email, :first_name, :last_name, :address)
  end
end
