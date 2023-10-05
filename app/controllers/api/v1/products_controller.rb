class Api::V1::ProductsController < ApplicationController
  before_action :set_product, only: [:show, :update, :destroy]
  before_action :authorize_request
  def index
    @products = Product.all
    render json: ProductSerializer.new(@products).serializable_hash.to_json
  end

  def show
    render json: product
  end

  def create
    @product = Product.new(product_params)

    if @product.save
      render json: product, status: :created
    else
      render json: error, status: :unprocessable_entity
    end
  end

  def update
    if @product.update(product_params)
      render json: product
    else
      render json: error, status: :unprocessable_entity
    end
  end

  def destroy
    @product.destroy
    head :no_content
  end

  private

  def product
    ProductSerializer.new(@product).serializable_hash.to_json
  end

  def set_product
    @product = Product.find(params[:id])
  end

  def product_params
    params.require(:product).permit(:name, :description, :price, :thumbnail)
  end
end
