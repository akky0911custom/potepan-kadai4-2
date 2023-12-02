class Room < ApplicationRecord
  validates :name, presence: true
  mount_uploader :image, RoomImageUploader
  validates :address, presence: true
  validates :detail, presence: true
  validates :charge, {presence: true, numericality: {greater_than_or_equal_to: 1}}

end
