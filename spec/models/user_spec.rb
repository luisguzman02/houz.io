require 'spec_helper'

describe User do
  
  before do
    @user = FactoryGirl.build(:user)
  end

  it { should be_timestamped_document }
  it { should be_timestamped_document.with(:created) }
  it { should be_timestamped_document.with(:updated) }

  #required fields
  it { should validate_presence_of(:email) }
  it { should validate_presence_of(:role).with_default_valud_of(:owner) }
  it { should validate_presence_of(:active) }
  it { should validate_presence_of(:first_name) }
  it { should validate_presence_of(:last_name) }
  it { should validate_presence_of(:password).on(:create) }
  
  # validations
  it { should validate_length_of(:password).within(8..20) }
  it { should validate_inclusion_of(:role).to_allow(:owner, :tenant, :agent, :admin) }
  
  #optional fields
  it { should have_fields(:title, :nickname).of_type(String) }
    
  # relations
  it { should embed_one(:contact) }
  it { should have_one(:account) }
  it { should have_and_belong_to_many(:agent_accounts).as_inverse_of(:owners) }
  it { should belong_to(:company_account).of_type(Account).as_inverse_of(:agents) }
  it { should have_many(:properties).with_dependent(:destroy) }
  it { should have_many(:reservations) }
  it { should have_many(:bookings).of_type(Reservation).as_inverse_of(:tenant) }


  it 'should create a new user' do
    @user.save
    @user.should be_persisted          
  end
end