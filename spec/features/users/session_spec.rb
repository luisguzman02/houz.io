require 'spec_helper'

describe "user session", :js => true do 
  let(:usr) { FactoryGirl.create(:user) }

  it "signs me in from login page" do    
    visit login_path
    login '#main_content'
    page.should have_content 'Signed in successfully.'    
  end

  it "signs me in from nav bar" do
    visit root_path
    login    
    page.should have_content 'Signed in successfully.'    
  end

  it "logs me out" do
    visit login_path
    login '#main_content'
    click_link 'Logout'
    page.should have_content 'Signed out successfully. ' 
  end

end