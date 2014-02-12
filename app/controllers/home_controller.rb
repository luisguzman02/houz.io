class HomeController < ApplicationController

  def index; end

  def welcome_plans
    unless user_signed_in?
      redirect_to new_user_registration_path
      return false
    end
    if params['o'].present? && params['o'].eql?('trial')
      acc = current_user.build_account
      if acc.save
        redirect_to new_properties_path
      else
        render :template => "errors/internal_server_error", :status => :internal_server_error 
      end
    end
  end
end