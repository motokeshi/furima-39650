require 'rails_helper'

RSpec.describe OrderAddress, type: :model do
  before do
    user = FactoryBot.create(:user)
    item = FactoryBot.create(:item)
    sleep 0.01
    @order_address = FactoryBot.build(:order_address, user_id: user.id, item_id: item.id)
  end
  describe '商品購入機能' do
    context '商品が購入できる場合' do
      it 'カード情報及び配送先が全て記載されていると購入できる' do
        expect(@order_address).to be_valid
      end
      it '電話番号が10ケタで入力されても購入できる' do
        @order_address.phone_number = 1_234_567_890
        expect(@order_address).to be_valid
      end
      it '建物名の項目のみ空欄でも購入できる' do
        @order_address.building_name = ''
        expect(@order_address).to be_valid
      end
    end
    context '商品を購入できない場合' do
      it 'カード情報（＝トークン）が無いと購入できない' do
        @order_address.token = ''
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("クレジットカード情報を入力してください")
      end
      it '郵便番号が無いと購入できない' do
        @order_address.postal_code = ''
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("郵便番号を入力してください")
      end
      it '郵便番号の前半が2ケタ以下だと購入できない' do
        @order_address.postal_code = '12-3456'
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include('郵便番号は不正な値です')
      end
      it '郵便番号の前半が4ケタ以上だと購入できない' do
        @order_address.postal_code = '1234-1234'
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include('郵便番号は不正な値です')
      end
      it '郵便番号にハイフンが無いと購入できない' do
        @order_address.postal_code = '1234567'
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include('郵便番号は不正な値です')
      end
      it '郵便番号の後半が3ケタ以下だと購入できない' do
        @order_address.postal_code = '123-456'
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include('郵便番号は不正な値です')
      end
      it '郵便番号の後半が5ケタ以上だと購入できない' do
        @order_address.postal_code = '123-45678'
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include('郵便番号は不正な値です')
      end
      it '郵便番号が全角で記入されていると購入できない' do
        @order_address.postal_code = '１２３－４５６７'
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include('郵便番号は不正な値です')
      end
      it '郵便番号に半角数字以外の半角文字を使うと購入できない' do
        @order_address.postal_code = 'a12-@345'
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include('郵便番号は不正な値です')
      end
      it '都道府県が選択されていないと購入できない' do
        @order_address.prefecture_id = 1
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include('都道府県を選択してください')
      end
      it '市区町村名が記入されていないと購入できない' do
        @order_address.city = ''
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("市区町村を入力してください")
      end
      it '番地が記入されていないと購入できない' do
        @order_address.address = ''
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("番地を入力してください")
      end
      it '電話番号が記入されていないと購入できない' do
        @order_address.phone_number = ''
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("電話番号を入力してください")
      end
      it '電話番号が9ケタ以下だと購入できない' do
        @order_address.phone_number = 123_456_789
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include('電話番号は不正な値です')
      end
      it '電話番号が12ケタ以上だと購入できない' do
        @order_address.phone_number = '090123456789'
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include('電話番号は不正な値です')
      end
      it '電話番号に半角数字以外が含まれていると購入できない' do
        @order_address.phone_number = '0a012345678'
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include('電話番号は不正な値です')
      end
      it '電話番号が全角で記入されていると購入できない' do
        @order_address.phone_number = '０９０１２３４５６７８'
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include('電話番号は不正な値です')
      end
      it 'ユーザーの情報が紐づいていないと購入できない' do
        @order_address.user_id = ''
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Userを入力してください")
      end
      it '商品の情報が紐づいていないと購入できない' do
        @order_address.item_id = ''
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Itemを入力してください")
      end
    end
  end
end
