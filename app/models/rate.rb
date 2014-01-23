class Rate
	include Mongoid::Document
  include Mongoid::Timestamps

  field :name, type: String
  field :type, type: Symbol, default: :rent
  field :always_apply, type: Boolean, default: true
  field :hold_for_return, type: Boolean
  field :value_type, type: Symbol, default: :amount
  field :value, type: Float
  field :periodically, type: Boolean
	
  belongs_to :account
  has_and_belongs_to_many :properties

  validates_presence_of :name, :type, :account  
  validates_inclusion_of :type, :in => [:rent, :adjustment, :rate, :discount, :commision]
  validates_inclusion_of :value_type, :in => [:amount, :percentage]
end