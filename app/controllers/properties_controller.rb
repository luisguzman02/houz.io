class PropertiesController < ApplicationController
  layout 'backend'
  
  def index
    if current_user.account.present?
      @properties = current_user.account.properties.order_by(:created_at, :desc)
    else
      redirect_to new_property_path, :notice => 'Add one or more properties to start using Secondhouz.'
    end
  end

  def new
    @property = Property.new
  end

  def create
  end

end