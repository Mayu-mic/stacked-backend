class CommentsController < ApplicationController
  before_action :set_comment, only: [:destroy]
  before_action :authenticate_user!, only: [:create, :destroy, :addstar, :delstar]

  # GET /stacks/:stack_id/comments
  def index
    @comments = Comment.where(stack_id: params['stack_id'])

    @comments.each { |comment| comment.current_user = current_user } if current_user
    render json: @comments, include: [:created_by], methods: :liked
  end

  # POST /stacks/:stack_id/comments
  def create
    @comment = Comment.new(comment_params)
    @comment.created_by = current_user

    if @comment.save
      render json: @comment, include: [:created_by], status: :created, location: @comment, methods: :liked
    else
      render json: @comment.errors, status: :unprocessable_entity
    end
  end

  # DELETE /comments/1
  def destroy
    @comment.destroy
    render json: @comment, include: [:created_by], methods: :liked
  end

  # POST /comments/1/star
  def addstar
    @star = CommentStar.new(comment_star_params)

    if @star.comment.created_by == current_user
      render json: ["cannot_star_on_own_comment"], status: :unprocessable_entity
      return
    end

    @star.created_by = current_user
    if @star.save
      @star.comment.current_user = current_user
      render json: @star.comment, include: [:created_by], methods: :liked
    else
      render json: @star.errors, status: :unprocessable_entity
    end
  end

  # DELETE /comments/1/star
  def delstar
    @star = CommentStar.where(comment_id: params[:comment_id], created_by_id: current_user.id).first
    @star.destroy
    @star.comment.current_user = current_user
    render json: @star.comment, include: [:created_by], methods: :liked
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_comment
      @comment = Comment.find(params[:id])
      @comment.current_user = current_user if current_user
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
