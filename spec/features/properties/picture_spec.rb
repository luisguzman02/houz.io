require 'spec_helper'

RSpec.describe "Property pictures", :ppic => true, type: :feature, ctrl_clean: true do 
  let(:account) { FactoryGirl.create(:account) }
  before do
    confirm_and_login(account.user)
    fill_basic_info
    click_on 'Save'
  end

  it 'uploads a picture'

  it 'shows all the pictures listing'

  it 'deletes a picture'
end