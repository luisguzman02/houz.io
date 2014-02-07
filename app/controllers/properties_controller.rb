class PropertiesController < DashboardController
  before_action :set_property, :only => [:edit, :update, :rates, :pictures]

  def index
    @properties = current_account.properties.order_by(:created_at => :desc)
  end

  def new    
    @property = current_account.properties.build   
    @property.contact.build_address(local_info)    
  end

  def create
    @property = current_account.properties.build property_params
    if @property.save
      redirect_to edit_property_path(@property), :notice => 'New property created successfully.' 
    else
      render :action => 'new'
    end
  end

  def update
    if @property.update(property_params)
      redirect_to edit_property_path(@property), :notice => 'Property updated successfully.' 
    else
      render :action => 'edit'
    end
  end

  def destroy
    @property = current_account.properties.find(params[:id])
    if @property.destroy
      redirect_to properties_path, :notice => 'The property was successfully removed.'
    else
      redirect_to edit_property_path(@property), :error => 'Something went wrong trying to delete a property. We\'re already taking care of the issue.' 
    end
  end

  def rates
    @property.set_rates params[:property_rates] if request.method.eql? 'POST'
  end

  def pictures    
    @property.pictures.create pic_params if request.method.eql? 'POST'
  end

  def tags    
    respond_to do |format|
      format.html
      format.json { 
        re = /#{Regexp.escape(params[:q])}/i
        tags = current_account.properties.only(:tags).where(:tags.ne => nil).map {|p| p.tags }
        tags.flatten!
        tags = tags.grep re
        tags.map! { |t| {:id => t, :name => t} }
        render :json => tags
      }
    end    
  end

  private

  def set_property
    @property = current_account.properties.find(params[:id])
    render :template => "errors/not_found", :status => :not_found unless @property 
  end

  def local_info
    local = request.ip.eql?('127.0.0.1') ? Geocoder.search("204.57.220.1").first : request.location
    {:country => local.country_code, :state => local.state_code, :city => local.city, :zip_code => local.postal_code }
  end

  def pic_params
    params.require(:picture).permit(:picture)
  end

  def property_params
    pp = params[:property]
    if pp[:check_in].nil? && pp[:check_out].nil?
      check_in = Time.local(pp['check_in(1i)'], pp['check_in(2i)'], pp['check_in(3i)'], pp['check_in(4i)'], pp['check_in(5i)'])
      check_out = Time.local(pp['check_out(1i)'], pp['check_out(2i)'], pp['check_out(3i)'], pp['check_out(4i)'], pp['check_out(5i)'])
      params[:property].reject! {|k| k.include? 'check'}
      params[:property].merge!({:check_in => check_in, :check_out => check_out})
    end
    params[:property][:tags] = params[:property][:tags].split(',')    
    params.require(:property).permit(:name, :unit_type, :description, { tags: [] }, :check_in, :check_out, :property_size, :minimum_days, 
      :num_persons_allowed, :pets_allowed, :directions, :bedrooms, :bathrooms, :garages, :kitchen, :bedding, :amenities, 
      :contact_attributes => {:address_attributes =>  [:country, :city, :state, :zip_code, :area] })
  end
end