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

  factory :post do
    name "Lorem ipsum"
    content "Lorem ipsum dolor sit amet, consectetur adipisicing elit. Suscipit ea quasi quam veritatis ullam maiores"
    user
  end

end
