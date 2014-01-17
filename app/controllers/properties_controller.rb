class PropertiesController < DashboardController
  
  def index
    @properties = current_user.account.properties.order_by(:created_at => :desc)
  end

  def new
    @property = current_user.account.properties.build
  end

  def create
    #binding.pry
    @property = current_user.account.properties.build
    if @property.save
      redirect_to properties_path
    else
      render :action => 'new'
    end
  end
  
  private

  def property_params
    params.require(:property).permit(:name, :unit_type, :description, :check_in, :check_out, :property_size, :minimum_days, :num_persons_allowed, :pets_allowed)
  end
end