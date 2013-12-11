class Payment
  include Mongoid::Document
  include Mongoid::Timestamps

  field :method, type: Symbol, default: :credit_card
  field :note, type: String
  field :amount, type: Float

  embedded_in :reservation

  validates_inclusion_of :method, :in => [:cash, :credit_card, :check, :bank_transfer, :other]
  validates_presence_of :method, :amount
end