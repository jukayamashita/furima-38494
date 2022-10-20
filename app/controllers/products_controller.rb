class ProductsController < ApplicationController
  before_action :authenticate_user!, except: [:index]

  def index
  end

  def new
    @product = Product.new
  end

  def create
    @product = Product.new(product_params)
    if @product.save
      redirect_to root_path
    else
      render :new
    end
  end

  private

  def product_params
    params.require(:product).permit(:image, :title, :introduction, :condition_id, :category_id, :delivery_charge_id, :prefecture_id, :days_to_ship_id, :price).merge(user_id: current_user.id)
  end

end
