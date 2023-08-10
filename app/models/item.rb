class Item < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :category
  belongs_to :conditon
  belongs_to :shipping_bear
  belongs_to :prefecture
  belongs_to :preparation_date

  belongs_to :user
  has_one_attached :image, dependent: :destroy

  validates :image,             presence: true
  validates :name,              presence: true, length: { maximum: 40 }
  validates :description,       presence: true, length: { maximum: 1000 }
  validates :category,          presence: true
  validates :condition,         presence: true
  validates :shipping_bear,     presence: true
  validates :prefecture,        presence: true
  validates :preparation_date,  presence: true
  validates :price,             presence: true, numericality: { only_integer: true, in: 300..9999999 }
end
