FactoryBot.define do
  factory :user do
    # factory for user
    name { 'John Doe' }
    age { 18 }
    gender { 'female' }

    trait :young do
      age { 16 }
    end
  end
end
