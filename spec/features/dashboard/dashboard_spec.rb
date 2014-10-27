require 'spec_helper'

RSpec.describe "backend dasboard", :dashboard => true, type: :feature, ctrl_clean: true, js: true do 
  let(:account) { FactoryGirl.create(:account) }
  before do    
    login_as(account.user, :scope => :user)
  end
  
  context 'nav bar' do
    before do
      create_prop(account).call
      visit dashboard_path
    end

    it 'should hightlight the option in menu' do
      assert_navbar_option  { expect(page).to have_content "Dashboard" }
    end

    it 'hide options of avanced plan if accoutn has the basic plan'
  end

  it 'shows unautharized message if user is logged out' do
    logout(:user)
    visit dashboard_path
    expect(page).to have_content 'Sign in'    
  end

  it 'redirect to new property page if user does not have any property yet' do
    visit dashboard_path
    expect(page).to have_content 'New Property'
    expect(page).to have_field 'Name'
    expect(page).to have_field 'Description'
  end
     
  it 'redirect to start welcome page if user dont have an account' do
    account.user = nil
    account.save
    visit dashboard_path
    expect(page).to have_content 'Welcome'
    expect(page).to have_link 'Create new Property'
  end

  it 'shows current plan or 14 days trial period'
  it 'has a link to upgrade to premium plan'
end