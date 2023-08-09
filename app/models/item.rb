class Item < ApplicationRecord
  belongs_to :user
  has_one_attached :image, dependent: :destroy
  validates :image, presence: true
  validates :name, presence: true
  validates :description, presence: true
  validates :price, presence: true, numericality: { in: 300..9999999 }
end
