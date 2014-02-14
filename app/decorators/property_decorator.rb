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

  def booking_info
    { 
      :num_persons_allowed => num_persons_allowed, 
      :check_in =>  readable_check_in,
      :check_out => readable_check_out   
    }   
  end  
end
