require 'spec_helper'

describe "user session", :js => true do   

  it "signs me in from login page" do    
    login '#main_content'
    page.should have_content 'Signed in successfully.'    
  end

  it "signs me in from nav bar" do
    login    
    page.should have_content 'Signed in successfully.'    
  end

  it "logs me out" do
    login
    click_link 'Logout'
    page.should have_content 'Signed out successfully. ' 
  end

end