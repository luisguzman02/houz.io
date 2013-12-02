require 'spec_helper'

describe Payment do
  
  it { should be_timestamped_document }
  it { should be_timestamped_document.with(:created) }
  it { should_not be_timestamped_document.with(:updated) }
  
  #fields
  it { should have_field(:method).to_allow(:cash, :credit_card, :check, :bank_transfer, :other).with_default_value_of(:credit_card) }
  it { should have_field :note }
  it { should have_field(:amount).of_type(Float) }

  #relation
  it { should be_embedded_in(:reservation) } 

end