class Property
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Slug

  field :name, type: String
  field :unit_type, type: Symbol, default: :house
  field :check_in, type: String
  field :check_out, type: String
  field :directions, type: String
  field :description, type: String
  field :active, type: Boolean,  default: true
  field :directions, type: String
  field :bathrooms, type: Integer, default: 1
  field :bedrooms, type: Integer, default: 1
  field :garages, type: Integer, default: 0
  field :bedding, type: Array
  field :tags, type: Array
  field :property_size, type: String
  field :minimum_days, type: Integer, default: 1
  field :num_persons_allowed, type: Integer, default: 4
  field :pets_allowed, type: Boolean, default: true

  slug :name, :scope => :account

  validates_presence_of :name, :unit_type, :contact, :description, :active, :account, :user
  validates_inclusion_of :bathrooms, :in => 0..10, :message => 'value must be a number between 0 and 10'
  validates_inclusion_of :bedrooms, :in => 0..20, :message => 'value must be a number between 0 and 20'
  validates_inclusion_of :garages, :in => 0..10, :message => 'value must be a number between 0 and 10'
  validates_length_of :name, :in => 4..50
  validates_inclusion_of :unit_type, :in => lambda { |p| p.class.utypes }
  validate :account_privileges

  embeds_one :contact, as: :contactable, autobuild: true
  embeds_many :payments
  belongs_to :user
  belongs_to :owner, class_name: 'User', inverse_of: :properties
  belongs_to :account
  has_many :reservations
  has_and_belongs_to_many :rates

  accepts_nested_attributes_for :contact

  before_validation do |p|    
    p.user = p.account.user unless user
  end

  def account_privileges
    errors.add(:account, 'does not have the enought credits to add more properties') unless account.can_add_properties?
  end

  def self.utypes
    [:house, :condo]
  end
end