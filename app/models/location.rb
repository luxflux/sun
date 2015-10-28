class Location < ActiveRecord::Base
  has_many :ports
  has_many :inputs
  has_many :outputs

  validates :name, presence: true
  validates :name, uniqueness: true

  def to_s
    name
  end
end
