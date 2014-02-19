module ReservationsHelper

  def rsv_types_select_options    
    Reservation::RSV_TYPES.map {|p| [p.to_s.humanize,p] }
  end

end
