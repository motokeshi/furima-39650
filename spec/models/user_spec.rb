require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user = FactoryBot.build(:user)
  end
  describe 'ユーザー新規登録' do
    context '新規登録できるとき' do
      it '必要な情報が全て記載されている' do
        expect(@user).to be_valid
      end
    end
    context '新規登録できない時' do
      it 'ニックネームがない' do
        @user.nickname = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Nickname can't be blank")
      end
      it 'メールアドレスがない' do
        @user.email = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Email can't be blank")
      end
      it 'メールアドレスが既に登録されている' do
        @user.save
        @user2 = FactoryBot.build(:user, email: @user.email)
        @user2.valid?
        expect(@user2.errors.full_messages).to include('Email has already been taken')
      end
      it 'メールアドレスに@が含まれていない' do
        @user.email = 'test.com'
        @user.valid?
        expect(@user.errors.full_messages).to include('Email is invalid')
      end
      it 'パスワードがない' do
        @user.password = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Password can't be blank")
      end
      it 'パスワードとパスワード確認欄の内容が一致していない' do
        @user.password_confirmation = '111111a'
        @user.valid?
        expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
      end
      it 'パスワードが6文字未満' do
        @user.password = 'asd12'
        @user.password_confirmation = @user.password
        @user.valid?
        expect(@user.errors.full_messages).to include('Password is too short (minimum is 6 characters)')
      end
      it 'パスワードが129文字以上' do
        @user.password = Faker::Internet.password(min_length: 129, max_length: 135)
        @user.password_confirmation = @user.password
        @user.valid?
        expect(@user.errors.full_messages).to include('Password is too long (maximum is 128 characters)')
      end
      it '名字がない' do
        @user.last_name = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Last name can't be blank")
      end
      it '名字に全角の数字が含まれている' do
        @user.last_name = '田中１'
        @user.valid?
        expect(@user.errors.full_messages).to include('Last name is invalid')
      end
      it '名字に全角のアルファベットが含まれている' do
        @user.last_name = 'ＴＡ中'
        @user.valid?
        expect(@user.errors.full_messages).to include('Last name is invalid')
      end
      it '名字に全角の記号が含まれている' do
        @user.last_name = '※中'
        @user.valid?
        expect(@user.errors.full_messages).to include('Last name is invalid')
      end
      it '名字に半角のカタカナが含まれている' do
        @user.last_name = 'ﾀ中'
        @user.valid?
        expect(@user.errors.full_messages).to include('Last name is invalid')
      end
      it '名字に半角の数字が含まれている' do
        @user.last_name = '田中1'
        @user.valid?
        expect(@user.errors.full_messages).to include('Last name is invalid')
      end
      it '名字に半角のアルファベットが含まれている' do
        @user.last_name = 'ta中'
        @user.valid?
        expect(@user.errors.full_messages).to include('Last name is invalid')
      end
      it '名字に半角の記号が含まれている' do
        @user.last_name = '@中'
        @user.valid?
        expect(@user.errors.full_messages).to include('Last name is invalid')
      end
      it '名前がない' do
        @user.first_name = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("First name can't be blank")
      end
      it '名前に全角の数字が含まれている' do
        @user.first_name = '太郎１'
        @user.valid?
        expect(@user.errors.full_messages).to include('First name is invalid')
      end
      it '名前に全角のアルファベットが含まれている' do
        @user.first_name = 'ＴＡ郎'
        @user.valid?
        expect(@user.errors.full_messages).to include('First name is invalid')
      end
      it '名前に全角の記号が含まれている' do
        @user.first_name = '※郎'
        @user.valid?
        expect(@user.errors.full_messages).to include('First name is invalid')
      end
      it '名前に半角のカタカナが含まれている' do
        @user.first_name = 'ﾀ郎'
        @user.valid?
        expect(@user.errors.full_messages).to include('First name is invalid')
      end
      it '名前に半角の数字が含まれている' do
        @user.first_name = '1太郎'
        @user.valid?
        expect(@user.errors.full_messages).to include('First name is invalid')
      end
      it '名前に半角のアルファベットが含まれている' do
        @user.first_name = 'ta郎'
        @user.valid?
        expect(@user.errors.full_messages).to include('First name is invalid')
      end
      it '名前に半角の記号が含まれている' do
        @user.first_name = '@郎'
        @user.valid?
        expect(@user.errors.full_messages).to include('First name is invalid')
      end
      it '名字の読み仮名がない' do
        @user.last_name_kana = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Last name kana can't be blank")
      end
      it '名字の読み仮名にひらがなが含まれている' do
        @user.last_name_kana = 'タナか'
        @user.valid?
        expect(@user.errors.full_messages).to include('Last name kana is invalid')
      end
      it '名字の読み仮名に漢字が含まれている' do
        @user.last_name_kana = 'タ中'
        @user.valid?
        expect(@user.errors.full_messages).to include('Last name kana is invalid')
      end
      it '名字の読み仮名に全角の数字が含まれている' do
        @user.last_name_kana = 'タナカ１'
        @user.valid?
        expect(@user.errors.full_messages).to include('Last name kana is invalid')
      end
      it '名字の読み仮名に全角のアルファベットが含まれている' do
        @user.last_name_kana = 'タナＫＡ'
        @user.valid?
        expect(@user.errors.full_messages).to include('Last name kana is invalid')
      end
      it '名字の読み仮名に全角の記号が含まれている' do
        @user.last_name_kana = 'タナ＠'
        @user.valid?
        expect(@user.errors.full_messages).to include('Last name kana is invalid')
      end
      it '名字の読み仮名に半角のカタカナが含まれている' do
        @user.last_name_kana = 'タナｶ'
        @user.valid?
        expect(@user.errors.full_messages).to include('Last name kana is invalid')
      end
      it '名字の読み仮名に半角の数字が含まれている' do
        @user.last_name_kana = 'タナカ1'
        @user.valid?
        expect(@user.errors.full_messages).to include('Last name kana is invalid')
      end
      it '名字の読み仮名に半角のアルファベットが含まれている' do
        @user.last_name_kana = 'タナka'
        @user.valid?
        expect(@user.errors.full_messages).to include('Last name kana is invalid')
      end
      it '名字の読み仮名に半角の記号が含まれている' do
        @user.last_name_kana = 'タナ@'
        @user.valid?
        expect(@user.errors.full_messages).to include('Last name kana is invalid')
      end
      it '名前の読み仮名がない' do
        @user.first_name_kana = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("First name kana can't be blank")
      end
      it '名前の読み仮名にひらがなが含まれている' do
        @user.first_name_kana = 'タロう'
        @user.valid?
        expect(@user.errors.full_messages).to include('First name kana is invalid')
      end
      it '名前の読み仮名に漢字が含まれている' do
        @user.first_name_kana = '太ロウ'
        @user.valid?
        expect(@user.errors.full_messages).to include('First name kana is invalid')
      end
      it '名前の読み仮名に全角の数字が含まれている' do
        @user.first_name_kana = '１タロウ'
        @user.valid?
        expect(@user.errors.full_messages).to include('First name kana is invalid')
      end
      it '名前の読み仮名に全角のアルファベットが含まれている' do
        @user.first_name_kana = 'ＴＡロウ'
        @user.valid?
        expect(@user.errors.full_messages).to include('First name kana is invalid')
      end
      it '名前の読み仮名に全角の記号が含まれている' do
        @user.first_name_kana = '＠ロウ'
        @user.valid?
        expect(@user.errors.full_messages).to include('First name kana is invalid')
      end
      it '名前の読み仮名に半角のカタカナが含まれている' do
        @user.first_name_kana = 'ﾀロウ'
        @user.valid?
        expect(@user.errors.full_messages).to include('First name kana is invalid')
      end
      it '名前の読み仮名に半角の数字が含まれている' do
        @user.first_name_kana = '1タロウ'
        @user.valid?
        expect(@user.errors.full_messages).to include('First name kana is invalid')
      end
      it '名前の読み仮名に半角のアルファベットが含まれている' do
        @user.first_name_kana = 'タロu'
        @user.valid?
        expect(@user.errors.full_messages).to include('First name kana is invalid')
      end
      it '名前の読み仮名に半角の記号が含まれている' do
        @user.first_name_kana = '@ロウ'
        @user.valid?
        expect(@user.errors.full_messages).to include('First name kana is invalid')
      end
      it '誕生日がない' do
        @user.birthday = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Birthday can't be blank")
      end
    end
  end
end
