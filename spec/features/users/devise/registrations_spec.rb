require 'spec_helper'

RSpec.describe "Registrations", :js => true, :devise => :re, type: :feature, ctrl_clean: true  do   
  before do
    login
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
      @user2 = FactoryGirl.create(:user)
      fill_in 'Email', :with => @user2.email
      click_button 'Update'
      within('#errors_profile')  do
        page.should have_content 'Email is already taken'
      end
    end

    it 'shows error if fields are empty' do
      fill_in 'First name', :with => ''
      fill_in 'Last name', :with => ''
      fill_in 'Email', :with => ''
      click_button 'Update'
      within('#errors_profile')  do
        page.should have_content 'Email can\'t be blank'
        page.should have_content 'First name can\'t be blank'
        page.should have_content 'Last name can\'t be blank'
      end
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