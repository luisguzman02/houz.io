class DashboardController < ActionController::Base 
  protect_from_forgery with: :exception
  layout 'backend'
  before_filter :validate_properties, :except => [:new, :create]

  def index; end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(:first_name, :last_name, :email, :password, :password_confirmation) }
  end

  private

  def validate_properties
    if current_user.account.nil? 
      redirect_to welcome_plans_path
    elsif current_user.account.properties.empty?
      redirect_to new_property_path, :notice => 'Add one or more properties to start using Secondhouz.'
    end
  end

end