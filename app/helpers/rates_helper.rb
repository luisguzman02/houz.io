module RatesHelper
  def rate_select_options(opt=:types)
    return [] unless Rate.respond_to? opt
    Rate.send(opt).map! {|p| [p.to_s.humanize,p] }
  end

end
