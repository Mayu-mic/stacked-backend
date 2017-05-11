class ItemsController < ApplicationController
  before_action :set_item, only: [:show, :update, :destroy]
  before_action :authenticated_user!, only: [:create, :update, :destroy, :addstar, :delstar]

  # GET /lists/:list_id/items
  def index
    @items = Item.where(list_id: params['list_id']).order('star_count DESC')
    render json: @items
  end

  # GET /items/1
  def show
    render json: @item
  end

  # POST /lists/:list_id/items
  def create
    @item = Item.new(item_params)
    @item.created_by = current_user
    @item.star_count = 0

    if @item.save
      render json: @item, status: :created, location: @item
    else
      render json: @item.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /items/1
  def update
    if @item.update(item_params)
      render json: @item
    else
      render json: @item.errors, status: :unprocessable_entity
    end
  end

  # POST /items/1/star
  def addstar
    begin
      Item.transaction do
        @item_star = ItemStar.new(item_star_params)
        @item_star.created_by = current_user
        @item_star.save!
        @item = Item.find(params[:item_id])
        @item.star_count += 1
        @item.save!
      end
      render json: @item
    rescue => e
      render json: e, status: :unprocessable_entity
    end
  end

  # DELETE /items/1/star
  def delstar
    begin
      Item.transaction do
        @item_star = ItemStar.where(item_id: params['item_id'], created_by_id: current_user.id).first
        unless @item_star
          raise 'target not found.'
        end
        @item_star.destroy!
        @item = Item.find(params[:item_id])
        @item.star_count -= 1
        @item.save!
      end
      render json: @item
    rescue => e
      render json: e, status: :unprocessable_entity
    end
  end

  # DELETE /items/1
  def destroy
    @item.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_item
      @item = Item.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def item_params
      params.require(:item).permit(:list_id, :title, :note, :status)
    end

    # Only allow a trusted parameter "white list" through.
    def item_star_params
      params.require(:item_star).permit(:item_id)
    end
end
