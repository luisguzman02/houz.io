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
    def rate_dummy_name
      'Holy weekend rate'
    end

    def new_rate
      visit rates_path  
      click_on 'Add new rate'
      select "Rent", :from => 'Type'
      fill_in 'Name', :with => rate_dummy_name
      select 'Amount', from: 'rate_value_type'
      fill_in 'rate_value', :with => 65
      check 'Always apply in reservation'
      check 'rate_seasonable'
      within '.datepicker_range .ui-datepicker-group-first' do
        click_on '10'
        click_on '15'
      end
      click_on 'Save'
    end

    it 'can change existing rate' do
      visit rates_path  
      click_on 'Cleaning' # rate created by default when new account is created
      select "Rate", :from => 'Type'
      fill_in 'Name', :with => 'Nice cleaning'
      uncheck 'Always apply in reservation'
      check 'Hold for further return'
      select 'Percentage', :from => 'rate_value_type'
      fill_in 'rate_value', :with => '5'
      check 'Season Rate'      
      click_on 'Save'
    end

    it 'adds new rate' do
      new_rate
      page.should have_content 'Rate was successfully created'
    end

    it 'asserts values when adding a new rate' do
      new_rate
      click_on rate_dummy_name
      r = @acc.rates.find_by(:name => rate_dummy_name)    
      within('#rates_content .panel-body') do      
        page.should have_select('Type', :selected => r.type.to_s.humanize)
        page.should have_field('Name', :with => r.name)
        page.should have_select('rate_value_type', :selected => r.value_type.to_s.humanize)
        page.should have_field('rate_value', :with => r.value)
        page.should have_checked_field 'Always apply in reservation'
        page.should have_unchecked_field 'Hold for further return'
        page.should have_checked_field 'rate_seasonable'
      end  
    end
  end

  it 'deletes a rate' do
    visit rates_path  
    click_link 'Cleaning'
    click_on 'Delete'
    paga.should have_content 'Rate was successfully deleted.'
  end
end