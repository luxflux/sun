class Location < ActiveRecord::Base
  has_many :ports

  validates :name, presence: true
  validates :name, uniqueness: true

  def to_s
    name
  end
end
