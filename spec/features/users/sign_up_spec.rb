require 'spec_helper'

describe "sign up process", :js => true do 

  before do
    sign_up
  end

  def sign_up
    visit new_user_registration_path
    within("form#new_user") do
      fill_in 'Email', :with => 'adbeel@boloflix.com'
      fill_in 'First name', :with => 'Adbeel'
      fill_in 'Last name', :with => 'Guzman'
      fill_in 'Password', :with => '123456'  
      fill_in 'Password confirmation', :with => '123456'      
      click_on 'Create an account'
    end
  end

  it "sign me up with succesfully user creation message" do    
    page.should have_content 'You have signed up successfully.' 
  end

  it 'should sign up and redirect it to start welcome page' do    
    page.should have_content 'If you are a property owner' 
    page.should have_content 'If you are an agency manager' 
  end

end