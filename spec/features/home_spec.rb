 require 'spec_helper'

describe "home page", :js => true, :homie => true do   

  before do
    visit root_path
  end
  it 'show start now button that leads us to sign up page' do
    click_link 'Start Now »'
    page.should have_content 'Sign up'
    page.should have_field 'Email'
    page.should have_field 'First name'
    page.should have_field 'Password confirmation'
    page.should have_button 'Create an account'
  end

  it 'should have features and pricing options in nav bar' do
    within(:xpath, "//ul[@class='nav navbar-nav']") do 
      page.should have_content 'Features'
      page.should have_content 'Pricing'
    end
  end

  it 'should have features content' do
    pending
  end

  it 'should have pricing content' do
    pending
  end

  describe 'welcome start page' do
    it 'redirects to signup page if theres no user session present' do
      visit welcome_plans_path
      page.should have_content 'Sign up now'
      page.should have_button 'Create an account'
    end

    it 'redirect to 500 error page if theres no free plan' do
      login
      click_on 'Start Now'
      page.should have_content 'Error 500'
    end
  end
end