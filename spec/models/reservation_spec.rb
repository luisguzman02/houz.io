require 'spec_helper'

describe Reservation do
  
  before do
    @reservation = FactoryGirl.build(:reservation)
  end
  
  it { should be_timestamped_document }
  it { should be_timestamped_document.with(:created) }
  it { should be_timestamped_document.with(:updated) }

  #required
  it { should validate_presence_of(:rsv_type) }
  it { should validate_presence_of(:check_in) }
  it { should validate_presence_of(:check_out) }

  #fields
  it { should have_field(:rsv_type).to_allow(:regular, :owner_time, :canceled, :agent_block) }
  it { should have_field(:check_in).of_type(Date) }
  it { should have_field(:check_out).of_type(Date) }
  it { should have_field(:num_adults).of_type(Integer).to_allow(1..300) }
  it { should have_field(:num_children).of_type(Integer).to_allow(1..300) }
  it { should have_field(:stage) }
  it { should have_field(:notes) }  
  
  #relation
  it { should belong_to(:user) }
  it { should belong_to(:tenant).of_type(User).as_inverse_of(:bookings) }
  it { should embed_many(:activities) }
  it { should have_many(:rates) }
  it { should embed_many(:payments) }
end