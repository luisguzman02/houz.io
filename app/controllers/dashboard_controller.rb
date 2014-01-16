class DashboardController < ApplicationController
  layout 'backend'
  before_filter :validate_properties, :except => [:new, :create]

  def index; end

  private

  def validate_properties
    if current_user.account.nil? 
      redirect_to welcome_plans_path
    elsif current_user.account.properties.empty?
      redirect_to new_property_path, :notice => 'Add one or more properties to start using Secondhouz.'
    end
  end
end