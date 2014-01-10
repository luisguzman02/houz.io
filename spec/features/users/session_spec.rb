require 'spec_helper'

describe "user session", :js => true do 
  let(:usr) { FactoryGirl.create(:user) }
  
  def login(target='.navbar-form')
    within(target) do
      fill_in 'Email', :with => usr.email
      fill_in 'Password', :with => usr.password
      click_on 'Sign in'
    end    
  end

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