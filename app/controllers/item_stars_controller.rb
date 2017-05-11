class ItemStarsController < ApplicationController
  before_action :set_item_star, only: [:show, :update, :destroy]

  # GET /item_stars
  def index
    @item_stars = ItemStar.all

    render json: @item_stars
  end

  # GET /item_stars/1
  def show
    render json: @item_star
  end

  # POST /item_stars
  def create
    @item_star = ItemStar.new(item_star_params)

    if @item_star.save
      render json: @item_star, status: :created, location: @item_star
    else
      render json: @item_star.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /item_stars/1
  def update
    if @item_star.update(item_star_params)
      render json: @item_star
    else
      render json: @item_star.errors, status: :unprocessable_entity
    end
  end

  # DELETE /item_stars/1
  def destroy
    @item_star.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_item_star
      @item_star = ItemStar.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def item_star_params
      params.require(:item_star).permit(:item_id, :created_by_id)
    end
end
