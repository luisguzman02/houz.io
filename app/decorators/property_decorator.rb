class PropertyDecorator < Draper::Decorator
  delegate_all

  # refactor methods: hour_check_in, hour_check_out, minute_check_in, minute_check_out, readable_check_in, readable_check_out
  def method_missing(name, *args)
    if /#{['_check_out','_check_in'].join("|")}/ === name.to_s      
      e, field = name.to_s.split(/_/, 2)
      if e.eql? 'readable'
        Time.parse(send(field)).to_s(:time_in_zone)
      else        
        value = e.eql?('minute') ? send(field).split(/:/).last : send(field).split(/:/).first
        value.to_i
      end
    else      
      super
    end
  end  

  def booking_info(ci,co)
    if object.check_availability(ci,co)     
      bd = {
        :property => {           
          :check_in =>  readable_check_in,
          :check_out => readable_check_out,
          :name => name,
          :num_persons_allowed => num_persons_allowed,  
          :pets_allowed => pets_allowed,
          :bathrooms => bathrooms,
          :bedrooms => bedrooms,
          :garages => garages,
          :kitchen => kitchen
        },
        :rates => rates_by_day(ci,co)
      }
    else
      bd = { :error => 'Property not available at these dates'}
    end      
  end 

  def rates_by_day(check_in,check_out)
    all_r = object.rates_within check_in, check_out
    all_r << {:name => 'Total', :value => all_r.inject(0){|sum,e| sum += e[:value] }}    
  end
end
