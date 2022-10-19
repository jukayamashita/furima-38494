class ProductsController < ApplicationController
  before_action :authenticate_user!, except: [:index]
  def index
  end

  def new
    @product = Product.new
  end

  def create
    @products = Product.new(product_params)

  end

  private

  def product_params
    params.require(:product).permit(:image, :name, :introduction, :condition_id, :category_id, :delivery_charge_id, :prefecture_id, :shipping_date_id, :price).merge(user_id: current_user.id)
  end

end
