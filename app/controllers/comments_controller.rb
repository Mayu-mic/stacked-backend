class CommentsController < ApplicationController
  before_action :set_comment, only: [:destroy]
  before_action :authenticate_user!, only: [:create, :destroy, :addstar, :delstar]

  # GET /items/:item_id/comments
  def index
    @comments = Comment.where(item_id: params['item_id'])

    render json: @comments
  end

  # POST /items/:item_id/comments
  def create
    @comment = Comment.new(comment_params)
    @comment.created_by = current_user
    @comment.star_count = 0

    if @comment.save
      render json: @comment, status: :created, location: @comment
    else
      render json: @comment.errors, status: :unprocessable_entity
    end
  end

  # DELETE /comments/1
  def destroy
    @comment.destroy
  end

  # POST /comments/1/star
  def addstar
    begin
      Item.transaction do
        @comment_star = CommentStar.new(comment_star_params)
        @comment_star.created_by = current_user
        @comment_star.save!
        @comment = Comment.find(params[:comment_id])
        @comment.star_count += 1
        @comment.save!
      end
      render json: @comment
    rescue => e
      render json: e, status: :unprocessable_entity
    end
  end

  # DELETE /comments/1/star
  def delstar
    begin
      Item.transaction do
        @comment_star = CommentStar.where(comment_id: params['comment_id'], created_by_id: current_user.id).first
        unless @comment_star
          raise 'target not found.'
        end
        @comment_star.destroy!
        @comment = Comment.find(params[:comment_id])
        @comment.star_count -= 1
        @comment.save!
      end
      render json: @comment
    rescue => e
      render json: e, status: :unprocessable_entity
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_comment
      @comment = Comment.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def comment_params
      params.require(:comment).permit(:item_id, :body)
    end

    # Only allow a trusted parameter "white list" through.
    def comment_star_params
      params.require(:comment_star).permit(:comment_id)
    end
end
