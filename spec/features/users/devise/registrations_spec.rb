require 'spec_helper'

describe "registrations", :js => true, :devise => :re  do   
  before do
    login '#main_content'
  end

  it "can edit account basic info" do    
    
    
  end

  it "can change email and password" do
    visit edit_user_registration_path
    click_on 'Change Password'
    fill_in 'Password', :with => '12345678'
    fill_in 'Password confirmation', :with => '12345678'
    fill_in 'Current password', :with => '123456'
    click_button 'Update'
    page.should have_content('Password updated')    
  end


end