require 'spec_helper'

describe Letter do
  
  before do
    @letter = FactoryGirl.build(:letter)
  end

  it { should be_timestamped_document }
  it { should be_timestamped_document.with(:created) }
  it { should_not be_timestamped_document.with(:updated) }
  
  #required
  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:body) }

  #fields
  it { should have_field(:name).of_type(String) }
  it { should have_field(:body).of_type(String) }
  it { should have_field(:document).to_allow(:reservation).with_default_value_of(:reservation)  }
  
  #relation
  it { should belong_to(:company) }
  
end