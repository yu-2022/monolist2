class ListsController < ApplicationController
  before_action :authenticate_user!, except: [:index]
  before_action :set_list, only: [:show, :edit, :update, :destroy]

  def index
    @lists = List.limit(10).includes(:fav_users).sort {|a,b| b.liked_users.size <=> a.liked_users.size}
  end

  def new
    @list = List.new
    respond_to do |format|
      format.html
      format.js
    end
  end

  def create
    @list = List.new(list_params)
    if @list.save
      redirect_to users_path(id: current_user.id)
    else
      render :new
    end
  end

  def show
    @user = @list.user
    @lists = @user.lists
    @item = Item.new
    @items = @list.items
  end

  def edit
    if @list.user_id != current_user.id
      redirect_to root_path
    else
      respond_to do |format|
        format.html
        format.js
      end
    end
  end

  def update
    if @list.update(list_params)
      redirect_to list_path(id: @list.id)
    else
      render :edit
    end
  end

  def destroy
    @list.destroy if @list.user_id == current_user.id
    redirect_to users_path(id: current_user.id)
  end

  def search
    @lists = List.limit(20).search(params[:keyword])
  end

  private

  def list_params
    params.require(:list).permit(:list_name, :list_text, :privacy_id).merge(user_id: current_user.id)
  end

  def set_list
    @list = List.find(params[:id])
  end

end
