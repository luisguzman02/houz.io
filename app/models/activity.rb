class Activity
	include Mongoid::Document
	include Mongoid::Timestamps::Created
	
  field :action, type: Symbol
  field :description, type: String  
  belongs_to :user
  belongs_to :logeable, polymorphic: true

  validates_presence_of :action, :user, :logeable
end