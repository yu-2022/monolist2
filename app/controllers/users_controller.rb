class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user_lists, only: [:index, :show]
  
  def index
    unless current_user.id == @user.id
      redirect_to root_path
    end
  end

  def show
  end

  private

  def set_user_lists
    @user = User.find(params[:id])
    @lists = @user.lists
  end
  
end
