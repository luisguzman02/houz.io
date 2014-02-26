module Loggable
  extend ActiveSupport::Concern

  included do
    has_many :activities
    after_create :track
  end

  def track
    user.activities.create(:logeable => self, :action => :create)
  end

  module ClassMethods
    #class methods here
  end
end