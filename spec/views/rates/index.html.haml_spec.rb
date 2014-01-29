require 'spec_helper'

describe "rates/index" do
  before(:each) do
    assign(:rates, [
      stub_model(Rate,
        :name => "Name",
        :type => "",
        :always_apply => false,
        :hold_for_return => false
      ),
      stub_model(Rate,
        :name => "Name",
        :type => "",
        :always_apply => false,
        :hold_for_return => false
      )
    ])
  end

  it "renders a list of rates" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    assert_select "tr>td", :text => "".to_s, :count => 2
    assert_select "tr>td", :text => false.to_s, :count => 2
    assert_select "tr>td", :text => false.to_s, :count => 2
  end
end
