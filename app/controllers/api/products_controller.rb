class Api::ProductsController < ApplicationController
  def index
    # EX http://localhost:3000/api/products

    # Retrieve active products sorted by the latest first
    @products = Product.where(status: 'active').order(created_at: :desc)

    render json: @products
  end

  def search
    #EX http://localhost:3000/api/products/search?productName=Fake Product 1

    # Apply filters based on the provided parameters
    @products = Product.where(nil) # Start with an all scope

    @products = @products.where('name LIKE ?', "%#{params[:productName]}%") if params[:productName].present?
    @products = @products.where(price: params[:minPrice]..params[:maxPrice]) if params[:minPrice].present? && params[:maxPrice].present?
    @products = @products.where(created_at: params[:minPostedDate]..params[:maxPostedDate]) if params[:minPostedDate].present? && params[:maxPostedDate].present?

    render json: @products
  end

  def create
    # Create a new product with the provided parameters
    @product = Product.new(product_params)

    # Set status based on price
    if @product.price > 10000
      render json: { error: "Price exceeds the maximum allowed amount of $10,000" }, status: :unprocessable_entity
      return
    elsif @product.price > 5000
      @product.status = 'pending_approval'
    else
      @product.status = 'active'
    end

    # Check if the product is valid and save it
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
