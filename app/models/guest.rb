class Guest
  include Mongoid::Document
  include Mongoid::Timestamps::Created

  field :name, :type => String
  field :email, :type => String
  field :source, :type => String

  embeds_one :contact, :autobuild => true
  embedded_in :reservation

  validates_presence_of :name, :email, :contact

end