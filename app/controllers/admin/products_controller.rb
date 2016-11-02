class Admin::ProductsController < ApplicationController

  before_action :authenticate_user!
  before_action :require_is_admin

  layout "admin"

  def index
    @products = Product.all
  end

  def new
    @product = Product.new
  end

  def create
    @product = Product.new(product_params)
    if @product.save
      flash[:notice]="Create Success"
      redirect_to admin_products_path
    else
      render :new
    end
  end

  def show
    @product = Product.find(params[:id])
  end

  def edit
    @product = Product.find(params[:id])
  end

  def update
    @product = Product.find(params[:id])
    if @product.update(product_params)
      redirect_to admin_products_path,notice:"Update Success"
    else
      render :edit
    end
  end

  def destroy
    @product = Product.find(params[:id])
    @product.destroy
    redirect_to admin_products_path
    flash[:alert]="Product Deleted"
  end

  private
  def product_params
    params.require(:product).permit(:title,:description,:quantity,:price,:image)
  end
end
