require 'spec_helper'

describe "letters/show" do
  before(:each) do
    @letter = assign(:letter, stub_model(Letter,
      :name => "",
      :body => "",
      :document => ""
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(//)
    rendered.should match(//)
    rendered.should match(//)
  end
end
