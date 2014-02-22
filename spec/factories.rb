FactoryGirl.define do  
  factory :company do
    name 'SecondHouz'
    contact { FactoryGirl.build(:contact) }
    account { FactoryGirl.build(:account) }    
  end
  factory :ecommerce_plan do
    trait :basic_pack do
      name 'Property Owner Plus - 5 Properties Pack'
      description 'Administer up to 5 properties 4.99 per Month'
      num_items_allowed 5
      price 4.99
    end
    trait :agency_pack do
      name 'Agency Pack'
      description 'Administer up to 50 properties 24.99 per Month'
      num_items_allowed 50
      price 24.99
    end
    trait :unlimited_pack do
      name 'Unlimited Properties For 99.99 Month'
      description '--- pending ---'
      num_items_allowed 500
      price 99.99
    end
  end
  factory :letter do
    name 'confirmation email'
  end
  factory :activity do
    description 'Jim created reservation'
  end
  factory :account do
    user { FactoryGirl.create(:user) }
    #ecommerce_plan { EcommercePlan.free || FactoryGirl.create(:ecommerce_plan, :owner_free_pack) }
  end
  factory :user do
    sequence :email do |n|
      "user_#{n}@boloflix.com"
    end
    first_name 'Adbeel'
    last_name 'Guzman'
    password '123456'
    role :admin
    trait :owner do
      role :owner
    end          
    trait :agent do
      role :agent
    end   
    trait :tenant do
      role :tenant
    end       
  end
  factory :rate do
    name 'Regular Rent'
    type :rent    
  end
  factory :property do
    name 'House Beach Front'
    description 'Beatiful House in Front of teh Beach at Rocky Point Mexico.'
    contact { FactoryGirl.build(:contact)  }
    user { FactoryGirl.create(:user) }
    account { FactoryGirl.create(:account) }
  end  
  factory :reservation do
    check_in Date.today
    check_out Date.today + 2
    user { FactoryGirl.create(:user) }
    tenant { FactoryGirl.create(:user, :tenant) }
    property { FactoryGirl.create(:property)  }
  end
  factory :contact do
    address { FactoryGirl.build(:address) }
    phones { [FactoryGirl.build(:phone)] }
    websites { [FactoryGirl.build(:website)] }
    emails { [FactoryGirl.build(:email)] }
  end  
  factory :address do
    street '1234 Main St'
    city 'Seattle'
    state 'WA'
    zip_code '12345'
  end
  factory :phone do
    of_type :mobile
    number '412-555-4838'
  end
  factory :website do
    url 'http://www.boloflix.com'
    description 'boloflix blog'
  end
  factory :email do
    address 'master@boloflix.com'
    of_type :company
  end
end