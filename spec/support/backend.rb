module  BackendHelper

  def login(usr=nil)
    if usr.nil?
      usr = FactoryGirl.build(:user)
      usr.skip_confirmation!
      usr.save!
    end
    visit login_path
    within('#main_content') do
      fill_in 'Email', :with => usr.email
      fill_in 'Password', :with => usr.password
      click_on 'Sign in'
    end
  end


  # Properties
  def prop_name; 'Pink House'; end
  def prop_desc; 'Beautiful Pink House near to the beach'; end

  def create_prop(acc) 
    Proc.new { |ix| acc.properties.create(:name => "#{prop_name} #{ix}", :description => "#{prop_desc} #{ix}") }
  end
  
  # nav bar
  def assert_navbar_option
    within(:xpath, "//nav[@id='sidebar']/ul/li[@class='active']") do 
      yield
    end
  end

  def fill_basic_info
    visit properties_path
    select :house, :from => 'Property Type'
    fill_in 'Name', :with => prop_name 
    fill_in 'Description', :with => prop_desc
  end

  def confirm_and_login(user)
    user.confirm!
    login_as(user, :scope => :user)
  end  
end

RSpec.configure do |config|
  config.include BackendHelper
end