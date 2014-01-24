require 'spec_helper'

describe "Rates", :js => true, :rates => :all do 

  before do
    @acc = FactoryGirl.create(:account)
    login_as(@acc.user, :scope => :user)
  end  

  describe 'nav bar' do    
    it 'should highlight back-office option' do
      create_prop.call 1
      visit rates_path  
      within(:xpath, "//ul[@class='nav navbar-nav']/li[@class='active dropdown']") do 
        page.should have_content "Back-office"
      end
    end
  end

  describe 'rates listing' do
    it 'shows 2 default rates created automatically by system' do
      create_prop.call 1
      visit dashboard_path
      click_on 'Back-office'
      click_link 'Rates'
      page.should have_selector('table tbody tr', :count => 2)
    end
  end

end