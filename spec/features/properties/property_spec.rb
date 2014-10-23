require 'spec_helper'

RSpec.describe "Properties", :js => true, :prop => :all, type: :feature, ctrl_clean: true do 
  
  before do
    @acc = FactoryGirl.create(:account)
    #warden sign in
    login_as(@acc.user, :scope => :user)
  end  

  describe 'nav bar' do    
    it 'should highlight properties option' do
      expect = Proc.new { page.should have_content "Properties" }
      create_prop.call 1
      visit properties_path
      assert_navbar_option &expect      
      click_on 'New property'
      assert_navbar_option &expect
    end
  end

  describe 'default listing on backend' do 
    it 'redirect to new property page if user try to access listing' do      
      visit properties_path
      page.should have_content 'Add one or more properties to start using Secondhouz.'
      page.should have_content 'New Property'
    end

    it 'shows the latest ones' do
      usr.account = acc
      usr.save
      5.times.each create_prop
      lattest = acc.properties.order_by(:created_at => :desc)
      visit properties_path   
      lattest.each_with_index do |it,ix|
        page.all(:xpath, "//table/tbody/tr")[ix].has_content? 'it.name'
      end 
    end

    it 'list only 20 properties with pagination' do
      25.times.each create_prop
      visit properties_path 
      page.should have_selector('table tbody tr', :count => 20)
      page.should have_css('pagination')
      page.should have_content('»')
    end
  end

  describe 'searching from backend' do
    it 'search property by id' do
      pending
    end

    it 'search property by keyword' do
      pending
    end
  end

  describe 'adding a property', :prop => :adding do    
    it 'adds property details' do
      fill_basic_info
      select '12 PM', :from => 'property[check_in(4i)]'
      select '10 AM', :from => 'property[check_out(4i)]'
      fill_in 'Minimum stay', :with => 1
      fill_in 'Num persons allowed', :with => 5
      check 'property_pets_allowed'
      fill_in 'Property size', :with => '100'
      click_button 'Save'
      page.should have_content 'New property created successfully.' 
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
      find_field('Country').value.should eq local.first.country_code
      find_field('City').value.should eq local.first.city
      find_field('State').value.should eq local.first.state_code
      find_field('Zip code').value.should eq local.first.postal_code
    end

    it 'assigns owner equivalent to admin by default when its a free plan' do

    end
  end

  describe 'managing properties', :prop => :manage do
    before do
      open_edit_property_page
    end

    def open_edit_property_page
      create_prop.call 1
      visit properties_path 
      pname = @acc.properties.first.name      
      within('#tb_properties') do
        page.should have_content pname        
        click_on pname
      end
    end

    def assert_property_opt(o)
      page.should have_link o
      click_link o
      within(:xpath, "//div[@id='head_right']/a[@class='btn btn-default active']") { page.should have_content(o) }
    end

    it 'should have rates button on property page leading you to proper page' do
      assert_property_opt 'Rates'
    end

    it 'should have pictures button on property page leading you to proper page' do
      assert_property_opt 'Pictures'
    end

    it 'successfully updates a property' do
      click_on 'Save'
      page.should have_content 'Property updated successfully.'  
    end

    it 'removes a property with all its references' do
      click_on 'Delete'
      #sometime needs double accept in chrome, dunno why
      page.driver.browser.switch_to.alert.accept
      #page.driver.browser.switch_to.alert.accept
      page.should have_content 'New Property'      
    end

    it 'cancel button takes you to properies page' do
      click_link 'Cancel'
      page.should have_content 'Properties'
      page.should have_link 'New property'
    end
  end
end