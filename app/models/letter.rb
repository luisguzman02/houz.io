class Letter
  include Mongoid::Document
  include Mongoid::Timestamps

  field :name, type: String
  field :body, type: String
  field :document, default: :reservation

  belongs_to :company
  
  validates_presence_of :name, :body
  validates_inclusion_of :document, :in => [:reservation]
end