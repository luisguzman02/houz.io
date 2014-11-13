require 'spec_helper'

RSpec.describe "sign up process", :devise => :su, type: :feature, ctrl_clean: true do 
  let(:not_persisted_user) { FactoryGirl.build(:user) }

  before do
    sign_up
  end

  def sign_up
    visit new_user_registration_path
    within("form#new_user") do
      fill_in 'Email', :with => not_persisted_user.email
      fill_in 'First name', :with => not_persisted_user.first_name
      fill_in 'Last name', :with => not_persisted_user.last_name
      fill_in 'Password', :with => not_persisted_user.password  
      fill_in 'Password confirmation', :with => not_persisted_user.password      
      click_on 'Create an account'
    end
  end

  it "send to email confirmation page after sign up"

  it 'confirms email account'

end