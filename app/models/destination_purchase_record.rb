class DestinationPurchaseRecord
  include ActiveModel::Model
  attr_accessor :user_id, :product_id, :zip_code, :prefecture_id, :city, :address_1, :address_2, :phone_number, :token

  with_options presence: true do
    # purchase_record
    validates :user_id
    validates :product_id
    # destination
    validates :zip_code, format: { with: /\A[0-9]{3}-[0-9]{4}\z/, message: 'is invalid. Include hyphen(-)' }
    validates :prefecture_id, numericality: { other_than: 0, message: "can't be blank" }
    validates :city
    validates :address_1
    validates :phone_number, format: { with: /\A\d{10,11}\z/, message: 'is invalid' }


    # トークン
    validates :token, presence: true
  end

  def save
    purchase_record = PurchaseRecord.create(user_id: user_id, product_id: product_id)
    Destination.create(purchase_record_id: purchase_record.id, zip_code: zip_code, prefecture_id: prefecture_id, city: city,
                       address_1: address_1, address_2: address_2, phone_number: phone_number)
  end
end
