class Reservation
	include Mongoid::Document
	include Mongoid::Timestamps

  field :rsv_type, type: Symbol, default: :regular
  field :check_in, type: Date
  field :check_out, type: Date
  field :num_adults, type: Integer, default: 1
  field :num_children, type: Integer, default: 0
  field :stage, type: Symbol
  field :notes, type: String

  validates_presence_of :rsv_type, :check_in, :check_out, :user, :property
  validates_inclusion_of :rsv_type, :in => [:regular, :owner_time, :agent_block]
  validates_inclusion_of :num_adults, :in => 1..300
  validates_inclusion_of :num_children, :in => 0..300  

  belongs_to :property
  belongs_to :user, inverse_of: :reservations
  belongs_to :tenant, class_name: 'User', inverse_of: :bookings
  embeds_many :activities
  embeds_many :payments

  def nights_staying
    (check_out - check_in).to_i
  end
end