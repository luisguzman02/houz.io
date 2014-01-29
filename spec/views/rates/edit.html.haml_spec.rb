require 'spec_helper'

describe "rates/edit" do
  before(:each) do
    @rate = assign(:rate, stub_model(Rate,
      :name => "MyString",
      :type => "",
      :always_apply => false,
      :hold_for_return => false
    ))
  end

  it "renders the edit rate form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", rate_path(@rate), "post" do
      assert_select "input#rate_name[name=?]", "rate[name]"
      assert_select "input#rate_type[name=?]", "rate[type]"
      assert_select "input#rate_always_apply[name=?]", "rate[always_apply]"
      assert_select "input#rate_hold_for_return[name=?]", "rate[hold_for_return]"
    end
  end
end
