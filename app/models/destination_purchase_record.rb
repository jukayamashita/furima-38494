class DestinationPurchaseRecord < ApplicationRecord
    include ActiveModel::Model
  attr_accessor :user_id, :product_id, :zip_code, :prefecture_id, :city, :address_1, :address_2, :phone_number, :token

  with_options presence: true do
    # purchase_recordのバリデーション
    validates :user_id
    validates :product_id
    # destinationのバリデーション
    validates :zip_code, format: { with: /\A[0-9]{3}-[0-9]{4}\z/, message: 'is invalid. Include hyphen(-)' }
    validates :prefecture_id, numericality: { other_than: 0, message: "can't be blank" }
    validates :city
    validates :block
    validates :phone_number, format: { with: /\A[0-9]{11}\z/, message: 'is invalid' }
    # トークンのバリデーション
    validates :token
  end

  def save
    order = Destination.create(user_id: user_id, product_id: product_id)
    Destination.create(order_id: order.id, zip_code: zip_code, prefecture_id: prefecture_id, city: city, block: address_1, building: address_2, phone_number: phone_number)
  end
end
