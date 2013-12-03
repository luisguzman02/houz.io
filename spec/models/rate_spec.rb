require 'spec_helper'

describe Rate do
  
  before do
    @company = FactoryGirl.build(:company)
  end

  it { should be_timestamped_document }
  it { should be_timestamped_document.with(:created) }
  it { should be_timestamped_document.with(:updated) }

  #required
  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:type) }

  #fields
  it { should have_field(:type).to_allow(:rent, :adjustment, :rate, :discount, :commision).with_default_value_of(:rent)  }
  it { should have_field(:name).of_type(String) }
  it { should have_field(:always_apply).of_type(Boolean) }
  it { should have_field(:hold_for_return).of_type(Boolean) }
  it { should have_field(:value_type).to_allow(:amt, :pct) }
  it { should have_field(:value).to_allow(:amt, :pct) }
  it { should have_field(:periodically).of_type(Boolean) }
  
  #relation
  it { should belong_to(:account) }
  it { should have_and_belong_to_many(:properties) }

end