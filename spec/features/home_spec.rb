 require 'spec_helper'

RSpec.describe HomeController, type: :feature, ctrl_clean: true, :homie => true do   

  before do
    visit root_path
  end

  it 'show start now button that leads us to sign up page' do
    click_link 'Start Now »'
    expect(page).to have_content 'Sign up'
    expect(page).to have_field 'Email'
    expect(page).to have_field 'First name'
    expect(page).to have_field 'Password confirmation'
    expect(page).to have_button 'Create an account'
  end

  it 'should have features and pricing options in nav bar' do
    within(:xpath, "//div[@class='navbar-collapse collapse']") do 
      expect(page).to have_content 'Features'
      expect(page).to have_content 'Pricing'
    end
  end

end