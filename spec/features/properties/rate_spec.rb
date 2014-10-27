require 'spec_helper'

RSpec.describe "Property rates", :js => true, :prate => true, type: :feature, ctrl_clean: true do 
  let(:account) { FactoryGirl.create(:account) }
  
  before do
    confirm_and_login(account.user)
    fill_basic_info
    click_on 'Save'
  end

  it 'list default property rates'

  it 'can change values in rates list'

  it 'is able to add more rates to a property rate list'
end