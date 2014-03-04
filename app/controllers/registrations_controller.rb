class RegistrationsController < Devise::RegistrationsController
  layout 'canvas_admin', :only => [:update, :edit]

  def update
    @user = User.find(current_user.id)

    successfully_updated = if needs_password?(@user, params)      
      @user.update_with_password(devise_parameter_sanitizer.sanitize(:account_update))
    else           
      params[:user].delete(:current_password)      
      @user.update_without_password(devise_parameter_sanitizer.sanitize(:account_update))
    end
    if successfully_updated
      sign_in @user, :bypass => true            
      respond_to do |format|
        format.html { 
          redirect_to after_update_path_for(@user)
        }
        format.js
      end  
    else
      respond_to do |format|
        format.html { render "edit" }
        format.js
      end  
    end
  end

  def needs_password?(user, params)
    user.email != params[:user][:email] ||
      params[:user][:password].present?
  end

  def user_update_params
    params.require(:user).permit(:first_name, :last_name, :email, :picture)
  end
end
