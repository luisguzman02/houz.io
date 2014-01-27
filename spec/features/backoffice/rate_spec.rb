require 'spec_helper'

describe "Rates", :js => true, :rates => :all do 

  before do
    @acc = FactoryGirl.create(:account)
    login_as(@acc.user, :scope => :user)
    create_prop.call 1
  end  

  describe 'nav bar' do    
    it 'should highlight back-office option' do      
      visit rates_path  
      within(:xpath, "//ul[@class='nav navbar-nav']/li[@class='active dropdown']") do 
        page.should have_content "Back-office"
      end
    end
  end

  describe 'rates listing' do
    it 'shows 2 default rates created automatically by system' do
      visit dashboard_path
      click_on 'Back-office'
      click_link 'Rates'
      page.should have_selector('table tbody tr', :count => 2)
    end
  end

  describe 'rates settings', :rates => :set do
    it 'can change existing rate' do
      visit rates_path  
      click_on 'Cleaning' # rate created by default, when new account is created
      select :rate, :from => 'Type'
      fill_in 'Name', :with => 'Nice cleaning'
      uncheck 'Always apply in reservation'
      check 'Hold for further return'
      select :percentage, :from => ''
      fill_in '', :with => '5'
      click_on 'Save'
    end

    it 'adds new rate' do

    end
  end
end