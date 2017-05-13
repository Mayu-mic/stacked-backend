class ListsController < ApplicationController
  before_action :set_list, only: [:update]
  before_action :authenticate_user!, only: [:create, :update]

  # GET /lists
  def index
    status = params['status']
    if params['status'] == 'archived'
      @lists = List.where(status: :archived)
    else
      @lists = List.where(status: :active)
    end

    render json: @lists
  end

  # POST /lists
  def create
    @list = List.new(list_params)
    @list.created_by = current_user

    if @list.save
      render json: @list, status: :created, location: @list
    else
      render json: @list.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /lists/1
  def update
    if @list.update(list_params)
      render json: @list
    else
      render json: @list.errors, status: :unprocessable_entity
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_list
      @list = List.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def list_params
      params.require(:list).permit(:name, :status)
    end
end
