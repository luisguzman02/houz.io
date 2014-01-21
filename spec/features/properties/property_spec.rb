require 'spec_helper'

describe "Properties", :js => true, :prop => :all do 
  
  before do
    @acc = FactoryGirl.create(:account)
    #warden sign in
    login_as(@acc.user, :scope => :user)
  end  

  describe 'nav bar' do    
    it 'should highlight properties option' do
      expect = Proc.new { page.should have_content "Properties" }
      create_prop.call
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
    def fill_basic_info
      select :house, :from => 'Property Type'
      fill_in 'Name', :with => prop_name 
      fill_in 'Description', :with => prop_desc
    end

    it 'adds property details' do
      visit properties_path            
      fill_basic_info
      select '12 PM', :from => 'property[check_in(4i)]'
      select '10 AM', :from => 'property[check_out(4i)]'
      fill_in 'Minimum rental days', :with => 1
      fill_in 'Num persons allowed', :with => 5
      check 'property_pets_allowed'
      fill_in 'Property size', :with => '100'
      click_button 'Save'
      page.should have_content 'New property created successfully.' 
    end

    it 'should be able to fill all the location details' do
      visit properties_path            
      fill_basic_info
      select 'United States', :from => 'Country'
      fill_in 'City', :with => 'Seattle'
      fill_in 'State', :with => 'WA'
      fill_in 'Zip Code', :with => '98144'
      fill_in 'Area', :with => 'Downtown'

    end

    it 'assigns owner equivalent to admin by default when its a free plan' do

    end
  end

  describe 'managing properties', :prop => :manage do
    def open_edit_property_page
      create_prop.call 1
      visit properties_path 
      pname = @acc.properties.first.name      
      within('#tb_properties') do
        page.should have_content pname        
        click_on pname
      end
    end

    it 'successfully updates a property' do
      open_edit_property_page
      click_on 'Save'
      page.should have_content 'Property updated successfully.'  
    end

    it 'removes a property with all its references' do
      open_edit_property_page
      click_on 'Delete'
      #double in chrome
      page.driver.browser.switch_to.alert.accept
      page.driver.browser.switch_to.alert.accept
      page.should have_content 'New Property'      
    end
  end
end