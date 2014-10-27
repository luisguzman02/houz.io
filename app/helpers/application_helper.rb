module ApplicationHelper
  def resource_name
    :user
  end
 
  def resource
    @resource ||= User.new
  end
 
  def devise_mapping
    @devise_mapping ||= Devise.mappings[:user]
  end

  def current_account
    current_user.account
  end

  def render_model_errors(model)
    errors = ''
    if model && model.errors.any?
      h3 = content_tag :h3, "#{pluralize(model.errors.count, "error")} prohibited this #{model.class.to_s.downcase} from being saved:"
      lis = ''
      model.errors.full_messages.each do |msg|
        lis << content_tag(:li, msg)
      end
      ul = content_tag :ul, lis.html_safe
      errors = content_tag(:div, (h3 + ul), :class => 'alert alert-danger')
    end
    errors
  end

  def formify(object, options = {}, &block)
    options[:builder] = SimplyBootstrapFormBuilder    
    form_for(object, options, &block)
  end

  def valid_email?(email)
    /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i.match(email)
  end
  
end