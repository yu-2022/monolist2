class ItemsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_item, only: [:edit, :update, :destroy]

  def create
    @item = Item.create(item_params)
    redirect_to list_path(@item.list)
  end

  def edit
    @list = @item.list
    @item_tags = @item.tags
    if @item.user_id != current_user.id
      redirect_to root_path
    else
      respond_to do |format|
        format.html
        format.js
      end
    end
  end

  def update
    tag_list = params[:item][:tag_name].split(',')
    if @item.update(item_params)
      @item.save_tag(tag_list) 
      redirect_to list_path(@item.list_id)
    else
      render :edit
    end
  end

  def destroy
    if @item.user_id != current_user.id
      redirect_to root_path
    else
      @item.destroy
      redirect_to list_path(@item.list)
    end
  end

  def search
    @user = User.find(params[:user_id])
    @lists = @user.lists
    @tag = Tag.find(params[:tag_id])
    @items = @tag.items.all
  end

  private

  def item_params
    params.require(:item).permit(:item_name, :item_text, :item_date, :image, tag_names: []).merge(list_id: params[:list_id], user_id: current_user.id)
  end

  def set_item
    @item = Item.find(params[:id])
  end

end
