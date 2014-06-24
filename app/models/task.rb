class Task < ActiveRecord::Base
  has_many :journals
  has_many :users, through: :journals
  attr_accessible :date_end, :date_start, :name, :text

  validates :name, presence: true
  validates :text, presence: true
  validates :date_start, presence: true
  validates :date_end, presence: true
end
