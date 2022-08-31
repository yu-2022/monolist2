class FavoritesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_list, only: [:create, :destroy]

  def index
    @user = User.find(params[:id])
    @favorites = @user.favorites
  end

  def create
    Favorite.create(user_id: current_user.id, list_id: @list.id)
    redirect_to list_path(@list)
  end

  def destroy
    @favorite = Favorite.find_by(user_id: current_user.id, list_id: @list.id)
    @favorite.destroy
    redirect_to list_path(@list)
  end

  private
  def set_list
    @list = List.find(params[:list_id])
  end
end
