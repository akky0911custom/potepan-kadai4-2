class User < ApplicationRecord
  validates :name, presence: true
  validates :email, {presence: true, uniqueness: true}
  mount_uploader :image, UserImageUploader
  has_secure_password
  has_many :rooms, dependent: :destroy
  has_many :reservations, dependent: :destroy

end
