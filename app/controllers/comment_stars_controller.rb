class CommentStarsController < ApplicationController
  before_action :set_comment_star, only: [:show, :update, :destroy]

  # GET /comment_stars
  def index
    @comment_stars = CommentStar.all

    render json: @comment_stars
  end

  # GET /comment_stars/1
  def show
    render json: @comment_star
  end

  # POST /comment_stars
  def create
    @comment_star = CommentStar.new(comment_star_params)

    if @comment_star.save
      render json: @comment_star, status: :created, location: @comment_star
    else
      render json: @comment_star.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /comment_stars/1
  def update
    if @comment_star.update(comment_star_params)
      render json: @comment_star
    else
      render json: @comment_star.errors, status: :unprocessable_entity
    end
  end

  # DELETE /comment_stars/1
  def destroy
    @comment_star.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_comment_star
      @comment_star = CommentStar.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def comment_star_params
      params.require(:comment_star).permit(:comment_id, :created_by_id)
    end
end
