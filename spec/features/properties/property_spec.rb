require 'spec_helper'

describe "Properties", :js => true do 
  
  before do
    login
  end

  let(:acc) { FactoryGirl.create(:account) }

  describe 'default listing on backend' do 
    it 'redirect to new property page if user try to access listing' do      
      visit properties_path
      page.should have_content 'Add one or more properties to start using Secondhouz.'
      page.should have_content 'New Property'
    end

    it 'shows the latest ones' do
      5.times.each { |ix| acc.properties.create(:name => "#{prop_name} #{ix}", :description => "#{prop_desc} #{ix}") }
      lattest = acc.properties.order_by(:created_at => :desc)
      visit properties_path   
      lattest.each_with_index do |it,ix|
        page.all(:xpath, "//table/tbody/tr")[ix].has_content? 'it.name'
      end 
    end

    it 'list only 20 properties with pagination' do
      FactoryGirl.create_list(:property, 25)
      last_property = Property.last
      visit properties_path
      page.should have_content(last_property.name)
      page.should have_content(last_property.name)
      page.should have_selector('table tr', :count => 20)
      page.should have_css('pagination')
      page.should have_content('»')
    end
  end

  describe 'searching from backend' do
    it 'search property by id' do

    end

    it 'search property by keyword' do

    end
  end

  it 'adds new property' do
    visit properties_path
    click_on 'New'

    page.should have_content 'New property created successfully.' 
  end

  it 'successfully updates a property' do

  end

  it 'removes a property with all its references' do

  end
end