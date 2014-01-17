module  BackendHelper

  def usr
    @user ||= FactoryGirl.create(:user)
  end
  
  def login(target='.navbar-form')
    visit !target.eql?('.navbar-form') ? login_path : root_path
    within(target) do
      fill_in 'Email', :with => usr.email
      fill_in 'Password', :with => usr.password
      click_on 'Sign in'
    end    
  end

  # Properties
  def prop_name; 'Pink House'; end
  def prop_desc; 'Beautiful Pink House near to the beach'; end

  def create_prop 
    Proc.new { |ix| @acc.properties.create(:name => "#{prop_name} #{ix}", :description => "#{prop_desc} #{ix}") }
  end
  
  # nav bar
  def assert_navbar_option
    within(:xpath, "//ul[@class='nav navbar-nav']/li[@class='active']") do 
      yield
    end
  end
end

RSpec.configure do |config|
  config.include BackendHelper
end