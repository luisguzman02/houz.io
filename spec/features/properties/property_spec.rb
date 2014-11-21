require 'spec_helper'

RSpec.describe "Properties", :prop => :all, type: :feature, ctrl_clean: true, js: true do 
  let(:account) { FactoryGirl.create(:account) }
  before do
    #warden sign in
    confirm_and_login(account.user)
  end  

  describe 'nav bar' do    
    it 'should highlight properties option' do
      expect = Proc.new { expect(page).to have_content "Properties" }
      create_prop(account).call 1
      visit properties_path
      assert_navbar_option &expect  
    end
  end

  describe 'default listing on backend' do 
    it 'redirect to new property page if user try to access listing' do      
      visit properties_path
      expect(page).to have_content 'New Property'
    end

    it 'shows the latest ones' do
      5.times.each &create_prop(account)
      lattest = account.properties.order_by(:created_at => :desc)
      visit properties_path         
      lattest.each_with_index do |it,ix|
        expect(page).to have_content it.name
      end 
    end

    it 'list only 20 properties with pagination' do
      20.times.each &create_prop(account)
      visit properties_path 
      expect(page).to have_selector('.property_item', :count => 10)
    end
  end

  describe 'searching from backend' do
    it 'search property by id' 

    it 'search property by keyword'
  end

  context 'when adding a property', :prop => :adding do    
    it 'adds property details' do
      fill_basic_info      
      select '12 PM', :from => 'date_ci_hour'
      select '10 AM', :from => 'date_co_hour'
      fill_in 'Minimum stay', :with => 1
      fill_in 'Num persons allowed', :with => 5
      check 'property_pets_allowed'
      fill_in 'Property size', :with => '100'
      click_button 'Save'
    end

    it 'should be able to fill all the location details' do
      fill_basic_info
      select 'United States', :from => 'Country'
      fill_in 'City', :with => 'Seattle'
      fill_in 'State', :with => 'WA'
      fill_in 'Zip code', :with => '98144'
      fill_in 'Area', :with => 'Downtown'
      fill_in 'Directions', :with => 'Right in front of empire state building'
    end

    it 'should be able to fill rooms and amenities' do
      fill_basic_info      
      fill_in 'Bathrooms', :with => '2'
      fill_in 'Bedrooms', :with => '4'
      fill_in 'Garages', :with => '1'
      fill_in 'Kitchen', :with => '1'
      fill_in 'Bedding', :with => '1 Queen, 2 Individuals'
      fill_in 'property_amenities', :with => 'Hot tub, TV Cable, AC, Internet, etc'
    end

    it 'assigns current location by default' do
      local = Geocoder.search("204.57.220.1")
      visit properties_path 
      expect(find_field('Country').value).to eq local.first.country_code
      expect(find_field('City').value).to eq local.first.city
      expect(find_field('State').value).to eq local.first.state_code
      expect(find_field('Zip code').value).to eq local.first.postal_code
    end
  end

  context 'when managing properties', :prop => :manage do
    
    subject do
      create_prop(account).call 1
      visit properties_path 
      pname = account.properties.first.name
      within('#content-container') do
        expect(page).to have_content pname
        click_on pname
      end
      page
    end

    it { is_expected.to have_link 'Rates' }
    it { is_expected.to have_link 'Pictures' }
    it { is_expected.to have_link 'Rental History' }
    it { is_expected.to have_link 'Edit' }
    it { is_expected.to have_link 'Delete' }

    it 'successfully updates a property' do
      subject
      name = 'La Casa Bellas'
      click_on 'Edit'
      fill_in 'Name', :with => name
      click_on 'Save'
      expect(page).to have_content name
    end

    it 'removes a property with all its references', js: true do
      subject
      click_on 'Delete'
      #sometime needs double accept in chrome, dunno why
      page.driver.browser.switch_to.alert.accept
      #page.driver.browser.switch_to.alert.accept
      expect(page).to have_content 'New Property'      
    end
  end
end
