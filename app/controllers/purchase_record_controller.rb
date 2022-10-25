class PurchaseRecordController < ApplicationController

  def index
    @product = Product.find(params[:product_id])
    @destination_purchase_record =DestinationPurchaseRecord.new
  end

  def create
    @product = Product.find(params[:product_id])
    @destination_purchase_record = @destination_purchase_record.new(destination_params)
  end

  def destination_params
    params.require(:destination_purchase_record).permit(:zip_code, :prefecture_id, :city, :address_1, :address_2,  :phone_number).merge(user_id: current_user.id, item_id: params[:product_id], token: params[:token])
  end
end
