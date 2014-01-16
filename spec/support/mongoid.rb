# mongoid.rb
RSpec.configure do |config|
  #I'm specifying load mongoid matchers only for model since there are some conflict with capybara have_field matcher
  config.include Mongoid::Matchers, :type => :model
end