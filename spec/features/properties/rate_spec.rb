require 'spec_helper'

RSpec.describe "Property rates", :js => true, :prate => true, type: :feature, ctrl_clean: true do 
  before do
    @acc = FactoryGirl.create(:account)    
    login_as(@acc.user, :scope => :user)
    fill_basic_info
    click_on 'Save'
  end

  it 'list default property rates' do    
    click_on 'Rates'
    @acc.rates.each do |r|
      within("#pr_#{r.id}") do
        page.should have_content r.name
      end 
    end
    page.should have_xpath('.//div[@class="row ratelns"]', :count =>  @acc.rates.count)    
  end

  it 'can change values in rates list'

  it 'is able to add more rates to a property rate list'
end