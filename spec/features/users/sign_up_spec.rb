require 'spec_helper'

describe "sign up process", :js => true do 

  it "sign me up" do
    visit new_user_registration_path
    fill_in 'Email', :with => 'adbeel@boloflix.com'
    fill_in 'First name', :with => 'Adbeel'
    fill_in 'Last name', :with => 'Guzman'
    fill_in 'Password', :with => '123456'  
    fill_in 'Password confirmation', :with => '123456'      
    click_on 'Register'
    page.should have_content 'You have signed up successfully.'    
    page.should have_content 'Dashboard'    
  end

end