class Api::V1::ItemsController < ApplicationController
  def index
    render json: Item.all, status: 200
  end

  def show
    if params[:api_key] == ENV["API_KEY"]
    render json: Item.find(params[:id]), status: 200
  else
    raise ActionController::RoutingError.new('Not Found')
  end
  end

  def create
    render json: Item.create(item_params), status: 201
  end

  def update
    render json: Item.update(params[:id], item_params), status: 200
  end

  def destroy
    render json: Item.delete(params[:id]), status: 204
  end

  private

    def item_params
      params.require(:item).permit(:name, :description, :image, :price)
    end

end
