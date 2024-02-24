class Api::ProductsController < ApplicationController
  skip_before_action :verify_authenticity_token, only: [:create, :update]
  before_action :set_product, only: [:update]

  def index
    # Get http://localhost:3000/api/products

    @products = Product.where(status: 'active').order(created_at: :desc)
    render json: @products
  end

  def search
    # Get http://localhost:3000/api/products/search?productName=FakeProduct1

    @products = Product.where(nil)
    @products = @products.where('name LIKE ?', "%#{params[:productName]}%") if params[:productName].present?
    @products = @products.where(price: params[:minPrice]..params[:maxPrice]) if params[:minPrice].present? && params[:maxPrice].present?
    @products = @products.where(created_at: params[:minPostedDate]..params[:maxPostedDate]) if params[:minPostedDate].present? && params[:maxPostedDate].present?

    render json: @products
  end

  def create
    # Post http://localhost:3000/api/products
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

  def update
    # Put http://localhost:3000/api/products/:id
    # {
    #     "product": {
    #         "name": "Just updated fake product",
    #         "price": 100.00
    #     }
    # }

    @product.assign_attributes(product_params)

    if @product.price > (@product.price_was * 1.5)
      @product.status = 'pending_approval'
    end

    if @product.save
      render json: @product, status: :ok
    else
      render json: @product.errors, status: :unprocessable_entity
    end
  end

  private

  def set_product
    @product = Product.find(params[:id])
  end

  def product_params
    params.require(:product).permit(:name, :price, :status)
  end
end
