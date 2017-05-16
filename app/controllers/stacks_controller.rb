class StacksController < ApplicationController
  before_action :set_stack, only: [:show, :update, :destroy, :addstar]
  before_action :authenticate_user!, only: [:create, :update, :destroy, :addstar, :delstar]

  # GET /lists/:list_id/stacks
  def index
    @stacks = Stack.where(list_id: params['list_id']).order('star_count DESC')
    render json: @stacks, include: [:created_by]
  end

  # GET /stacks/1
  def show
    render json: @stack
  end

  # POST /lists/:list_id/stacks
  def create
    @stack = Stack.new(stack_params)
    @stack.created_by = current_user

    if @stack.save
      render json: @stack, status: :created, location: @stack
    else
      render json: @stack.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /stacks/1
  def update
    if @stack.update(stack_params)
      render json: @stack
    else
      render json: @stack.errors, status: :unprocessable_entity
    end
  end

  # DELETE /stacks/1
  def destroy
    @stack.destroy
  end

  # POST /stacks/1/star
  def addstar
    @star = StackStar.new(stack_star_params)
    @star.created_by = current_user
    @star.stack = @stack
    if @star.save
      render json: @star
    else
      render json: @star.errors, status: :unprocessable_entity
    end
  end

  # DELETE /stacks/1/star
  def delstar
    @star = StackStar.where(stack_id: stack_id, created_by_id: current_user.id).first
    @star.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_stack
      @stack = Stack.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def stack_params
      params.require(:stack).permit(:list_id, :title, :note, :status)
    end

    # Only allow a trusted parameter "white list" through.
    def stack_star_params
      params.require(:stack_star).permit(:stack_id)
    end
end
