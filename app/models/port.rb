class Port < ActiveRecord::Base
  belongs_to :location
  has_many :action_log_entries

  enum signal_type: %i(analog digital)

  validates :location, presence: true
  validates :type, presence: true
  validates :number, presence: true
  validates :signal_type, presence: true
  validates :name, presence: true, uniqueness: true

  def to_s
    "#{location}/#{name}"
  end
end
