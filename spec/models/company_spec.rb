require 'spec_helper'

describe Company do
  
  before do
    @company = FactoryGirl.build(:company)
  end
  
  it { should be_timestamped_document }
  it { should be_timestamped_document.with(:created) }
  it { should be_timestamped_document.with(:updated) }
  
  #required
  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:account) }
  it { should validate_presence_of(:contact) }

  #fields
  it { should have_field(:name).of_type(String) }
  it { should have_field(:logo) }
  
  #relation
  it { should have_one(:account) }
  it { should have_many(:letters) }
  it { should embed_one(:contact).with_autobuild }

  it 'should create a new company' do
    @company.save
    @company.should be_persisted
  end
end