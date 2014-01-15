class PropertiesController < DashboardController
  
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
  
end