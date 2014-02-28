class Contact
  include Mongoid::Document
  include Mongoid::Timestamps

  embeds_one :address
  embeds_many :phones
  embeds_many :websites
  embeds_many :emails
  embedded_in :contactable, polymorphic: true
  accepts_nested_attributes_for :address, :phones, :websites, :emails
end

class Address
  include Mongoid::Document
  field :street
  field :street2
  field :city
  field :state
  field :zip_code
  field :area
  field :country
  embedded_in :contact  

  def location(format=:us)    
    loc = ''
    if city || state || zip_code
      loc =  "#{city}, #{state} #{zip_code}"
    end
    loc
  end
end

class Phone
  include Mongoid::Document
  field :of_type
  field :number
  field :code
  embedded_in :contact
end

class Website
  include Mongoid::Document
  field :url
  field :description
  field :of_type
  embedded_in :contact
end

class Email
  include Mongoid::Document
  field :ad, as: :address
  field :ot, as: :of_type
  embedded_in :contact
end
