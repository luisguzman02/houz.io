require 'spec_helper'

RSpec.describe Guest, type: :model, ctrl_clean: true do
  
  it { should be_timestamped_document.with(:created) }

  #fields
  it { should have_field(:name).of_type(String) }
  it { should have_field(:email).of_type(String) }
  it { should have_field(:source).of_type(String) }

  #validations
  it { should validate_presence_of(:name)}
  it { should validate_presence_of(:contact)}

  #relation
  it { should be_embedded_in(:reservation) } 
  it { should embed_one(:contact) }
end