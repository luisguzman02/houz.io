require 'spec_helper'

RSpec.describe "Rates", :js => true, :rates => :all, type: :feature, ctrl_clean: true do 
  
  let(:account) { FactoryGirl.create(:account) }

  before do
    confirm_and_login(account.user)
    create_prop(account).call 1
  end  

  describe 'nav bar' do    
    it 'should highlight back-office option' do      
      visit rates_path  
      assert_navbar_option { expect(page).to have_content "Properties" }      
    end
  end

  describe 'rates listing' do
    it 'shows 2 default rates created automatically by system' do
      visit rates_path
      expect(page).to have_selector('table tbody tr', :count => 2)
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
      within '.datepicker_range .datepicker-days' do
        find('.day', :text => 10).click
        find('.day', :text => 15).click
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
      expect(page).to have_content rate_dummy_name
    end

    it 'asserts values when adding a new rate' do
      new_rate
      click_on rate_dummy_name
      r = account.reload.rates.find_by(:name => rate_dummy_name)    
      within('#rates_content .panel-body') do      
        expect(page).to have_select('Type', :selected => r.type.to_s.humanize)
        expect(page).to have_field('Name', :with => r.name)
        expect(page).to have_select('rate_value_type', :selected => r.value_type.to_s.humanize)
        expect(page).to have_field('rate_value', :with => r.value)
        expect(page).to have_checked_field 'Always apply in reservation'
        expect(page).to have_unchecked_field 'Hold for further return'
        expect(page).to have_checked_field 'rate_seasonable'
      end  
    end

    it 'shows properties that includes specific rate'
  end

  it 'deletes a rate' do
    pending '(need to implement)'
    visit rates_path  
    click_link 'Cleaning'  
    click_on 'Delete'    
    expect(page).to have_content 'Rate was successfully deleted.'
  end
end