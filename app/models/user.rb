class User < ApplicationRecord
  has_secure_password
  has_many :blogs
  has_many :faqs
  has_many :contents
  has_one_attached :image
  has_many :products

  validates :name, presence: true
  validates :email,presence: true,uniqueness: true,format: {  with: /\A[\w+\-.]+@milaknights\.com\z/i,  message: "cant create with this mail "}
  validates :password, presence: true, length: { minimum: 6 }
  validate :email_unchanged, on: :update

  def email_unchanged
    if email_changed?
      errors.add(:email, "cannot be changed once set")
    end
  end
end
