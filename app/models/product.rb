class Product < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions

  belongs_to :user

  belongs_to :category
  belongs_to :condition
  belongs_to :delivery_charge
  belongs_to :days_to_ship
  belongs_to :prefecture

  with_options presence: true do
    validates :price, numericality: { only_integer: true, greater_than_or_equal_to: 300, less_than_or_equal_to: 9_999_999 } 
    validates :price, numericality: { with: /^[0-9]+$/ }
    validates :user_id
    validates :image
    validates :title
    validates :introduction
    validates :category_id
    validates :condition_id
    validates :delivery_charge_id
    validates :prefecture_id
    validates :days_to_ship_id
  end
  with_options numericality: { other_than: 0 } do
    validates :prefecture_id
    validates :category_id
    validates :condition_id
    validates :days_to_ship_id
    validates :delivery_charge_id
  end

  has_one_attached :image
end
