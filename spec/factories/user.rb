FactoryGirl.define do
  sequence :email do |n|
    "neiltyson#{n}@hayden.org"
  end

  sequence :username do |n|
    "neiltyson#{n}"
  end

  factory :user do
    email
    username

    password 'cosmos123'
    password_confirmation 'cosmos123'

    trait :admin do
      admin true
    end
  end
end
