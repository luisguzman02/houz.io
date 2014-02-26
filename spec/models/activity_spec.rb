require 'spec_helper'

describe Activity do
  
  before do
    @activity = FactoryGirl.build(:activity)
  end

  it { should be_timestamped_document }
  it { should be_timestamped_document.with(:created) }
  it { should_not be_timestamped_document.with(:updated) }

  #required
  it { should validate_presence_of(:logeable) }
  it { should validate_presence_of(:action) }
  it { should validate_presence_of(:user) }

  #fields
  it { should have_field(:description).of_type(String) }
  it { should have_field(:action).of_type(Symbol) }
  
  #relation
  it { should belong_to(:user) }
  it { should belong_to(:logeable) } 

end