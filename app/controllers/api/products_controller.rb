class Api::ProductsController < ApplicationController
  skip_before_action :verify_authenticity_token, only: [:create]

  def index
    # EX Get http://localhost:3000/api/products

    @products = Product.where(status: 'active').order(created_at: :desc)
    render json: @products
  end

  def search
    # EX Get http://localhost:3000/api/products/search?productName=Fake Product 1

    @products = Product.where(nil)
    @products = @products.where('name LIKE ?', "%#{params[:productName]}%") if params[:productName].present?
    @products = @products.where(price: params[:minPrice]..params[:maxPrice]) if params[:minPrice].present? && params[:maxPrice].present?
    @products = @products.where(created_at: params[:minPostedDate]..params[:maxPostedDate]) if params[:minPostedDate].present? && params[:maxPostedDate].present?

    render json: @products
  end

  def create
    # EX Post http://localhost:3000/api/products
    # {
    #     "product": {
    #         "name": "Just created fake product",
    #         "price": 100.00
    #     }
    # }

    @product = Product.new(product_params)

    if @product.price > 10000
      render json: { error: "Price exceeds the maximum allowed amount of $10,000" }, status: :unprocessable_entity
      return
    elsif @product.price > 5000
      @product.status = 'pending_approval'
    else
      @product.status = 'active'
    end

    if @product.save
      render json: @product, status: :created
    else
      render json: @product.errors, status: :unprocessable_entity
    end
  end

  private
  def product_params
    params.require(:product).permit(:name, :price)
  end
end
