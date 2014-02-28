module ActivitiesHelper

  def humanify(activity)
    if activity.action.eql? :update_notes 
      "updated notes on #{activity.logeable_type.downcase}"
    elsif activity.action.eql? :create
      "created this #{activity.logeable_type.downcase} with Id: " << content_tag(:em, activity.logeable.id.to_s, :class => 'text-muted')
    else
      "#{activity.action.to_s.sub(/e?$/, "ed")} this #{activity.logeable_type.downcase}"
    end
  end
  
end
