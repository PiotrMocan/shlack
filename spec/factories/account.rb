FactoryBot.define do
  factory :account do
    email { 'ferd@gmail.com' }
    password { 'qwerty12' }
    user { create(:user) }
  end
end
