FactoryGirl.define do
  sequence :email do |n|
    "neiltyson#{n}@hayden.org"
  end

  factory :user do
    email
  end
end
