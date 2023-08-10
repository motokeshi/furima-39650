class Item < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :category
  belongs_to :conditon
  belongs_to :shipping_bear

  belongs_to :user
  has_one_attached :image, dependent: :destroy

  validates :image,         presence: true
  validates :name,          presence: true
  validates :description,   presence: true
  validates :category,      presence: true
  validates :condition,     presence: true
  validates :shipping_bear, presence: true
  validates :price,         presence: true, numericality: { in: 300..9999999 }
end
