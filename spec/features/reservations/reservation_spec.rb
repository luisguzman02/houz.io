require 'spec_helper'

RSpec.describe "Reservations", :rsv => :all, type: :feature, ctrl_clean: true do 
  
  before do
    @acc = FactoryGirl.create(:account)
    #warden sign in
    confirm_and_login(account.user)
  end  

  it 'creates new reservation by checking available properties'

  it 'deletes single reservation'
end