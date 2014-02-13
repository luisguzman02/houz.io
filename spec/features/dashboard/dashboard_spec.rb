require 'spec_helper'

describe "backend dasboard", :js => true, :dashboard => true do 

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

    it 'hide options of avanced plan if accoutn has the basic plan' do
      pending
    end
  end

  it 'shows unautharized message if user is loggedout' do
    logout(:user)
    visit dashboard_path
    page.should have_content 'You need to sign in or sign up before continuing'    
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
    page.should have_content 'Welcome'
    page.should have_link 'Create new Property'
  end

  it 'shows current plan or 14 days trial period' do
    create_prop.call
    visit dashboard_path
    page.should have_content @acc.package
  end

  it 'has a link to upgrade to premium plan' do
    pending
  end

end