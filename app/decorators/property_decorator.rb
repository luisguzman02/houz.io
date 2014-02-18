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

  def rates_by_day(ci,co)
    ci = Date.parse(ci)
    co = Date.parse(co)
    all_r = []
    total = 0
    rent = Hash.new(0)    
    rent[:detail] = []
    ci.upto(co-1) do |d|
      _r = rates.where(:seasonable => true).and(:start_season.gte => d, :end_season.lte => d).sum(:value)
      _r = rates.where(:type => :rent).sum(:value) if _r.eql? 0      
      rent[:value] += _r
      rent[:detail] << {d => _r}
      rent[:nights] += 1      
    end       
    rent[:name] = "#{:rent.to_s.humanize} #{h.pluralize(rent[:nights], 'night')}"
    total += rent[:value]
    all_r << rent
    #more rates
    rates.not_in(:type => :rent).each do |r|
      all_r << {:name => r.name, :value => r.value}
      total += r.value
    end
    all_r << {:name => 'Total', :value => total}
    all_r
  end
end
