class Item < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :category, presence: true

  belongs_to :user
  
  has_one_attached :image, dependent: :destroy
  validates :image, presence: true

  validates :name, presence: true
  validates :description, presence: true
  validates :price, presence: true, numericality: { in: 300..9999999 }
end
