class Task < ActiveRecord::Base
  attr_accessible :date_end, :date_start, :name, :text, :user_id
end
