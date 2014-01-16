require 'spec_helper'

describe "backend dasboard", :js => true do 

  before do
    @acc = FactoryGirl.create(:account)
    login_as(@acc.user, :scope => :user)
  end
  
  describe 'nav bar' do
    before do
      create_prop.call
      visit dashboard_path
    end

    it 'should hightlight the option in menu' do
       assert_navbar_option  { page.should have_content "Dashboard" }
    end

    it 'do not show premium options' do
      pending
    end
  end

  it 'redirect to new property page if user does not have any property yet' do
    visit dashboard_path
    page.should have_content 'New Property'
    page.has_field? 'Name'
    page.has_field? 'Description'
  end
     
  it 'redirect to start welcome page if user dont have an account' do
    @acc.user = nil
    @acc.save
    visit dashboard_path
    page.should have_content 'Please choose the option that best suits to your needs and start using Secondhouz.'
  end

  it 'shows current plan' do
    create_prop.call
    visit dashboard_path
    page.should have_content @acc.ecommerce_plan.name
  end

  it 'has a link to upgrade from free plan' do
    pending
  end

end