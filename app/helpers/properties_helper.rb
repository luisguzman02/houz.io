module PropertiesHelper
  def property_types_select_options
    Property.utypes.map! {|p| [p.to_s.humanize,p] }
  end

  def account_properties_select_options
    current_account.properties.where(:active => true).map! {|p| [p.name, p.id]}
  end  
end