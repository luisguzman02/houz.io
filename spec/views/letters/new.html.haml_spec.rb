require 'spec_helper'

describe "letters/new" do
  before(:each) do
    assign(:letter, stub_model(Letter,
      :name => "",
      :body => "",
      :document => ""
    ).as_new_record)
  end

  it "renders new letter form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", letters_path, "post" do
      assert_select "input#letter_name[name=?]", "letter[name]"
      assert_select "input#letter_body[name=?]", "letter[body]"
      assert_select "input#letter_document[name=?]", "letter[document]"
    end
  end
end
