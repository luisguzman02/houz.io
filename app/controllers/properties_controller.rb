class PropertiesController < ApplicationController
  layout 'backend'
  before_filter :validate_properties, :except => [:new, :create]
  
  def index
    @properties = current_user.account.properties.order_by(:created_at => :desc)
  end

  def new
    @property = current_user.account.properties.build
  end

  def create
    @property = current_user.account.properties.build
    if @property.save
      redirect_to properties_path
    else
      render :action => 'new'
    end
  end

  private

  def validate_properties
    if current_user.account.nil? || current_user.account.properties.empty?
      redirect_to new_property_path, :notice => 'Add one or more properties to start using Secondhouz.'
    end
  end
end