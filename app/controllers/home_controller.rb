class HomeController < ApplicationController

  def index; end

  def welcome_plans
    unless user_signed_in?
      redirect_to new_user_registration_path
      return false
    end
    if params['o'].present? && params['o'].eql?('trial')
      if current_user.account.nil?
        acc = current_user.build_account
        if acc.save
          redirect_to new_property_path
        else
          render :template => "errors/internal_server_error", :status => :internal_server_error 
        end
      else
        redirect_to new_property_path
      end
    end
  end

  def send_contact
    if (valid_email?(params[:email]) && params[:name] != "" && params[:message] != "")
      ContactMailer.contact_form(params).deliver
      flash[:notice] = "Email sent"
    else
      flash[:error] = "Error"
    end
    redirect_to root_path
  end

end