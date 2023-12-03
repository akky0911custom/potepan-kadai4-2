class User < ApplicationRecord
  validates :name, presence: true
  validates :email, {presence: true, uniqueness: true}
  mount_uploader :image, UserImageUploader
  validates :password, presence: true
end
