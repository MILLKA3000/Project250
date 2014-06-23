class Task < ActiveRecord::Base
  belongs_to :user
  attr_accessible :date_end, :date_start, :name, :text, :user_id

  validates :name, presence: true
  validates :text, presence: true
  validates :date_start, presence: true
  validates :date_end, presence: true

  def u_id(id)
   self.user_id = id
  end
end
