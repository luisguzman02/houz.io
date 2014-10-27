require 'spec_helper'

RSpec.describe "user session", :js => true, type: :feature, ctrl_clean: true do   

  it "signs me in from login page" do    
    login
    expect(page).to have_content 'Create new Property'    
  end

  it "logs me out" do
    login
    click_link 'Logout'
    expect(page).to have_link 'Login' 
  end

end