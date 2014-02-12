require 'spec_helper'

describe Account do
  
  before do
    
  end

  let(:acc) { FactoryGirl.create(:account) }

  def add_prop
    p = acc.properties.build(:name => prop_name, :description => prop_desc)
    p.save
    p
  end

  it { should be_timestamped_document.with(:created) }
  it { should be_timestamped_document.with(:updated) }

  # required fields  
  it { should validate_presence_of(:user) }
  #it { should validate_presence_of(:ecommerce_plan) }

  # optional fields
  
  #validations

  #relations
  it { should belong_to(:company) }
  it { should belong_to(:user) }
  it { should belong_to(:ecommerce_plan) }
  it { should have_many(:properties) }
  it { should embed_many(:rates) }
  it { should have_and_belong_to_many(:tenants).of_type(User).as_inverse_of(nil)  }
  it { should have_and_belong_to_many(:owners).of_type(User).as_inverse_of(:agent_accounts)  }
  it { should have_many(:agents).of_type(User).as_inverse_of(:company_account)  }
  
  it 'should create a new account' do
    @account = FactoryGirl.build(:account)    
    @account.save    
    @account.should be_persisted
  end

  it 'is able to create a new property' do
    p = add_prop
    p.should be_persisted
  end

  it 'notify to update to premium if trial period expired' do
    pending
  end

  it 'attach insufficient credits error to the document, if its trying to create more than the allowed' do
    pending
    # add_prop
    # p = add_prop
    # p.should_not be_persisted
    # p.errors.messages[:account].first.should eql 'does not have the enought credits to add more properties'    
  end

  it 'creates 2 default rates on each account' do
    acc.rates.count.should eq 2
    acc.rates.find_by(:name => 'Default').class.should eq Rate
  end

  it 'returns free trial as package name, and user doesnt have a premium package' do
    acc.package.should eq 'Free Trial'
  end

  it 'throws an error when free trial has expired' do    
    acc.created_at = acc.created_at.to_date - 16
    expect { acc.package }.to raise_error(AccountExpiredTrialError)    
  end
end