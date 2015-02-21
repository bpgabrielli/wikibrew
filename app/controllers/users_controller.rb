class UsersController < ApplicationController

  def show
    @user = User.find(params[:id])
    @wikis = @user.wikis
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      flash[:success] = "Account downgraded"
      redirect_to root_path
    end
  end

private

  def user_params
    if current_user.role == 'premium'
      params.require(:user).permit(:name, :role)
    else
      params.require(:user).permit(:name)
    end
  end

end
