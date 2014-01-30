class PropertyRate
  include Mongoid::Document
  include Mongoid::Timestamps

  field :value

  belongs_to :rate
  belongs_to :property
end