class Item < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :category
  belongs_to :condition
  belongs_to :shipping_bear
  belongs_to :prefecture
  belongs_to :preparation_date

  belongs_to :user
  has_one_attached :image, dependent: :destroy
  has_one :order

  validates :image,       presence: { message: "を設定してください" }
  validates :name,        presence: true, length: { maximum: 40 }
  validates :description, presence: true, length: { maximum: 1000 }
  with_options presence: true, numericality: { greater_than: 1, message: "を選択してください" } do
    validates :category_id
    validates :condition_id
    validates :shipping_bear_id
    validates :prefecture_id
    validates :preparation_date_id
  end
  validates :price, presence: true, numericality: { only_integer: true, in: 300..9_999_999, message: "は300円～9,999,999円で設定してください" }
end
