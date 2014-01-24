require 'spec_helper'

describe "sign up process", :js => true, :devise => :su do 

  before do
    @free_plan = FactoryGirl.create(:ecommerce_plan, :owner_free_pack) 
    @not_persisted_user = FactoryGirl.build(:user)
    sign_up
  end

  def sign_up
    visit new_user_registration_path
    within("form#new_user") do
      fill_in 'Email', :with => @not_persisted_user.email
      fill_in 'First name', :with => @not_persisted_user.first_name
      fill_in 'Last name', :with => @not_persisted_user.last_name
      fill_in 'Password', :with => @not_persisted_user.password  
      fill_in 'Password confirmation', :with => @not_persisted_user.password      
      click_on 'Create an account'
    end
  end

  it "arrives to welcome start page with succesfully user creation message" do    
    page.should have_content 'You have signed up successfully.' 
    page.should have_content 'Please choose the option that best suits to your needs and start using Secondhouz.' 
  end

  it 'creates new account after choosing free plan and redirect to nre property page' do
    within('#free_plan') do
      click_on 'Start Now'     
      u = User.find_by(:email => @not_persisted_user.email)
      u.account.ecommerce_plan.should eq(@free_plan)
      page.should have_content 'New Property'            
    end    
  end

end