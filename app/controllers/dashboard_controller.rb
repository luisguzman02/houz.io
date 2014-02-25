class DashboardController < ActionController::Base 
  include ApplicationHelper
  protect_from_forgery with: :exception
  layout 'canvas_admin'
  before_action :authenticate_user!
  before_action :validate_properties, :except => [:new, :create]
  before_action :configure_permitted_parameters, if: :devise_controller?

  def index; end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(:first_name, :last_name, :email, :password, :password_confirmation) }
  end

  rescue_from 'AccountException' do |exception|    
    redirect_to upgrade_path if exception.is_a? AccountExpiredTrialError    
  end

  private

  def validate_properties
    if current_account.nil? 
      redirect_to welcome_plans_path
    elsif current_account.properties.empty?
      redirect_to new_property_path
    end
  end

end