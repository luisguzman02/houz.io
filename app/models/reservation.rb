class Reservation
	include Mongoid::Document
	include Mongoid::Timestamps
  include Loggable

  RSV_TYPES = [:regular, :owner_time, :agent_block]

  field :rsv_type, type: Symbol, default: :regular
  field :check_in, type: Date
  field :check_out, type: Date
  field :num_adults, type: Integer, default: 2
  field :num_children, type: Integer, default: 0
  field :stage, type: Symbol
  field :notes, type: String

  validates_presence_of :rsv_type, :check_in, :check_out, :user, :property, :account
  validates_inclusion_of :rsv_type, :in => Reservation::RSV_TYPES
  validates_inclusion_of :num_adults, :in => 1..300
  validates_inclusion_of :num_children, :in => 0..300  

  belongs_to :property
  belongs_to :user, inverse_of: :reservations
  belongs_to :tenant, class_name: 'User', inverse_of: :bookings
  belongs_to :account  
  embeds_many :payments
  embeds_one :guest, :autobuild => true

  accepts_nested_attributes_for :guest

  before_validation do |r|    
    r.account ||= r.user.account
  end

  def logs
    Activity.where(:logeable_type => self.class, :logeable_id => self.id)
  end

  def nights_staying
    (check_out - check_in).to_i
  end

  def discard
    self.destroy
  end
end