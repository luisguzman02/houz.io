class HomeController < ApplicationController
  def index; end

  def welcome_plans
    redirect_to new_user_registration_path unless user_signed_in?
    if params['o'].present? && params['o'].eql?('free')
      acc = current_user.build_account
      if acc.save

      else
        render :template => "errors/not_found", :status => :not_found 
      end
    end
  end
end