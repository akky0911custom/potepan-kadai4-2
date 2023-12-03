class Reservation < ApplicationRecord
  validates :check_in_date, presence: true
  validates :check_out_date, presence: true
  validates :number_of_people, {presence: true, numericality: {greater_than_or_equal_to: 1}}
  validate :date_before_start
  validate :date_before_end
  belongs_to :user
  belongs_to :room

  def date_before_start
    if check_in_date.present? && check_in_date < Date.today
      errors.add(:check_in_date, "は今日以降のものを選択してください") 
    end
  end

  def date_before_end
    if check_in_date.present? && self.check_out_date.present? && check_in_date > self.check_out_date
      errors.add(:check_out_date, "はチェックイン以降のものを選択してください") 
    end
  end
end
