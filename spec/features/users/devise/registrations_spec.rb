require 'spec_helper'

describe "registrations", :js => true, :devise => :re  do   
  before do
    login '#main_content'
    visit edit_user_registration_path
  end

  describe 'Profile Settings' do    
    it "can edit user basic info successfully" do        
      fill_in 'First name', :with => 'Itamar'
      fill_in 'Last name', :with => 'Ibarra'
      click_button 'Update'
      page.should have_content('Profile Settings updated.') 
      visit current_path
      within('#top-bar') do
        page.should have_content 'Itamar Ibarra'
      end
    end

    it 'shows an error trying to choose an existing email' do
      pending
    end

    it 'shows error if first or last name are empty' do
      pending
    end
  end 


  describe 'Change Password' do
    before do      
      click_on 'Change Password'
    end

    it "can change password successfully" do      
      fill_in 'Password', :with => '12345678'
      fill_in 'Password confirmation', :with => '12345678'
      fill_in 'Current password', :with => '123456'
      click_button 'Update'
      page.should have_content('Password updated')    
    end

    it 'displays errors when user enter wrong information' do
      fill_in 'Password', :with => '12345'
      fill_in 'Password confirmation', :with => '1234567'
      fill_in 'Current password', :with => '123456X'
      click_button 'Update'      
      within('#errors_password')  do
        page.should have_content "Password confirmation doesn't match Password"
        page.should have_content "Password is too short (minimum is 6 characters)"
        page.should have_content "Current password is invalid"
      end
    end

  end
end