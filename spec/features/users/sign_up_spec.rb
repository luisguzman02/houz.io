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

  it "arrives to welcome start page with succesfully user creation message" do    
    page.should have_content 'You have signed up successfully.' 
    page.should have_content 'Please choose the option that best suits to your needs and start using Secondhouz.' 
  end

  it 'creates new account after choosing free plan' do
    within('#free_plan') do
      click_on 'Start Now' 
    end    
  end

end