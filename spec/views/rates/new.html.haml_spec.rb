require 'spec_helper'

describe "rates/new" do
  before(:each) do
    assign(:rate, stub_model(Rate,
      :name => "MyString",
      :type => "",
      :always_apply => false,
      :hold_for_return => false
    ).as_new_record)
  end

  it "renders new rate form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", rates_path, "post" do
      assert_select "input#rate_name[name=?]", "rate[name]"
      assert_select "input#rate_type[name=?]", "rate[type]"
      assert_select "input#rate_always_apply[name=?]", "rate[always_apply]"
      assert_select "input#rate_hold_for_return[name=?]", "rate[hold_for_return]"
    end
  end
end
