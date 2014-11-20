require 'spec_helper'

RSpec.describe "Property rates", type: :feature, ctrl_clean: true, js: true do 
  let(:account) { FactoryGirl.create(:account) }
  let!(:property) { FactoryGirl.create(:property, account: account) }
  
  before do
    confirm_and_login(account.user)
    visit dashboard_path
    click_link 'Properties'
    click_link property.name
    click_link 'Rates'
  end

  context 'when user clicks on property rates option' do
    
    it 'lists default property rates' do
      expect(page).to have_selector('#property_rates_list tbody tr', :count => 2)
      within('#property_rates_list') do
        expect(page).to have_content property.rates[0].name
        expect(page).to have_content property.rates[1].name
      end
    end

    context 'when clicking on add button' do
      it 'adds a new line to the list' do
        click_on 'New'
        select 'Rate', :from => 'Type'
        fill_in 'Name', :with => 'Maids'
        #uncheck 'Always apply in reservation'
        #check 'Hold for further return'
        select 'Percentage', :from => 'rate_value_type'
        fill_in 'rate_value', :with => '5'
        click_on 'Save'
        expect(page).to have_selector('#property_rates_list tbody tr', :count => 3)
        within('#property_rates_list') do
          expect(page).to have_content 'Maids'
        end
      end
    end

    context 'when changing one item' do
      before do 
        within('#property_rates_list tbody tr', text: 'Default') do
          click_on 'Change'
        end
      end

      it 'can detele and remove it from the list' do
        click_link 'Remove this rate'
        page.driver.browser.switch_to.alert.accept
        expect(page).to have_content 'Rate was successfully deleted'
        within('#property_rates_list') do
          expect(page).not_to have_content 'Default'
        end
      end

      it 'updates the list ' do        
        fill_in 'Name', :with => 'Standard'
        fill_in 'rate_value', :with => '100'
        click_on 'Save'
        within('#property_rates_list') do
          expect(page).to have_content 'Standard'
          expect(page).to have_content '100'
        end
      end

    end
  end

end