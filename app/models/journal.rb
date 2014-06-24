class Journal < ActiveRecord::Base
  belongs_to :user
  belongs_to :task
  attr_accessible :note, :role_id, :task_id, :user_id
end
