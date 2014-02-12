class PropertyRate
  include Mongoid::Document
  include Mongoid::Timestamps

  field :value
  belongs_to :rate  
  embedded_in :contact
end