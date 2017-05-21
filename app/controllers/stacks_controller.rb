class StacksController < ApplicationController
  before_action :set_stack, only: [:show, :update, :destroy]
  before_action :authenticate_user!, only: [:create, :update, :destroy, :addlike, :dellike, :change_status]

  # GET /lists/:list_id/stacks
  def index
    @filter =
      case params['filter']
    when 'active'
      ['in_progress', 'pending']
    when 'resolved'
      ['resolved']
    when nil, 'all'
      ['resolved', 'in_progress', 'resolved']
    else
      render json: ['unrecognized filter error'], status: :bad_request
      return
    end

    @stacks = Stack.includes(:likes).where(
      list_id: params['list_id'],
      status: @filter,
    ).order('like_count DESC')

    @stacks.each { |stack| stack.current_user = current_user } if current_user
    render json: @stacks, include: [:created_by], methods: :liked
  end

  # GET /stacks/1
  def show
    render json: @stack, include: [:created_by, :comments], methods: :liked
  end

  # POST /lists/:list_id/stacks
  def create
    @stack = Stack.new(stack_params)
    @stack.created_by = current_user

    if @stack.save
      render json: @stack, include: [:created_by], status: :created, location: @stack, methods: :liked
    else
      render json: @stack.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /stacks/1
  def update

    # likeされているstackはupdate禁止
    if @stack.like_count > 0
      render json: ['forbidden_to_update_liked_stack'], status: :unprocessable_entity
      return
    end

    if @stack.update(stack_params)
      render json: @stack, include: [:created_by], methods: :liked
    else
      render json: @stack.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /stacks/1/status
  def change_status
    @stack = Stack.find(params[:stack_id])
    @stack.current_user = current_user
    if @stack.update(stack_status_params)
      render json: @stack, include: [:created_by], methods: :liked
    else
      render json: @stack.errors, status: :unprocessable_entity
    end
  end

  # DELETE /stacks/1
  def destroy
    @stack.destroy
    render json: @stack, include: [:created_by], methods: :liked
  end

  # POST /stacks/1/like
  def addlike
    @like = StackLike.new(stack_like_params)

    if @like.stack.created_by == current_user
      render json: ["cannot_like_on_own_stack"], status: :unprocessable_entity
      return
    end

    @like.created_by = current_user
    if @like.save
      @like.stack.current_user = current_user
      render json: @like.stack, include: [:created_by], methods: :liked
    else
      render json: @like.errors, status: :unprocessable_entity
    end
  end

  # DELETE /stacks/1/like
  def dellike
    @like = StackLike.where(stack_id: params[:stack_id], created_by_id: current_user.id).first
    @like.destroy
    @like.stack.current_user = current_user
    render json: @like.stack, include: [:created_by], methods: :liked
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_stack
      @stack = Stack.find(params[:id])
      @stack.current_user = current_user if current_user
    end

    # Only allow a trusted parameter "white list" through.
    def stack_params
      params.require(:stack).permit(:title, :note, :list_id)
    end

    def stack_status_params
      params.require(:stack).permit(:status)
    end

    # Only allow a trusted parameter "white list" through.
    def stack_like_params
      params.require(:stack_like).permit(:stack_id)
    end
end
