class Company
	include Mongoid::Document
	include Mongoid::Timestamps

	field :name, type: String
	field :logo

	embeds_one :contact, as: :contactable, autobuild: true
	has_many :letters
	has_one :account

  validates_presence_of :name, :pet_type, :breed, :age, :weight
end