class Activity
	include Mongoid::Document
	include Mongoid::Timestamps::Created
	
  field :description, type: String
  embedded_in :logeable

  validates_presence_of :description
end