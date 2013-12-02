require 'spec_helper'

describe EcommercePlan do
  
  before do
    @ecommerce_plan = FactoryGirl.build(:ecommerce_plan)
  end

  it { should be_timestamped_document }
  it { should be_timestamped_document.with(:created) }
  it { should_not be_timestamped_document.with(:updated) }

  #required
  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:description) }
  it { should validate_presence_of(:num_items_allowed) }
  it { should validate_presence_of(:price) }

  #fields
  it { should have_field(:name).of_type(String) }
  it { should have_field(:description).of_type(String) }
  it { should have_field(:num_items_allowed).of_type(Integer).with_default_value_of(1) }
  it { should have_field(:price).of_type(Float) }

end