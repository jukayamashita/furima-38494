require 'rails_helper'

RSpec.describe DestinationPurchaseRecord, type: :model do
  before do
    user = FactoryBot.create(:user)
    product = FactoryBot.create(:product)
    @destination_purchase_record = FactoryBot.build(:destination_purchase_record, user_id: user.id, product_id: product.id)
  end

  describe '配送先情報の保存' do
    context '配送先情報の保存ができるとき' do
      it 'すべての値が正しく入力されていれば保存できること' do
        expect(@destination_purchase_record).to be_valid
      end
      it 'user_idが空でなければ保存できる' do
        @destination_purchase_record.user_id = 1
        expect(@destination_purchase_record).to be_valid
      end
      it 'product_idが空でなければ保存できる' do
        @destination_purchase_record.product_id = 1
        expect(@destination_purchase_record).to be_valid
      end
      it '郵便番号が「3桁＋ハイフン＋4桁」の組み合わせであれば保存できる' do
        @destination_purchase_record.zip_code = '123-4567'
        expect(@destination_purchase_record).to be_valid
      end
      it '都道府県が「---」以外かつ空でなければ保存できる' do
        @destination_purchase_record.prefecture_id = 1
        expect(@destination_purchase_record).to be_valid
      end
      it '市区町村が空でなければ保存できる' do
        @destination_purchase_record.city = '津市'
        expect(@destination_purchase_record).to be_valid
      end
      it '番地が空でなければ保存できる' do
        @destination_purchase_record.address_1 = '林１１−１'
        expect(@destination_purchase_record).to be_valid
      end
      it '建物名が空でも保存できる' do
        @destination_purchase_record.address_2 = nil
        expect(@destination_purchase_record).to be_valid
      end
      it '電話番号が11番桁以内かつハイフンなしであれば保存できる' do
        @destination_purchase_record.phone_number = 12_345_678_910
        expect(@destination_purchase_record).to be_valid
      end
    end

    context '配送先情報の保存ができないとき' do
      it 'user_idが空だと保存できない' do
        @destination_purchase_record.user_id = nil
        @destination_purchase_record.valid?
        expect(@destination_purchase_record.errors.full_messages).to include("User can't be blank")
      end
      it 'product_idが空だと保存できない' do
        @destination_purchase_record.product_id = nil
        @destination_purchase_record.valid?
        expect(@destination_purchase_record.errors.full_messages).to include("Product can't be blank")
      end
      it '郵便番号が空だと保存できないこと' do
        @destination_purchase_record.zip_code = nil
        @destination_purchase_record.valid?
        expect(@destination_purchase_record.errors.full_messages).to include("Zip code can't be blank")
      end
      it '郵便番号にハイフンがないと保存できないこと' do
        @destination_purchase_record.zip_code = 1_234_567
        @destination_purchase_record.valid?
        expect(@destination_purchase_record.errors.full_messages).to include('Zip code is invalid. Include hyphen(-)')
      end
      it '都道府県が「---」だと保存できないこと' do
        @destination_purchase_record.prefecture_id = 0
        @destination_purchase_record.valid?
        expect(@destination_purchase_record.errors.full_messages).to include("Prefecture can't be blank")
      end
      it '都道府県が空だと保存できないこと' do
        @destination_purchase_record.prefecture_id = nil
        @destination_purchase_record.valid?
        expect(@destination_purchase_record.errors.full_messages).to include("Prefecture can't be blank")
      end
      it '市区町村が空だと保存できないこと' do
        @destination_purchase_record.city = nil
        @destination_purchase_record.valid?
        expect(@destination_purchase_record.errors.full_messages).to include("City can't be blank")
      end
      it '番地が空だと保存できないこと' do
        @destination_purchase_record.address_1 = nil
        @destination_purchase_record.valid?
        expect(@destination_purchase_record.errors.full_messages).to include("Address 1 can't be blank")
      end
      it '電話番号が空だと保存できないこと' do
        @destination_purchase_record.phone_number = nil
        @destination_purchase_record.valid?
        expect(@destination_purchase_record.errors.full_messages).to include("Phone number can't be blank")
      end
      it '電話番号にハイフンがあると保存できないこと' do
        @destination_purchase_record.phone_number = '123 - 1234 - 1234'
        @destination_purchase_record.valid?
        expect(@destination_purchase_record.errors.full_messages).to include('Phone number is invalid')
      end
      it '電話番号が12桁以上あると保存できないこと' do
        @destination_purchase_record.phone_number = 12_345_678_910_123_111
        @destination_purchase_record.valid?
        expect(@destination_purchase_record.errors.full_messages).to include('Phone number is invalid')
      end
      it 'トークンが空だと保存できないこと' do
        @destination_purchase_record.token = nil
        @destination_purchase_record.valid?
        expect(@destination_purchase_record.errors.full_messages).to include("Token can't be blank")
      end

      it '電話番号が9桁以下だと保存できないこと' do
        @destination_purchase_record.phone_number = 123_321
        @destination_purchase_record.valid?
        expect(@destination_purchase_record.errors.full_messages).to include('Phone number is invalid')
      end
    end
  end
end
