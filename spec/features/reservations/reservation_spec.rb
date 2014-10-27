require 'spec_helper'

RSpec.describe "Reservations", :js => true, :rsv => :all, type: :feature, ctrl_clean: true do 
  
  before do
    @acc = FactoryGirl.create(:account)
    #warden sign in
    login_as(@acc.user, :scope => :user)
  end  

  it 'creates new reservation by checking available properties'

  it 'deletes single reservation'
end