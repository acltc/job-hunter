class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action do
    unless current_user && current_user.admin?
      flash[:notice] = "You do not have access to that page."
      redirect_to leads_path
    end
  end

  def index
    @users = User.all
  end

  def import
    User.import(params[:file])
    flash[:notice] = "Users created!"
    redirect_to users_path
  end

end
