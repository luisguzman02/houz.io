require 'spec_helper'

describe "rates/show" do
  before(:each) do
    @rate = assign(:rate, stub_model(Rate,
      :name => "Name",
      :type => "",
      :always_apply => false,
      :hold_for_return => false
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Name/)
    rendered.should match(//)
    rendered.should match(/false/)
    rendered.should match(/false/)
  end
end
