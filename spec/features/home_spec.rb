 require 'spec_helper'

describe "home page", :js => true do   

  before do
    visit root_path
  end
  it 'show start now button that leads us to sign up page' do
    click_link 'Start Now »'
    page.should have_content 'Sign up'
    page.should have_content 'Email'
    page.should have_content 'First name'
    page.should have_content 'Password confirmation'
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
end