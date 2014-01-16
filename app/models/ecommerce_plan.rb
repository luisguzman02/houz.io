class EcommercePlan
  include Mongoid::Document
  include Mongoid::Timestamps

  field :name, type: String
  field :price, type: Float
  field :description, type: String
  field :num_items_allowed, type: Integer, default: 1

  validates_presence_of :name, :price, :description, :num_items_allowed
  validates_uniqueness_of :name

  def self.free
    self.find_by(:price => 0)
  end
end