class PurchaseRecordController < ApplicationController
  before_action :authenticate_user!
  before_action :items_item, only: [:index, :create]

  def index
    items_item
    @destination_purchase_record = DestinationPurchaseRecord.new
    if @product.user_id == current_user.id || @product.purchase_record.present?
      redirect_to root_path
    else
      @destination_purchase_record = DestinationPurchaseRecord.new
    end
  end

  def create
    items_item
    @destination_purchase_record = DestinationPurchaseRecord.new(destination_params)
    if @destination_purchase_record.valid?
      pay_item
      @destination_purchase_record.save
      redirect_to root_path
    else
      render :index
    end
  end

  private

  def destination_params
    params.require(:destination_purchase_record).permit(:zip_code, :prefecture_id, :city, :address_1, :address_2, :phone_number).merge(
      user_id: current_user.id, product_id: params[:product_id], token: params[:token]
    )
  end

  def items_item
    @product = Product.find(params[:product_id])
  end


  def pay_item
    Payjp.api_key = ENV['PAYJP_SECRET_KEY']
    Payjp::Charge.create(
      amount: @product.price,
      card: destination_params[:token],
      currency: 'jpy'
    )
  end
end
