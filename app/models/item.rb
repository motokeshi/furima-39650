class Item < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :category
  belongs_to :condition
  belongs_to :shipping_bear
  belongs_to :prefecture
  belongs_to :preparation_date

  belongs_to :user
  has_one_attached :image, dependent: :destroy

  validates :image,       presence: true
  validates :name,        presence: true, length: { maximum: 40 }
  validates :description, presence: true, length: { maximum: 1000 }
  with_options presence: true, numericality: { greater_than: 1 } do
    validates :category_id
    validates :condition_id
    validates :shipping_bear_id
    validates :prefecture_id
    validates :preparation_date_id
  end
  validates :price,       presence: true, numericality: { only_integer: true, in: 300..9999999 }
end
