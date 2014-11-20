require 'spec_helper'

RSpec.describe Picture, type: :model, ctrl_clean: true do
  it { should belong_to(:property) }
end