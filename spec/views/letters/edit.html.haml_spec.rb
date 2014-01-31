require 'spec_helper'

describe "letters/edit" do
  before(:each) do
    @letter = assign(:letter, stub_model(Letter,
      :name => "",
      :body => "",
      :document => ""
    ))
  end

  it "renders the edit letter form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", letter_path(@letter), "post" do
      assert_select "input#letter_name[name=?]", "letter[name]"
      assert_select "input#letter_body[name=?]", "letter[body]"
      assert_select "input#letter_document[name=?]", "letter[document]"
    end
  end
end
