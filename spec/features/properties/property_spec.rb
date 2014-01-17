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
    it 'adds property details' do
      visit properties_path            
      select :house, :from => 'Property Type'
      fill_in 'Name', :with => prop_name 
      fill_in 'Description', :with => prop_desc
      select '12:00', :from => :check_in
      select '11:00', :from => :check_out
      fill_in 'Minimum Days', :with => 1
      fill_in 'No. persons allowed', :with => 5
      check :pets_allowed
      fill_in 'Property Size', :with => '100 mt2'
      binding.pry    
      click_button 'Save'
      page.should have_content 'New property created successfully.' 
    end

    it 'should be able to fill all the location details' do

    end

    it 'should be able to fill all the location details' do

    end

    it 'assigns owner equivalent to admin by default when its a free plan' do

    end
  end

  it 'successfully updates a property' do
    pending
  end

  it 'removes a property with all its references' do
    pending
  end
end