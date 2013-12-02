FactoryGirl.define do  
  factory :user do
    email 'master@boloflix.com'
    first_name 'Adbeel'
    last_name 'Guzman'
    trait :owner do
      role :owner
    end          
    trait :agent do
      role :owner
    end   
    trait :tenant do
      role :owner
    end   
  end
  factory :contact do
    addresses { [FactoryGirl.build(:address)] }
    phones { [FactoryGirl.build(:phone)] }
    websites { [FactoryGirl.build(:website)] }
    emails { [FactoryGirl.build(:email)] }
  end  
  factory :address do
    road '1234 Main St'
    city 'Seattle'
    state 'WA'
    postal_code '12345'
  end
  factory :phone do
    of_type 'mobile'
    number '412-555-4838'
  end
  factory :website do
    url 'http://www.boloflix.com'
    description 'boloflix blog'
  end
  factory :email do
    address 'master@boloflix.com'
  end
end