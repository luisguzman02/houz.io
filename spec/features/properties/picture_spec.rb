require 'spec_helper'

describe "Property pictures", :js => true, :ppic => true do 
  before do
    @acc = FactoryGirl.create(:account)    
    login_as(@acc.user, :scope => :user)
    fill_basic_info
    click_on 'Save'
  end

  it 'uploads a picture' do
    pending
  end

  it 'shows all the pictures listing' do
    pending
  end

  it 'deletes a picture' do
    pending
  end
end