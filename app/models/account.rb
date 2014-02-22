class Account
  include Mongoid::Document
  include Mongoid::Timestamps

  belongs_to :user
  belongs_to :company
  has_and_belongs_to_many :owners, class_name: 'User', inverse_of: :agent_accounts
  has_and_belongs_to_many :tenants, class_name: 'User', inverse_of: nil  
  has_many :agents, class_name: 'User', inverse_of: :company_account
  has_many :reservations
  belongs_to :ecommerce_plan
  has_many :properties
  embeds_many :rates, :as => :rateable

  validates_presence_of :user

  after_validation :create_default_rates

  def can_add_properties?
    properties.count < ecommerce_plan.num_items_allowed
  end

  def package
    ecommerce_plan.name if ecommerce_plan.present?
    diff = (Date.today - created_at.to_date).to_i
    raise AccountExpiredTrialError if diff > 14
    'Free Trial'
  end

  private 

  def create_default_rates
    self.rates.build :name => 'Default', :value => '1'
    self.rates.build :name => 'Cleaning', :value => '1', :type => :rate
  end  

end

class AccountException < Exception; end
class AccountExpiredTrialError < AccountException; end
class AccountBillingError < AccountException; end