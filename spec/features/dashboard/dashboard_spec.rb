require 'spec_helper'

describe "backend dasboard", :js => true do 

  describe 'nav bar' do
    before do
      login
    end  

    it 'should hightlight the option in menu' do
       assert_navbar_option  { page.should have_content "Dashboard" }
    end
  end

  describe 'user session with no account' do
    it 'shows up invitation to post a new property' do
      page.should have_content 'Welcome to SecondHouz '
      page.should have_content 'Start Now'
    end
  end

  describe 'user session with account' do
    before do
      @acc = FactoryGirl.create(:account)
      login_as(@acc.user, :scope => :user)
    end 
    it 'shows current plan' do
      page.should have_content @acc.ecommerce_plan.name
    end
    it 'should be able to upgrade from free plan' do
      pending
    end
  end
end