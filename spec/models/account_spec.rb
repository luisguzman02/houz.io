require 'spec_helper'

describe Account do
  
  before do
    @account = FactoryGirl.build(:account)
  end
  it { should be_timestamped_document }
  it { should be_timestamped_document.with(:created) }
  it { should_not be_timestamped_document.with(:updated) }
  
  # required fields  
  it { should validate_presence_of(:user) }

  # optional fields
  it { should have_field(:company).of_type(String) }

  #relations
  it { should belong_to(:company) }
  it { should belong_to(:user) }
  it { should belong_to(:ecommerce_plan) }
  it { should have_many(:properties) }
  it { should have_many(:rates) }
  it { should have_and_belong_to_many(:tenants).of_type(User).as_inverse_of(nil)  }
  it { should have_and_belong_to_many(:owners).of_type(User).as_inverse_of(:agent_accounts)  }
  it { should have_many(:agents).of_type(User).as_inverse_of(:company_account)  }
  
end