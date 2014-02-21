require 'spec_helper'

describe "Reservations", :js => true, :rsv => :all do 
  
  before do
    @acc = FactoryGirl.create(:account)
    #warden sign in
    login_as(@acc.user, :scope => :user)
  end  

  it 'creates new reservation by checking available properties' do
    pending
  end

  it 'deletes single reservation' do
    pending
  end
end