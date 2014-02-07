module PropertiesHelper
  def property_types_select_options
    Property.utypes.map! {|p| [p.to_s.humanize,p] }
  end
end