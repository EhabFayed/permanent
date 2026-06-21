class Product < ApplicationRecord
  validates :description_ar, :description_en, presence: true

  scope :published, -> { where(is_published: true) }

  has_many :product_photos, dependent: :destroy
  accepts_nested_attributes_for :product_photos, allow_destroy: true

end
