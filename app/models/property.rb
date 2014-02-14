class Property
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Slug  

  UNIT_TYPES = [:house, :condo, :mobile_house]

  #basic
  field :name, type: String
  field :unit_type, type: Symbol, default: :house
  field :description, type: String  

  #details
  field :check_in, type: String, :default => '12:00'
  field :check_out, type: String, :default => '11:15'
  field :property_size, type: String
  field :minimum_days, type: Integer, default: 1
  field :num_persons_allowed, type: Integer, default: 4
  field :pets_allowed, type: Boolean, default: true  

  #location
  embeds_one :contact, as: :contactable, autobuild: true  
  field :directions, type: String
  field :tags, type: Array, default: []

  #rooms
  field :bathrooms, type: Integer, default: 1
  field :bedrooms, type: Integer, default: 1
  field :garages, type: Integer, default: 0
  field :kitchen, type: Integer, default: 0
  
  #amenities
  field :bedding, type: String
  field :amenities, type: String    

  #web  

  #settings
  field :active, type: Boolean,  default: true  

  slug :name, :scope => :account

  validates_presence_of :name, :unit_type, :contact, :description, :active, :account, :user
  validates_inclusion_of :bathrooms, :in => 0..10, :message => 'value must be a number between 0 and 10'
  validates_inclusion_of :bedrooms, :in => 0..20, :message => 'value must be a number between 0 and 20'
  validates_inclusion_of :garages, :in => 0..10, :message => 'value must be a number between 0 and 10'
  validates_length_of :name, :in => 4..50
  validates_inclusion_of :unit_type, :in => lambda { |p| p.class::UNIT_TYPES }
  validate :account_privileges

  embeds_many :payments
  belongs_to :user
  belongs_to :owner, class_name: 'User', inverse_of: :properties
  belongs_to :account
  has_many :reservations, :dependent => :destroy 
  embeds_many :rates, :as => :rateable
  has_many :pictures, :dependent => :destroy

  accepts_nested_attributes_for :contact     

  before_validation do |p|    
    p.user = p.account.user unless user
  end

  before_create do |p|
    #add default rates to property
    p.account.rates.where(:always_apply => true).each do |r|
      p.rates << r   
    end        
  end  

  def account_privileges
    #errors.add(:account, 'does not have the enought credits to add more properties') if !account.can_add_properties? && !persisted?
  end

  def set_rates(prs={})
    prs.each do |k,v|
      if (r = rates.find(k))
        r.value = v
        r.save
      end
    end
  end

  def tags_token_input
    return [] if tags.nil?
    tags.map! { |t| {:id => t, :name => t} }.to_json    
  end

  def check_availability(ci,co)
    s = Date.parse(ci).beginning_of_day
    e = Date.parse(co).end_of_day    
    reservations.where(:check_in.gte => s, :check_in.lt => s).and({:check_out.gte => e},{ :check_out.lt => e}).count == 0    
  end

  def rates_by_day(ci,co)
    ci = Date.parse(ci)
    co = Date.parse(co)
    all_r = []
    rent = Hash.new(0)
    rent[:name] = :rent.to_s.humanize
    rent[:detail] = []
    ci.upto(co-1) do |d|
      _r = rates.where(:seasonable => true).and(:start_season.gte => d, :end_season.lte => d).sum(:value)
      _r = rates.where(:type => :rent).sum(:value) if _r.eql? 0      
      rent[:value] += _r
      rent[:detail] << {d => _r}      
    end    
    all_r << rent
    #more rates
    rates.not_in(:type => :rent).each do |r|
      all_r << {:name => r.name, :value => r.value}
    end
    all_r
  end
  
end