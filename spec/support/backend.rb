module  BackendHelper

  def login(target='.navbar-form')
    within(target) do
      fill_in 'Email', :with => usr.email
      fill_in 'Password', :with => usr.password
      click_on 'Sign in'
    end    
  end

end

RSpec.configure do |config|
  config.include BackendHelper
end