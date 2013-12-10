require 'spec_helper'

describe Activity do
  
  before do
    @activity = FactoryGirl.build(:activity)
  end

  it { should be_timestamped_document }
  it { should be_timestamped_document.with(:created) }
  it { should_not be_timestamped_document.with(:updated) }

  #required
  it { should validate_presence_of(:description) }

  #fields
  it { should have_field(:description).of_type(String) }
  
  #relation
  #it { should belong_to(:user) }
  it { should be_embedded_in(:logeable) } 

end