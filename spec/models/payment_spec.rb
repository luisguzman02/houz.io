require 'spec_helper'

RSpec.describe Payment, type: :model, ctrl_clean: true do
  
  it { should be_timestamped_document }
  it { should be_timestamped_document.with(:created) }
  it { should be_timestamped_document.with(:updated) }

  #fields
  it { should have_field(:method).of_type(Symbol).with_default_value_of(:credit_card) }
  it { should have_field(:note).of_type(String) }
  it { should have_field(:amount).of_type(Float) }

  #validations
  it { should validate_presence_of(:method)}
  it { should validate_presence_of(:amount)}
  it { should validate_inclusion_of(:method).to_allow([:cash, :credit_card, :check, :bank_transfer, :other]) }

  #relation
  it { should be_embedded_in(:reservation) } 

end