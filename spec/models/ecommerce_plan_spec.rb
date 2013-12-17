require 'spec_helper'

describe EcommercePlan do
  
  before do
    @ecommerce_plan_free = FactoryGirl.create(:ecommerce_plan, :owner_free_pack)
    @plan_owner_plus = FactoryGirl.create(:ecommerce_plan, :owner_plus_pack)
    @agency_pack = FactoryGirl.create(:ecommerce_plan, :agency_pack)
    @unlimited_pack = FactoryGirl.create(:ecommerce_plan, :unlimited_pack)
  end

  it { should be_timestamped_document }
  it { should be_timestamped_document.with(:created) }
  it { should be_timestamped_document.with(:updated) }

  #required
  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:description) }
  it { should validate_presence_of(:num_items_allowed) }
  it { should validate_presence_of(:price) }
  it { should validate_uniqueness_of(:name) }

  #fields
  it { should have_field(:name).of_type(String) }
  it { should have_field(:description).of_type(String) }
  it { should have_field(:num_items_allowed).of_type(Integer).with_default_value_of(1) }
  it { should have_field(:price).of_type(Float) }

  it 'successfully creates a new ecommerce plan' do
    @ecommerce_plan_free.should be_persisted
  end

  it 'should have 4 ecommerce plans created by default' do
    EcommercePlan.all.count.should eql(4)
  end
end