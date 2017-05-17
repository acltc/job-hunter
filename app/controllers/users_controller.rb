class UsersController < ApplicationController

  def index
    @users = User.all
  end

  def import
    User.import(params[:file])
    flash[:notice] = "Users created!"
    redirect_to users_path
  end

end
