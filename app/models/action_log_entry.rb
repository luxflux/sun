class ActionLogEntry < ActiveRecord::Base
  belongs_to :port

  validates :port, presence: true
  validates :state, presence: true
end
