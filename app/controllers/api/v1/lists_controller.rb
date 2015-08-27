class Api::V1::ListsController < ApplicationController
  def index
    @lists = List.all
    render json: @lists
  end

  def show
    @list = List.find(params[:id])
    render json: @list
  end

  def create
    render json: List.create(list_params)
  end

  def update
    render json: List.update(params[:id], list_params)
  end

  def destroy
    render json: List.destroy(params[:id])
  end

  private

  def list_params
    params.require(:list).permit(:title)
  end
end
