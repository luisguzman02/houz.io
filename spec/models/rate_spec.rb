require 'spec_helper'

describe Rate do
  
  before do
    @rate = FactoryGirl.build(:rate)
  end

  it { should be_timestamped_document }
  it { should be_timestamped_document.with(:created) }
  it { should be_timestamped_document.with(:updated) }

  #required
  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:type) }
  it { validate_inclusion_of(:type).to_allow([:rent, :adjustment, :rate, :discount, :commision]) }
  it { validate_inclusion_of(:value_type).to_allow([:amount, :percentage]) }

  #fields
  it { should have_field(:type).of_type(Symbol).with_default_value_of(:rent)  }
  it { should have_field(:name).of_type(String) }
  it { should have_field(:always_apply).of_type(Mongoid::Boolean).with_default_value_of(true) }
  it { should have_field(:hold_for_return).of_type(Mongoid::Boolean) }
  it { should have_field(:value_type).of_type(Symbol).with_default_value_of(:amount) }
  it { should have_field(:value).of_type(Float) }
  it { should have_field(:periodically).of_type(Mongoid::Boolean) }
  
  #relation
  it { should belong_to(:account) }
  it { should have_and_belong_to_many(:properties) }

  it 'should create new rate' do
    @rate.save
    @rate.should be_persisted
  end
end