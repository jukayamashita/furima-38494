class ProductsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :set_item, only: [:show, :edit, :update, :destroy]

  def index
    @product = Product.includes(:user).order('created_at DESC')
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

  def show
  end

  def edit
    if @product.user_id == current_user.id && @product.purchase_record.nil?
    else
      redirect_to root_path
    end
  end

  def update
    @product.update(product_params)
    if @product.valid?
      redirect_to product_path(product_params)
    else
      render 'edit'
    end
  end

  def destroy
    if @product.user_id == current_user.id
      @product.destroy
    else
      redirect_to root_path
    end
  end

  private

  def product_params
    params.require(:product).permit(:image, :title, :introduction, :condition_id, :category_id, :delivery_charge_id,
                                    :prefecture_id, :days_to_ship_id, :price).merge(user_id: current_user.id)
  end

  def set_item
    @product = Product.find(params[:id])
  end
end
