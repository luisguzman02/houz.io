class RatesController < DashboardController
  
  def index
    @rates = current_account.rates
  end

end