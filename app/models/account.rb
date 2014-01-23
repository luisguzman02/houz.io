class Account
  include Mongoid::Document
  include Mongoid::Timestamps

  belongs_to :user
  belongs_to :company
  has_and_belongs_to_many :owners, class_name: 'User', inverse_of: :agent_accounts
  has_and_belongs_to_many :tenants, class_name: 'User', inverse_of: nil  
  has_many :agents, class_name: 'User', inverse_of: :company_account
  belongs_to :ecommerce_plan
  has_many :properties
  has_many :rates

  validates_presence_of :user, :ecommerce_plan

  after_create :create_default_rates

  def can_add_properties?
    properties.count < ecommerce_plan.num_items_allowed
  end

  private 

  def create_default_rates
    self.rates.create :name => 'Default', :value => '1'
    self.rates.create :name => 'Cleaning', :value => '1', :type => :rate
  end
end