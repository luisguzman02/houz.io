class User
  include Mongoid::Document
  include Mongoid::Timestamps
  
  field :email, type: String
  field :role, type: Symbol, default: :owner
  field :active, type: Boolean, default: true
  field :first_name, type: String
  field :last_name, type: String
  field :password
  field :title, type: String
  field :nickname, type: String
  
  has_many :bookings, class_name: 'Reservation', inverse_of: :tenant
  has_many :reservations, inverse_of: :user
  has_and_belongs_to_many :agent_accounts, class_name: 'Account', inverse_of: :owners
  has_one :account
  embeds_one :contact, as: :contactable,  autobuild: true
  has_many :properties, dependent: :destroy
  belongs_to :company_account, class_name: 'Account', inverse_of: :agents

  validates_presence_of :email, :first_name, :last_name, :active, :password, :role
  validates_length_of :password, :within => 6..128
  validates_inclusion_of :role, :in => [:owner, :tenant, :agent, :admin]
end