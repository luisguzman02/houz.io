require 'spec_helper'

describe Company do
  
  before do
    @company = FactoryGirl.build(:company)
  end
  
  it { should be_timestamped_document }
  it { should be_timestamped_document.with(:created) }
  it { should_not be_timestamped_document.with(:updated) }
  
  #required
  it { should validate_presence_of(:name) }

  #fields
  it { should have_field(:name).of_type(String) }
  it { should have_field(:contact).of_type(Contact) }
  it { should have_field(:logo) }
  
  #relation
  it { should have_one(:account) }
  it { should have_many(:letters) }

end