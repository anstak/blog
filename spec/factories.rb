FactoryGirl.define do
  factory :user do
    sequence(:name)  { |n| "Person #{n}" }
    sequence(:email) { |n| "person_#{n}@example.com"}
    password "001137"
    password_confirmation "001137"

    factory :admin do
       admin true
    end

  end

  factory :micropost do
    content "Lorem ipsum"
    user
  end

end
