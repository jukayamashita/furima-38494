require 'rails_helper'
RSpec.describe Product, type: :model do
  before do
    @product = FactoryBot.create(:product)
  end

  describe '商品の出品' do
    context '商品の出品登録がうまくいくとき' do
      it '全て入力してあれば登録できる' do
        expect(@product).to be_valid
      end

      it 'カテゴリーが「---」以外であれば登録できる' do
        @product.category_id = 1
        expect(@product).to be_valid
      end

      it '商品の状態が「---」以外であれば登録できる' do
        @product.condition_id = 1
        expect(@product).to be_valid
      end

      it '配送料の負担が「---」以外であれば登録できる' do
        @product.delivery_charge_id = 1
        expect(@product).to be_valid
      end

      it '発送元の地域が「---」以外であれば登録できる' do
        @product.prefecture_id = 1
        expect(@product).to be_valid
      end

      it '発送までの日数が「---」以外であれば登録できる' do
        @product.days_to_ship_id = 1
        expect(@product).to be_valid
      end

      it '価格が半角数字でかつ300円〜9,999,999円であれば登録できる' do
        @product.price = 500
        expect(@product).to be_valid
      end
    end

    context '商品の出品登録がうまくいかないとき' do
      it 'ユーザー登録している人でないと出品できない' do
        @product.user_id = nil
        @product.valid?
        expect(@product.errors.full_messages).to include('User must exist')
      end

      it '１枚画像がないと出品できない' do
        @product.image = nil
        @product.valid?
        expect(@product.errors.full_messages).to include("Image can't be blank")
      end

      it '商品名が空欄だと出品できない' do
        @product.title = nil
        @product.valid?
        expect(@product.errors.full_messages).to include("Title can't be blank")
      end

      it '商品説明が空欄だと出品できない' do
        @product.introduction = nil
        @product.valid?
        expect(@product.errors.full_messages).to include("Introduction can't be blank")
      end

      it 'カテゴリーが「---」だと出品できない' do
        @product.category_id = 0
        @product.valid?
        expect(@product.errors.full_messages).to include('Category must be other than 0')
      end

      it '商品の状態が「---」だと出品できない' do
        @product.condition_id = 0
        @product.valid?
        expect(@product.errors.full_messages).to include('Condition must be other than 0')
      end

      it '発送元が「---」だと出品できない' do
        @product.prefecture_id = 0
        @product.valid?
        expect(@product.errors.full_messages).to include('Prefecture must be other than 0')
      end

      it '配送料の負担が「---」だと出品できない' do
        @product.delivery_charge_id = 0
        @product.valid?
        expect(@product.errors.full_messages).to include('Delivery charge must be other than 0')
      end

      it '配送料までの日数が「---」だと出品できない' do
        @product.days_to_ship_id = 0
        @product.valid?
        expect(@product.errors.full_messages).to include('Days to ship must be other than 0')
      end

      it '価格が空欄だと出品できない' do
        @product.price = nil
        @product.valid?
        expect(@product.errors.full_messages).to include("Price can't be blank")
      end

      it '価格が300円未満だと出品できない' do
        @product.price = 50
        @product.valid?
        expect(@product.errors.full_messages).to include('Price must be greater than or equal to 300')
      end

      it '価格が9,999,999円以上だと出品できない' do
        @product.price = 1_000_000_000
        @product.valid?
        expect(@product.errors.full_messages).to include('Price must be less than or equal to 9999999')
      end

      it '価格に半角数字以外が含まれている場合は出品できない' do
        @product.price = "300a"
        @product.valid?
        expect(@product.errors.full_messages).to include("Price is not a number")
      end
    end
  end
end
