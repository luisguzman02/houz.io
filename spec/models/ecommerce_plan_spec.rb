require 'spec_helper'

RSpec.describe EcommercePlan, type: :model, ctrl_clean: true do
  
  before do
    @basic_pack = FactoryGirl.create(:ecommerce_plan, :basic_pack)
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
    expect(@basic_pack).to be_persisted
  end

  it 'should have 3 ecommerce plans created by default' do
    expect(EcommercePlan.all.count).to eql(3)
  end
end