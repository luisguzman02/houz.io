class Property
  include Mongoid::Document
  include Mongoid::Timestamps

  field :name
  field :check_in
  field :check_out
  field :directions
  field :description
  field :active, default: true
  field :pets_allowed, type: Boolean, default: true

  embeds_one :contact, as: :contactable, autobuild: true

  accepts_nested_attributes_for :contact
end