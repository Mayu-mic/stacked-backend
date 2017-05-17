class CommentsController < ApplicationController
  before_action :set_comment, only: [:destroy]
  before_action :authenticate_user!, only: [:create, :destroy, :addstar, :delstar]

  # GET /stacks/:stack_id/comments
  def index
    @comments = Comment.where(stack_id: params['stack_id'])

    render json: @comments, include: [:created_by]
  end

  # POST /stacks/:stack_id/comments
  def create
    @comment = Comment.new(comment_params)
    @comment.created_by = current_user

    if @comment.save
      render json: @comment, include: [:created_by], status: :created, location: @comment
    else
      render json: @comment.errors, status: :unprocessable_entity
    end
  end

  # DELETE /comments/1
  def destroy
    @comment.destroy
    render json: @comment, include: [:created_by]
  end

  # POST /comments/1/star
  def addstar
    @star = CommentStar.new(comment_star_params)
    @star.created_by = current_user
    if @star.save
      render json: @star.comment, include: [:created_by]
    else
      render json: @star.errors, status: :unprocessable_entity
    end
  end

  # DELETE /comments/1/star
  def delstar
    @star = CommentStar.where(comment_id: comment_id, created_by_id: current_user.id)
    @star.destroy
    render json: @star.comment, include: [:created_by]
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_comment
      @comment = Comment.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def comment_params
      params.require(:comment).permit(:stack_id, :body)
    end

    # Only allow a trusted parameter "white list" through.
    def comment_star_params
      params.require(:comment_star).permit(:comment_id)
    end
end
