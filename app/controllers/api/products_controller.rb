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
end
