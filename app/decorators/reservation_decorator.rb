class ReservationDecorator < Draper::Decorator
  delegate_all  

  def type_humanized
    rsv_type.to_s.humanize
  end
  
  def tenant_info
    if tenant.present?
      tenant.full_name
    elsif guest.present?             
      guest.name
    else
      h.link_to('Add tenant', edit_reservation_path(object), :format => :js, :class => 'text-muted add_tenant', 
        'data-toggle' => 'modal',  'data-target' => '#inquiery_booking', :remote => true)
    end
  end

  def staying_info
    h.link_to("#{h.pluralize(nights_staying, 'night')}", object ) << " - #{check_in.to_s(:second_date)} - #{check_out.to_s(:second_date)}"          
  end
end