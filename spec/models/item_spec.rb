require 'rails_helper'

RSpec.describe Item, type: :model do
  before do
    @item = FactoryBot.build(:item)
  end
  describe '商品出品機能' do
    context '商品を出品できるとき' do
      it '必要な項目が全て記載されている' do
        expect(@item).to be_valid
      end
    end
    context '商品出品できない時' do
      it 'ユーザーの情報が紐づいていないと出品できない' do
        @item.user = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("User must exist")
      end
      it '画像が無いと出品できない' do
        @item.image = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("Image can't be blank")
      end
      it '商品名が無いと出品できない' do
        @item.name = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("Name can't be blank")
      end
      it '商品名が41文字以上だと出品できない' do
        @item.name = Faker::Lorem.characters(number: 41)
        @item.valid?
        expect(@item.errors.full_messages).to include("Name is too long (maximum is 40 characters)")
      end
      it '商品の説明が無いと出品できない' do
        @item.description = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("Description can't be blank")
      end
      it '商品の説明が1001文字以上だと出品できない' do
        @item.description = Faker::Lorem.paragraph_by_chars(number: 1001, supplemental: false)
        @item.valid?
        expect(@item.errors.full_messages).to include("Description is too long (maximum is 1000 characters)")
      end
      it 'カテゴリーが選ばれていないと出品できない' do
        @item.category_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include("Category must be greater than 1")
      end
      it '商品の状態が選ばれていないと出品できない' do
        @item.condition_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include("Condition must be greater than 1")
      end
      it '配送料の負担の情報が選ばれていないと出品できない' do
        @item.shipping_bear_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include("Shipping bear must be greater than 1")
      end
      it '発送元の地域の情報が選ばれていないと出品できない' do
        @item.prefecture_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include("Prefecture must be greater than 1")
      end
      it '発送までの日数の情報が選ばれていないと出品できない' do
        @item.preparation_date_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include("Preparation date must be greater than 1")
      end
      it '価格が入力されていないと出品できない' do
        @item.price = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("Price can't be blank")
      end
      it '価格が299円以下だと出品できない' do
        @item.price = 299
        @item.valid?
        expect(@item.errors.full_messages).to include("Price must be in 300..9999999")
      end
      it '価格が10,000,000円以上だと出品できない' do
        @item.price = 10000000
        @item.valid?
        expect(@item.errors.full_messages).to include("Price must be in 300..9999999")
      end
      it '価格に小数点以下が入力されていると出品できない' do
        @item.price = 300.1
        @item.valid?
        expect(@item.errors.full_messages).to include("Price must be an integer")
      end
      it '価格に半角の記号が使われていると出品できない' do
        @item.price = "@300"
        @item.valid?
        expect(@item.errors.full_messages).to include("Price is not a number")
      end
      it '価格に半角のアルファベットが使われていると出品できない' do
        @item.price = "a300"
        @item.valid?
        expect(@item.errors.full_messages).to include("Price is not a number")
      end
      it '価格に全角の数字が使われていると出品できない' do
        @item.price = "１300"
        @item.valid?
        expect(@item.errors.full_messages).to include("Price is not a number")
      end
      it '価格に全角の記号が使われていると出品できない' do
        @item.price = "＠300"
        @item.valid?
        expect(@item.errors.full_messages).to include("Price is not a number")
      end
      it '価格に全角のひらがなが使われていると出品できない' do
        @item.price = "あ300"
        @item.valid?
        expect(@item.errors.full_messages).to include("Price is not a number")
      end
      it '価格に全角のカタカナが使われていると出品できない' do
        @item.price = "ア300"
        @item.valid?
        expect(@item.errors.full_messages).to include("Price is not a number")
      end
      it '価格に全角の漢字が使われていると出品できない' do
        @item.price = "亜300"
        @item.valid?
        expect(@item.errors.full_messages).to include("Price is not a number")
      end
      it '価格に全角のアルファベットが使われていると出品できない' do
        @item.price = "Ａ300"
        @item.valid?
        expect(@item.errors.full_messages).to include("Price is not a number")
      end
    end
  end
end
