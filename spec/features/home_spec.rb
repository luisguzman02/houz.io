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

  describe 'contact form' do
    before { visit root_path }
    let(:submit) { "Send request" }
    describe "with invalid information" do
      describe "after submission" do
        subject { click_button submit; page }
        it { is_expected.to have_selector('.alert-danger', 'Error') }
      end
    end

    describe "with valid information" do
      before do
        within "#contact" do
          fill_in "name", with: "Amin Ogarrio"
          fill_in "telephone", with: "2505050"
          fill_in "email", with: "amin.ogarrio@gmail.com"
          fill_in "message", with: "lorem itsu"
        end
      end
      describe "after submission" do
        subject { click_button submit; page }
        it { is_expected.to have_selector('.alert-success', 'Email sent') }
      end
    end
  end

end